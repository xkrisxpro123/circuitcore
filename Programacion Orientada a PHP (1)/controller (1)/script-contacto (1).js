document.getElementById('contactForm').addEventListener('submit', function(event) {
    event.preventDefault(); 
    
    
    const formData = new FormData(this);
    
    fetch('/send-email', {
      method: 'POST',
      body: formData
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Error en la solicitud de envío');
      }
      return response.json();
    })
    .then(data => {
      alert('¡Correo enviado correctamente!');
      console.log(data);
    })
    .catch(error => {
      console.error('Error:', error);
      alert('Hubo un problema al enviar el correo. Por favor, intenta de nuevo más tarde.');
    });
  });
  