module 0xebb733c5e243626c626e0a4e00e230332df008b142e8a70ca410923c249db14f::soly {
    struct SOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLY>(arg0, 6, b"SOLY", b"SolyFrog", b"SolyFrog is the next-generation memecoin, built to bridge the best of both worlds: Sui Chains. Inspired by the unstoppable power of memes and the ef ciency of modern blockchain technology, SolyFrog delivers speed, community strength, and cross-chain utilityall wrapped up in the spirit of fun and decentralization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068084_cfb4b2e994.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

