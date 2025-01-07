module 0x63fbd9443d1f0fcc97f3301bdc76090c55292c6ae97ee6fa2f2914d251acdc2d::suick {
    struct SUICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICK>(arg0, 6, b"Suick", b"suick", x"596f75206d757374206265207369636b20696620796f75207468696e6b205375692077696c6c206d616b652069742074686973206379636c650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suick_5bb4f5d9ff_4baecb3674.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

