module 0xac0fa5c9245fe3321aa45641fc1e2cf8156d193bbb9d66dbb8495ceccb670044::pdoge {
    struct PDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDOGE>(arg0, 6, b"PDOGE", b"Poseidoge", b"In the shimmering depths of the cryptocean, far beneath the waves of blockchain data, there lived a powerful deity, an ancient force feared by all who dared trade hastily. His name? Poseidoge, the mighty doge who had ascended to godhood, ruling over the turbulent seas of memecoins, tokens, and NFTs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/thug_e824606ea4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

