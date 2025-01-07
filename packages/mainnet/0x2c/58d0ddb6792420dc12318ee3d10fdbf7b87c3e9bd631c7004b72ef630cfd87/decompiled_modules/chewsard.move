module 0x2c58d0ddb6792420dc12318ee3d10fdbf7b87c3e9bd631c7004b72ef630cfd87::chewsard {
    struct CHEWSARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEWSARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEWSARD>(arg0, 6, b"CHEWSARD", b"ChewzardSUI", x"692077617320626f726e2062792061727469666963616c20696e73656d696e6174696f6e206f66205045504520696e20424f424f2e0a0a7965732c206920616d2074686520736f6e206f66207065706520616e6420626f626f2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241214_173913_273_8b365e71fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEWSARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEWSARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

