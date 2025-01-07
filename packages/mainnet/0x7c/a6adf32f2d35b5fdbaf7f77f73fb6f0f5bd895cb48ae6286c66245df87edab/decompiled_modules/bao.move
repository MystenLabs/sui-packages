module 0x7ca6adf32f2d35b5fdbaf7f77f73fb6f0f5bd895cb48ae6286c66245df87edab::bao {
    struct BAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAO>(arg0, 6, b"BAO", b"$BAO", b"In the lush bamboo forests of the Sui ecosystem, where memes roam free and blockchain magic unfolds, a legendary panda named BAO emerged.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/oz4o0b_c642e5560a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

