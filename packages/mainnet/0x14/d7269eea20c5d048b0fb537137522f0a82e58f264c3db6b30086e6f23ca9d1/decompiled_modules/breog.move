module 0x14d7269eea20c5d048b0fb537137522f0a82e58f264c3db6b30086e6f23ca9d1::breog {
    struct BREOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREOG>(arg0, 6, b"BREOG", b"Brett Mog", x"536f6d65206f6620746865206d6f737420696d706f7274616e7420746f6b656e730a746869732074696d65206465636964656420746f20617265616e676520610a6c6567656e6461727920636f6c6c61626f726174696f6e20746861742077696c6c2062650a72656d656d62657265642062792065766572796f6e6520466f72657665722c20426520610a5769746e65737320746f2074686973206576656e74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000045023_8f5f173c97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

