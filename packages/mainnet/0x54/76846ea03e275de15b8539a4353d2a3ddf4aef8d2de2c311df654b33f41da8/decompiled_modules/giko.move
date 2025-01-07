module 0x5476846ea03e275de15b8539a4353d2a3ddf4aef8d2de2c311df654b33f41da8::giko {
    struct GIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIKO>(arg0, 6, b"GIKO", b"GIKOsui", b"Hellloooo!! Itteyoshiiii~~~!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giko_surprise_b9fa3598c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

