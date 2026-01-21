module 0xac4fca60a99f83e8d4f0142aa15f0aa51a1b0c823c5863995dba8995fcfb6870::jackson {
    struct JACKSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<JACKSON>(arg0, 6, b"JACKSON", b"JACKSON.", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRnwDAABXRUJQVlA4IHADAAAQFACdASqAAIAAPm02mEkkIqKhJRGoKIANiWMG+OUNELx7W6sqQz8GvxV5Uzu7+Q2LhTgPEj6UXmA/Wn0Sf1m9wHoAfth1j3oAfq76Z3softl+2ntT17+uJ08DA0i6PVJ5bM92vF2xhUMomq2gY//qIZHl2bS8PiXQX2YLTF22jvEwr1tFMg7W36DBS6ptjD2j/WGOfILzc22xs/n1pDC5k/I/UT/7RdqAAP7r6jlx9/9tDuxLmzN/+xmoE7h1xIfZsiZDNRvL/Lcs+6xvB0RDD7ey+gL+a4oL3BnA9BAgGz8E8xtPkPLgFB2gNEwlqO05fOlVD76eOiS0lSUxxDB6SvnDMHH+rj9BO1XaF/K6vbJ5EinC6Rbopg67kQewbQHSzXms6g8jBW3xfRKBsFV2huVFcvOeBDiQLgf7xcf2J+YXQnVE/yadlzYVN6sQbQS2nzpB3iepT5MIDMkfJSTCH4SqZOqcEhOsWsa+klTHSKs/W/x1DG0yccdIcf4WcfB96Z6qXbZ3JtaG1/K8/1Xp3jqkN2WyLgjkV6ovv//OIbys+e6HWVFS99I0cjFxP/96ssvSkxCw3N5Gwq+z70K5pFYLhb2gxIq49/9b+NiBvpmMvQKajbRr/dAJobqbNLpunoVuWTPldjT8cbxAj8keocSGYtFMaZBvx/tgSofgyhIwmmWq0jTPdg4Mpdimeh3tL8z4fawOx+2m+2tDC7K4+92v10n37deduxyUrMYphJi6rvyrxxRd8PCNWqx9bpZUvGZ28EfVFYrnwkz6Pc2jbrPGBycxX8Ft0+n2TKORbMO3UR90S+LBgLAZTZKcRDVcciv8DtCmtSDRvJs7Ro1gKKJsRF0KAbs0rJ1JA9kjBTlCQxANzYW+Z9Gvpt4vmaPxJWFdeSr9NwfJrmlbXF0nEJwiu+uFKjB01tusm2fdoMdYnpeKO7XogZvu7vkBQiAqvQJ6xFlrmMYXvwp0nZ8HjA23ONyLjiYRYZ68nB82RARRu15fY5+2Yk3bzKqH2bn1jbWkcGzV+88/P1kHyYy1K5NhFCENEQPIBm13B9mxISjLI6miB5fQtlAWXANpCTs8DrxJ/mdRZ/IGuo4VMRgmcbPKZrnrR+zKZohZ87Hzp9mMkSRQwDKzMZttSGGNWEs2c45oycOWzo35L26VqAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACKSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

