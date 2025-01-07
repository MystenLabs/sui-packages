module 0xad41e543e9e56a8ba3b716a4653d8c80434fb0b0ca47e1fbeb37798836e5366a::smew {
    struct SMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEW>(arg0, 6, b"SMEW", b"SUIMEW", b"MEOWWW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIMEOW_f1931acd6b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

