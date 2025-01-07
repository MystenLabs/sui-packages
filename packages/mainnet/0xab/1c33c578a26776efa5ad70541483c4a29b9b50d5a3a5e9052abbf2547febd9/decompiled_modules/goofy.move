module 0xab1c33c578a26776efa5ad70541483c4a29b9b50d5a3a5e9052abbf2547febd9::goofy {
    struct GOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOFY>(arg0, 9, b"GOOFY", b"SuiGoof", b"SuiGoof is a playful token on the SUI blockchain, offering fast, secure transactions with a fun, lighthearted vibe. Perfect for adding humor to the DeFi space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1790233912230506496/SDFfKqlj.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOOFY>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOFY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

