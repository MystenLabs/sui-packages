module 0xb7e77ab5ff6634f138ac4db8c836796204910043668db368d04cbd25e4a81ea4::trumpsui {
    struct TRUMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSUI>(arg0, 6, b"TRUMPSUI", b"TRUMP SUI", b"Here is a message from PreSUIdent Donald Trump who live in the Blue House \"Listen up. I am here on the fastest blockchain in Crypto - Sui. Forget Ethereum. Forget Solana. Sui is the best. This is home for me.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_16_23_29_55_91823e7065_4d68a38189.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

