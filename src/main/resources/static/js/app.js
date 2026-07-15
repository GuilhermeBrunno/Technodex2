function toggleNotif(event) {
    event.stopPropagation();
    var panel = document.getElementById('notifPanel');
    if (panel) {
        panel.classList.toggle('open');
    }
}

document.addEventListener('click', function (e) {
    var panel = document.getElementById('notifPanel');
    var btn = document.querySelector('.notif-btn');
    if (panel && panel.classList.contains('open')) {
        if (!panel.contains(e.target) && !(btn && btn.contains(e.target))) {
            panel.classList.remove('open');
        }
    }
});

function toggleSidebar() {
    var sb = document.querySelector('.sidebar');
    var backdrop = document.querySelector('.sidebar-backdrop');
    if (sb) sb.classList.toggle('open');
    if (backdrop) backdrop.classList.toggle('open');
    document.body.classList.toggle('sidebar-open-lock');
}

// Fecha o menu ao clicar em um link dentro dele (util em telas menores)
document.addEventListener('click', function (e) {
    var sb = document.querySelector('.sidebar');
    if (sb && sb.classList.contains('open') && e.target.closest('.sidebar-nav a')) {
        toggleSidebar();
    }
});

// Fecha o menu ao pressionar Esc
document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') {
        var sb = document.querySelector('.sidebar');
        if (sb && sb.classList.contains('open')) toggleSidebar();
    }
});
