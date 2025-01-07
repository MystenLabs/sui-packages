module 0xd8fb9560a97092cbc52cb1d0783a0bc68a9f5cf879ab23bc3b72f0bd76ea0dbd::sfree {
    struct SFREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFREE>(arg0, 6, b"SFree", b"Syrien", b"Welcome to Damascus Habibi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061047_de112004d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

