module Jekyll
    module Converters
        class Markdown
            class RDiscountParser
                #Matches any h2-h6 tag with or without attributes
                START_PATTERN = /\<(?<tag>h[2-6])\s*(?<attr>(\w+(\=(\"|\')(\w|\s)*(\"|\'))*\s*)*)\>/

                #Matches any ending h2-h6 tag
                END_PATTERN = /\<\/\s*(?<tag>h[0-6])\s*\>/

                #The tag that was matched in START_PATTER, END_PATTER and the content between them
                CONTENT = /\<(?<tag>h[1-6])\s*(?<attr>(\w+(\=(\"|\')(\w|\s)*(\"|\'))*\s*)*)\>(?<content>(\w|\s|\d|\n|[\!\"\#\&\(\)\=\?\\\/\.-])*)?\<\/\s*(?<tag>h[0-6])\s*\>/

                def matches(ext)
                    ext =~ /^\.html$/i
                end

                def output_ext(ext)
                    ext
                end

                alias_method :original_convert, :convert
                def convert(content)
                    
                    return original_convert(content).gsub CONTENT do |match|
                        #Remember
                        #content = the content between the tag
                        #attr = the attributes of the tag
                        #tag = the tag itself

                        tag = $~[:tag]
                        attr = $~[:attr]
                        content = $~[:content]
                        id = content.gsub /\s+/, '-'

                        <<-eos
                            <#{tag} #{attr} id=\"#{id}\">
                                <a href=\"\##{id}\">#{content}</a>
                                <a href="#top"> *</a>
                            </#{tag}>
                        eos
                    end
                end
            end
        end
    end
end
