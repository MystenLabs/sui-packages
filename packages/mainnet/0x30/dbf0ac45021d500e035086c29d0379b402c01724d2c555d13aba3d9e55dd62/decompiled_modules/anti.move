module 0x30dbf0ac45021d500e035086c29d0379b402c01724d2c555d13aba3d9e55dd62::anti {
    struct ANTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTI>(arg0, 6, b"ANTI", b"evucexvec", b"exchange stock timelines anti stock exchange", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1769602837504.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANTI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

