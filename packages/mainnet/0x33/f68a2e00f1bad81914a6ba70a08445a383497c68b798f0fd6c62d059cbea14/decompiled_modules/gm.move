module 0x33f68a2e00f1bad81914a6ba70a08445a383497c68b798f0fd6c62d059cbea14::gm {
    struct GM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GM>(arg0, 6, b"GM", b"Good Martian", b"Welcome to the universe's first manufacturing plant for Martians on the Sui blockchain. Every Martian created has a simple goal in common with one another. To escape this hell-scape known as the planet earth, and make it back to Mars. Join us on this journey $GM.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HL_Zog_He_V_Wkcwqioc1_Srgdi3xu_DDA_Rc_XW_Ycqo12_D_Cpump_f1ef5b5b33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GM>>(v1);
    }

    // decompiled from Move bytecode v6
}

