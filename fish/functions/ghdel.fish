function ghdel 
  co
  for i in (git branch | grep rudihermanto); 
	  git br -D (string trim $i)
  end
end
