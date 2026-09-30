module 0x6f859a70074e559ebe0263527d96e6cada7938fe6f931ebf660f610dd88f270d::hue {
    struct HUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUE>(arg0, 9, b"HUE", b"Just Hue", b"Just Hue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/59e347255c2f3fb316703d96a28a3a723be3bd0618b5fffcfac645573109f6f9")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HUE>>(0x2::coin::mint<HUE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUE>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

