module 0x4f2c1e3f24943ad61c06fb97bda89023e855530579f00ddc18f05c0930e179e8::mtct {
    struct MTCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTCT>(arg0, 6, b"MTCT", b"Myturncrypto", x"4d795475726e43727970746f20546f6b656e0a4d616b6520697420506f737369626c6520466f722045766572796f6e6520546f2057696e0a4974277320596f7572205475726e20546f2057696e0a4974277320596f7572205475726e20546f204d616b65204d696c6c696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wad_841c7109c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

