// Angely shared theme toggle
(function(){
  var html = document.documentElement;
  var saved = localStorage.getItem('angely-theme') || 'light';
  html.setAttribute('data-theme', saved);

  // Create floating toggle button if not present
  if (!document.querySelector('.theme-float')) {
    var btn = document.createElement('button');
    btn.className = 'theme-float';
    btn.title = '切换深浅色主题';
    btn.textContent = saved === 'light' ? '🌙' : '☀️';
    btn.addEventListener('click', function(){
      var next = html.getAttribute('data-theme') === 'light' ? 'dark' : 'light';
      html.setAttribute('data-theme', next);
      localStorage.setItem('angely-theme', next);
      btn.textContent = next === 'light' ? '🌙' : '☀️';
    });
    document.body.appendChild(btn);
  }
})();
