module 0xa3583e4b8df8b8d27bfc92a77c959c4b13f3196310da2822db2b72b9b81a403d::sadcatsongcoin {
    struct SADCATSONGCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADCATSONGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADCATSONGCOIN>(arg0, 6, b"Sadcatsongcoin", b"sad cat song coin", b"miaw miaw miaw miaw miaw miaaaaw miaaaaw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ab67616d00001e025d0252d0243eff15327e3458_1b563c387f.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADCATSONGCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADCATSONGCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

