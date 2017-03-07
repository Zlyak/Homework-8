require 'date'
class Geeks
    
    def call(env)
        #[200, {'Content-Type'=> 'text/plain'}, ["<strong>hello world</strong>"]]
        render_postes
        @request = Rack::Request.new(env)
        case @request.path
        when '/'
            Rack::Response.new(render("index.html.erb"))
        when '/post'
            Rack::Response.new(render("post.html.erb"))
#         when '/post_form'
#             Rack::Response.new do |response|
#                 response.set_cookie('geek_name',
#                 @request.params["name_123"])
#                 response.redirect('/')
#             end
        when '/add_post'
            Rack::Response.new do |response|
                author=@request.params["author"]
                head=@request.params["head"]
                content=@request.params["content"]
                add_post(author, head, content)
                response.redirect('/')
            end
        else
            posted_name=@request.params["name_123"] || ''
            Rack::Response.new("Not found!#{posted_name}", 404)
        end
        
    end
    
    def render(filename)
        path=File.expand_path("../../views/#{filename}", __FILE__)
        ERB.new(File.read(path)).result(binding)
    end
    
    def geek_name
        @request.cookies['geek_name'] || "GEEEEEEEEEEKname"
    end
    
    def render_postes
        f = File.open("lib/post.rb")
        @postes=f.read
        f.close
        
    end
    
    def add_post(author, head, content)
        date=Date.today()
        cur_date=date.strftime(' %d-%b-%Y ')
        f = File.open('lib/post.rb', 'a')
        postes="<div class=\"post\">\n
    <h2 class=\"title\"><a href=\"#\">#{head}</a></h2>\n
    <p class=\"meta\"><span class=\"date\">#{cur_date}</span><span class=\"posted\">Posted by <a href=\"#\">#{author}</a></span></p>\n
        <div style=\"clear: both;\">&nbsp;</div>\n
        <div class=\"entry\">\n
            <p>#{content}</p>\n
            <p class=\"links\"><a href=\"#\" class=\"more\">Read More</a><a href=\"#\" title=\"b0x\" class=\"comments\">Comments</a></p>\n
        </div>\n
</div>"
        f.puts("#{postes}")
        f.close
    end
end

