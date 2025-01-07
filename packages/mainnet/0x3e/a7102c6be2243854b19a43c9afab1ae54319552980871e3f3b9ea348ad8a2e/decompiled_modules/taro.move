module 0x3ea7102c6be2243854b19a43c9afab1ae54319552980871e3f3b9ea348ad8a2e::taro {
    struct TARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARO>(arg0, 6, b"TARO", b"Sui Taro", b"TARO_CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitaro_a0cf7e043b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARO>>(v1);
    }

    // decompiled from Move bytecode v6
}

