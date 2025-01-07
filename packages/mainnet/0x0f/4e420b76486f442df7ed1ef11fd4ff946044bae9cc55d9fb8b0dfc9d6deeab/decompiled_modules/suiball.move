module 0xf4e420b76486f442df7ed1ef11fd4ff946044bae9cc55d9fb8b0dfc9d6deeab::suiball {
    struct SUIBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBALL>(arg0, 6, b"SUIBall", b"Gumball on SUI", b"Hey, I'm Gumball, but in the crypto world of the SUI Network, I'm known as the Supply Burner. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gumball_2_8b045880b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

