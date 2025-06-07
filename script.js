let topics = [];

fetch('topics.json')
  .then(response => response.json())
  .then(data => {
    topics = data;
  });

document.getElementById('nextBtn').addEventListener('click', () => {
  if (topics.length === 0) return;
  const random = topics[Math.floor(Math.random() * topics.length)];
  document.getElementById('category').innerText = `类别：${random.category}`;
  document.getElementById('question').innerText = random.topic;
});