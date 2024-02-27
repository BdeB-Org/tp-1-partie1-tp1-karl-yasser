
let intro = document.querySelector('.intro');
let logo = document.querySelector('.logo-header');
let logoSpan = document.querySelectorAll('.logo');

window.addEventListener('DOMContentLoaded', ()=>{

    setTimeout(() => {

        logoSpan.forEach((span, idx) => {

            setTimeout(() => {
                span.classList.add('active');
            }, (idx + 1) * 400)
        });


        setTimeout(() => {
            logoSpan.forEach((span, idx) => {

                setTimeout(() => {
                    span.classList.remove('active');
                    span.classList.add('fade');


                },(idx + 1) * 400)

            })


        },2000);

        setTimeout(()=> {

            intro.style.top = '-100vh';
        },2300)


    })
})


const myslide = document.querySelectorAll('.myslider'),
dots = document.querySelectorAll('.dots');

let counter = 1;
slidefun(counter);

let timer = setInterval(autoslide, 8000);

function autoslide(){
    counter+=1;
    slidefun(counter);
}
function plusSlides(n){
    counter+=n;
    slidefun(counter);
    resetTimer();
}

function currentSlide(n){

    counter = n;
    slidefun(counter);
    resetTimer();
}

function resetTimer(){
    clearInterval(timer);
    timer= setInterval(autoslide,8000);
}

function slidefun(n) {
    let i;
    for (i = 0; i < myslide.length; i++) {
        myslide[i].style.display = "none";
    }
    for (i = 0; i < dots.length; i++) {
        dots[i].classList.remove('active');
    }
    if (n > myslide.length) {
        counter = 1;
    } else if (n < 1) {
        counter = myslide.length;
    }
    myslide[counter - 1].style.display = "block";
    dots[counter - 1].className += " active";
}

document.querySelector('.prev').addEventListener('click', () => plusSlides(-1));
document.querySelector('.next').addEventListener('click', () => plusSlides(1));
