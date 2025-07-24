module 0x235453d25212e60e4b16586d48b40e27fb180679b0a3e523df63619a2c70e044::ndlptest {
    struct NDLPTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDLPTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NDLPTEST>(arg0, 6, b"tNDLP", b"Test NDLP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.nodo.xyz/NDLP.svg")), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDLPTEST>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDLPTEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NDLPTEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

