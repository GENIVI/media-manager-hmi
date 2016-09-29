#include <QGuiApplication>
#include <QQuickView>

#define MEDIA_MANAGER_POC_SURFACE_ID 5100

int main(int argc, char *argv[])
{
    setenv("QT_QPA_PLATFORM", "wayland", 1); // force to use wayland plugin
    setenv("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1", 1);

    QGuiApplication app(argc, argv);

    QQuickView view(QUrl(QStringLiteral("qrc:/MediaPlayer/MediaPlayer.qml")));

    // Set the surface ID
    view.setProperty("IVI-Surface-ID", MEDIA_MANAGER_POC_SURFACE_ID);

    view.show();

    return app.exec();
}

