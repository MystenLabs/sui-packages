module 0xbca26147117e67093748582c9165038d31d798c25fe47fb003a2ca6079a7bc30::cdjawn {
    struct CDJAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDJAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDJAWN>(arg0, 9, b"CDJAWN", b"Cooper DeJawn eagle 4 life", b"Cooper DeJean the goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.clubs.nfl.com/image/upload/t_editorial_landscape_6_desktop/f_png/eagles/qwhtixkqizeozu2pilbg.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CDJAWN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDJAWN>>(v2, @0x6cfe3d5af3171843fdb35d1a8658522e7a0873990dc465ea0b91197ee4c049ca);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CDJAWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

