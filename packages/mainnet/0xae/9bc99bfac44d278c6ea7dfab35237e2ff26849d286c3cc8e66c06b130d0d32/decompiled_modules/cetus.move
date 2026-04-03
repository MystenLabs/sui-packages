module 0xae9bc99bfac44d278c6ea7dfab35237e2ff26849d286c3cc8e66c06b130d0d32::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<CETUS>(arg0, 6, b"CETUS", b"Cetus", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRkQEAABXRUJQVlA4IDgEAABQFwCdASqAAIAAPm0wl0ekIqIhKpMZeIANiWUA1S1H4waH9tk2UD+79oX9n5YI/O/U8IOv5vBMqu8Z+kemAxtefdnU+kOBJ+0ntAGTUjnqQigwJm5lBKRG6shlM65qg8JdgUoB+N3ecBcHOzu+1QwtOQHBEuVtv+WKoHD3w215L75uvWvRwt5hb+YwuF1VfeDxy1Lxxv+Ueb+SzlDA2uTBXj27mo5sG6vzMQX0ZoXg3FukGrU0F3kKmj+b2Udol1JOq4AA/vjqf/qVv10SEkKAAAy80Bu4zHhQ1XFNgz3fVEDqdqtYoQNopLn9qbh7wah0P0jp0a1Q3qE/NwiJYjP2ev3YdthYqeQq3N9tvkT+bxnuXwN1xo5ONs2dYsw3+dIPIk5QesAIHB5D6yXmO1PVJdqUfYeB+a3tb5v9gBtBi/Eb9cRT2r/4X1D3/M9iaMbyfHF/VZlrAuAKynmB6VWUWZhe616/VugM2nhA3sUgSTIsF+29UtkfThrr1UEFDZ4sGIHruvfIcJ6M9kGK1WHUPh66abaVfUlR+v6Q13J+vbqAFp2SEc3yhEptmd4DQvCkh5pKYgObbawvth3e7iX7+6dIyFeS07ljkryck9sgv+xEaLbaxDrqUZXb44N01ReN8NC7q5m8JeXChN6YlGro5nqyj228KOMBPXG8sHyhsXkRlRylEtxDoeZNnZL0RHqF+Vd6yFQpPvykVx23RNm+XKvfSkZ68KDmG0XQ0ynmwpeOnoe2DKFqDBoPSehcraLaDaXL/h9irBN0/hpyzM7L/23aChDf8IKpFGX5kY7SXjAP6NLXQeiHzqArR0juxdn7eU5f0LL/bzttpW2pu6bHBLZj825aVXpfOstbyzNCpSxgLs6O0ZYiFid99DuQZoqlf9feD67Xm1fxqSfwPAo2C9476upUzzQJkFeRe/pFQkdA0kUH+3J+H7YvDW86Jm0N2fY9paNVOu7AhCejFyen+2K6wNpcaSqkEOoKEpsM2Fl+5yS+zpFwtoMQkUnTL5vL9ARov3fobOdMCE0jEwRqfi/Pn/if4xPmeGsw+ZvoVf7Q+e3dWF/vPZW2DzAig7AfjFhLYieJRRnyNOABejqKMk/zuEiJZN4z6D3SayPjEtdqoqVgUMWW3JJGPHUjsXVGzNFlsuVe7/hsliaoqQCH4AvmKwfhAkfWtCr1/7/jF6zxD4MA9fya9XAekoylK+yTA6G803AyCKxPnklGuJBTUXQLPmKicB2hyErTxD41zhpPGbL17nGOVy9lKMTBMnKoqi8RbDttHltRCdCMGZbOEjRdCScQrpxnMNMVXiFANfAFyd7RQX5b75iCgZMMqPgdDsYal7tq/2bJ5qAeiKa8aahfq4rSmmOjikul8wsAICfg9Ee/IMjJXMbVz3lxfBTTqIRubtyf4JQRSy8+RbOvevgCsgAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CETUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

