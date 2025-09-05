module 0x820bae9b9fe6ac785809cdfebac415b13594b7e2d5fbf9d227c0f43afbd1996a::ndlp {
    struct NDLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDLP>(arg0, 8, b"NDLPt", b"Test NDLP XBTC/WBTC CETUS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.nodo.xyz/NDLP.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

