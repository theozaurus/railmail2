module RailmailHelper
  def delivery_body(d)
    
    raw = d.raw
    return raw.body unless raw.multipart?
    
    html_parts = raw.parts.select {|p| p.content_type == 'text/html'}.map {|p| p = p.body}
    plain_parts = raw.parts.select {|p| p.content_type == 'text/plain'}.map {|p| p = %(<pre class="plain_text">) + p.body + %(</pre>)}
    other_parts = (raw.parts - html_parts - plain_parts).map {|p| p.body }
    
    part = html_parts.first || plain_parts.first || other_parts.first
    
  end
end
