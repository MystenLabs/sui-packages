module 0xd981eb0f85e38f551a389394ec7282e10842362e46f9f20855271ff01a059eee::dif {
    struct DIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIF>(arg0, 6, b"DIF", b"DEV IS FISH", b"DEV IS FISH.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwjimbhepzjakw5lgdn3k4erwrt4jaw6kv2wxmmvikrurrvlevva")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

