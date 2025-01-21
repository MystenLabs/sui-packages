module 0xebfb6ec91de5c3f73918b946420bec4fc7a539e3aed89260379f3ed7eca24928::elonius {
    struct ELONIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONIUS>(arg0, 6, b"ELONIUS", b"Elonius Muskimus", b"Embark on a journey through the digital cosmos with Elonius Muskimus, the ultimate meme token on the SUI blockchain. This isn't just a token; it's a tribute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_6ba24d6a90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

