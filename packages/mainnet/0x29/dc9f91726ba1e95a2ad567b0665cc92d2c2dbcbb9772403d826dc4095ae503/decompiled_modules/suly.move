module 0x29dc9f91726ba1e95a2ad567b0665cc92d2c2dbcbb9772403d826dc4095ae503::suly {
    struct SULY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULY>(arg0, 6, b"SULY", b"Suly Frog", b"SulyFrog is the next-generation memecoin, built to bridge the best of both worlds: Sui Chains. Inspired by the unstoppable power of memes and the ef ciency of modern blockchain technology, SolyFrog delivers speed, community strength, and cross-chain utilityall wrapped up in the spirit of fun and decentralization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068628_2bef990d35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULY>>(v1);
    }

    // decompiled from Move bytecode v6
}

