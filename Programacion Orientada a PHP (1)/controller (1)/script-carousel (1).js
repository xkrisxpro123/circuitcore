document.addEventListener('DOMContentLoaded', function() {
    const track = document.querySelector('.carousel-track');
    const items = Array.from(track.children);
    const prevButton = document.querySelector('.carousel-button.prev');
    const nextButton = document.querySelector('.carousel-button.next');
    const itemWidth = items[0].getBoundingClientRect().width;
    let currentIndex = 0;

    function moveToIndex(index) {
        track.style.transform = `translateX(-${itemWidth * index}px)`;
    }

    nextButton.addEventListener('click', () => {
        currentIndex = Math.min(currentIndex + 1, items.length - 5);
        moveToIndex(currentIndex);
    });

    prevButton.addEventListener('click', () => {
        currentIndex = Math.max(currentIndex - 1, 0);
        moveToIndex(currentIndex);
    });
});

