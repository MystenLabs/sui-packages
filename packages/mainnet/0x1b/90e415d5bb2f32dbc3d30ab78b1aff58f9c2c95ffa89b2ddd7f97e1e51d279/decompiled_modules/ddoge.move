module 0x1b90e415d5bb2f32dbc3d30ab78b1aff58f9c2c95ffa89b2ddd7f97e1e51d279::ddoge {
    struct DDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDOGE>(arg0, 9, b"dDoge", b"Dumble Doge", b"#DumbleDoge casts a spell across the Solana blockchain! With the magic of \"Wingardium Dogiosa!\" and the charm of wizardry, this project combines the loyalty of man's best friend with the enchantment of the wizarding world. A bewitching blend of community power and meme-worthy energy, DumbleDoge has the potential to soar to legendary heights in the crypto cosmos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmemW2e8FieUfqv6bUgDvBb6jjd7LHyYVxf5aRHqWvXzv8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DDOGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDOGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

