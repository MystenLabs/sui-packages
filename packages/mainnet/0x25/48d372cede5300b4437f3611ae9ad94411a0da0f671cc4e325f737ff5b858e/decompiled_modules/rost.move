module 0x2548d372cede5300b4437f3611ae9ad94411a0da0f671cc4e325f737ff5b858e::rost {
    struct ROST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROST>(arg0, 6, b"ROST", b"Rug on sui today", b"Rug on sui today... ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051968_99ba76956d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROST>>(v1);
    }

    // decompiled from Move bytecode v6
}

