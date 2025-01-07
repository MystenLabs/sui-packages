module 0xb3577b33177504d9bc6196eef8d8be5e5bea94b335d3fda46405bcd590e254ca::ponk {
    struct PONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONK>(arg0, 6, b"PONK", b"PONK SUI", b"PONK ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035066_d2dfa33064.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

