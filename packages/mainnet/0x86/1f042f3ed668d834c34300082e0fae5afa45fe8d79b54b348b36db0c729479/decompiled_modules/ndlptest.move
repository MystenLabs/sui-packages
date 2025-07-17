module 0x861f042f3ed668d834c34300082e0fae5afa45fe8d79b54b348b36db0c729479::ndlptest {
    struct NDLPTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDLPTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NDLPTEST>(arg0, 6, b"tNDLP", b"Test NDLP xBTC/USDC Momentum", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.nodo.xyz/NDLP.svg")), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDLPTEST>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDLPTEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NDLPTEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

