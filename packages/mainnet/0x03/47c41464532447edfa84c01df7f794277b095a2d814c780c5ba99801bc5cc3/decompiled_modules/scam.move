module 0x347c41464532447edfa84c01df7f794277b095a2d814c780c5ba99801bc5cc3::scam {
    struct SCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAM>(arg0, 6, b"SCAM", b"Scam", b"dont buy me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/apple_logo_png_5a36c9d60de9a7_317118621513540054057_31c989ecd3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

