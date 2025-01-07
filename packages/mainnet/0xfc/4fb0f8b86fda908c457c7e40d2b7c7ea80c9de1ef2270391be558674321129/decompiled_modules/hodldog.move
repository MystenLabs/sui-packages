module 0xfc4fb0f8b86fda908c457c7e40d2b7c7ea80c9de1ef2270391be558674321129::hodldog {
    struct HODLDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODLDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODLDOG>(arg0, 6, b"HodlDOG", b"Dog with you", b"It's a dog from hell.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a9496af4_30dd_4ad4_96a5_776b3c880405_8c12300109.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODLDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODLDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

