document.addEventListener('DOMContentLoaded', () => {
  const city = 'mycity';
  const language = 'en';
  const format = '%C<br>---------------<br>Temp \u00A0 \u00A0 > %t<br>Wind \u00A0 \u00A0 > %w<br>Rain \u00A0 \u00A0 > %p<br>Pressure > %P<br>Humidity > %h';
  const url = `https://wttr.in/${city}?format=${format}&lang=${language}`;

  fetch(url)
    .then(response => response.text())
    .then(data => {
      const weatherInfo = data.trim();
      const weatherElement = document.getElementById('weather');
      weatherElement.innerHTML = weatherInfo;
    })
    .catch(error => {
      const weatherElement = document.getElementById('weather');
      weatherElement.textContent = "It's probably nice outside :)"
    });
});
