module 0x8af24c2ec56953818b16e8dddb0148a76dc1db689b837fbec3394d7fadd95daf::dsadas {
    struct DSADAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSADAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSADAS>(arg0, 6, b"DSADAS", b"sda", b"asdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://play-lh.googleusercontent.com/kWxFfgbjiye2x6o84-CDyPikgh3dLpcoyh3icmgdl9kDjf70RGj11p4dMTH-vWY_sC0=w240-h480-rw")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<DSADAS>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<DSADAS>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

