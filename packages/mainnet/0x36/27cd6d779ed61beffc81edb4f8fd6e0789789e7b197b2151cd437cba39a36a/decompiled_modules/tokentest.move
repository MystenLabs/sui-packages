module 0x3627cd6d779ed61beffc81edb4f8fd6e0789789e7b197b2151cd437cba39a36a::tokentest {
    struct TOKENTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKENTEST>(arg0, 6, b"TOKENTEST", b"TOKEN1", b"1212", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2021_05_10_16_13_37_63318310d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENTEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKENTEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

