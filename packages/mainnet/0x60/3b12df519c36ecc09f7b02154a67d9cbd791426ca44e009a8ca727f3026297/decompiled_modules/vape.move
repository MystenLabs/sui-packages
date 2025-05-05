module 0x603b12df519c36ecc09f7b02154a67d9cbd791426ca44e009a8ca727f3026297::vape {
    struct VAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAPE>(arg0, 6, b"VAPE", b"VAPOR", b"Call it vaporeon until it vapes your whole stack", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihbbwsvc3r2rrqcbred7jqmqcajbttpdfsdi7qfak3jvh5ruu22ka")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VAPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

