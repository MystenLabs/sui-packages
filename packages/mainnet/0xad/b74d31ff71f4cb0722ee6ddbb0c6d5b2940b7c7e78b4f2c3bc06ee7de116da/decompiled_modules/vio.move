module 0xadb74d31ff71f4cb0722ee6ddbb0c6d5b2940b7c7e78b4f2c3bc06ee7de116da::vio {
    struct VIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIO>(arg0, 6, b"Vio", b"Vio AI", b"revolutionizing crypto analysis, token discovery, and on-chain data intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737905414907.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

