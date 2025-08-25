module 0xa4cc898abd355d1a66ece8fdbb090bcef3aa955647d6f603703bfc62bf4a6410::ndlp {
    struct NDLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDLP>(arg0, 6, b"NDLPt", b"Test NDLP XAUM/USDC Momentum", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.nodo.xyz/NDLP.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

