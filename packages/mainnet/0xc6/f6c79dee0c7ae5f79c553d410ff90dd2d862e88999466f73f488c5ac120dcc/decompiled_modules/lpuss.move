module 0xc6f6c79dee0c7ae5f79c553d410ff90dd2d862e88999466f73f488c5ac120dcc::lpuss {
    struct LPUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPUSS>(arg0, 6, b"LPUSS", b"LPUSS COIN ON SUI", b"LPUSS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_02_07_18_15_39_d4f27e3913.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPUSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LPUSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

