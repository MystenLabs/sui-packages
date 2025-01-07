module 0xea54d12118a085505129f8dc94609eb96540cc6310b0f2a855ed73178ecd4cdc::chummy {
    struct CHUMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUMMY>(arg0, 6, b"Chummy", b"Chummy Chum Chums", b"meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5a7fecce_23d5_4dd9_b174_40c234520d5a_b2a4ade691.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

