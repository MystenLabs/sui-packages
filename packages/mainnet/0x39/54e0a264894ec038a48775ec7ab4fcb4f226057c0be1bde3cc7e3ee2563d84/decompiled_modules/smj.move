module 0x3954e0a264894ec038a48775ec7ab4fcb4f226057c0be1bde3cc7e3ee2563d84::smj {
    struct SMJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMJ>(arg0, 6, b"SMJ", b"SuiMoji", b"colors of life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_27_20_40_37_0dc3a7375e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

