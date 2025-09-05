module 0xe5f765d03f1c24be05036ef16060b94e127889f26d5d97fa24ab2518424f957d::ndlp {
    struct NDLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDLP>(arg0, 9, b"NDLPt", b"Test NDLP WBTC/SUI MMT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.nodo.xyz/NDLP.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

