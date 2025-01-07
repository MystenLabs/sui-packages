module 0x116188793b05065f05ea0a264010e2c7d7053f773fb7b924d407df98696e05c4::plur {
    struct PLUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUR>(arg0, 6, b"PLUR", b"Plurality", x"537570706f72742061206265747465722066757475726520666f722064656d6f6372616379200a0a436c61696d20796f75722066726565200a45626f6f6b205044462045505542202620417564696f626f6f6b200a0a506c7572616c6974793a2054686520467574757265206f6620436f6c6c61626f72617469766520546563686e6f6c6f677920616e642044656d6f63726163792062792040676c656e7765796c2c204061756472657974202620636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Plurality_png_963f8b7010.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

