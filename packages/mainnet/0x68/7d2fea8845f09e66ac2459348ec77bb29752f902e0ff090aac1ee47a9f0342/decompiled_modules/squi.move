module 0x687d2fea8845f09e66ac2459348ec77bb29752f902e0ff090aac1ee47a9f0342::squi {
    struct SQUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUI>(arg0, 6, b"SQUI", b"Squirtle", x"53717569206973206e6f77206f6e20537569212054686520637574657374206d6f737420616d617a696e6720636f6d70616e696f6e2077696c6c2073706c61736820616c6c20796f7572206578706563746174696f6e7320617761792e0a546865206f6e6c7920676f6f64205371756972746c652070726f6a656374206f6e20747572626f73210a4a6f696e207468652074656c656772616d2c206c657427732073656e64207468697320506f6b656d6f6e20737472616967687420746f20746865206d6f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731291605887.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

