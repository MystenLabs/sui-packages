module 0x921d735d556d4f666e7dded50958f5559f31181da23416655ccca0a903a8247a::trdl {
    struct TRDL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRDL>(arg0, 6, b"TRDL", b"Treadle", b"Solutions Engineering and Developer Relations Agent for Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2025_01_29_012454361_9d24b5da4d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRDL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRDL>>(v1);
    }

    // decompiled from Move bytecode v6
}

