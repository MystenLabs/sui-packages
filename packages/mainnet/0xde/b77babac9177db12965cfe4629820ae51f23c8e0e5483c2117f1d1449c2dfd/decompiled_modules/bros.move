module 0xdeb77babac9177db12965cfe4629820ae51f23c8e0e5483c2117f1d1449c2dfd::bros {
    struct BROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROS>(arg0, 6, b"Bros", b"SuiBros", b"One community to unite them all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CE_2702_A3_49_CE_4247_B6_D5_D4_C4_ADF_9_EC_3_A_670fba8af8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

