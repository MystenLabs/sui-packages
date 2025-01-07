module 0xdfee36ec428fe1afc50c7e0d8cc1b34348a8e59b19737acd687245e3a78cf96a::aaablub {
    struct AAABLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAABLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAABLUB>(arg0, 6, b"AAABLUB", b"aaa blub", b"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaablub", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240919143304_fa570e1c3b_dcf8c5d16d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAABLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAABLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

