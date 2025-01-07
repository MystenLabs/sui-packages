module 0x1d32e28f4f7e2f08c6963376bf50490a8753e70f2ac0a8e142273ad50f5427be::gx1 {
    struct GX1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GX1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GX1>(arg0, 6, b"GX1", b"GALAXY NFT", b"The only socially engineered, digital media sharing platform that rewards users for creating, buying, and selling digital content.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_18_23_26_48_4246257bc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GX1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GX1>>(v1);
    }

    // decompiled from Move bytecode v6
}

