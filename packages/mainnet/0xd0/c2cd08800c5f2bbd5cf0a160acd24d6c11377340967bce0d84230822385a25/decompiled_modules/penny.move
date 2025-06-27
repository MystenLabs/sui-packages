module 0xd0c2cd08800c5f2bbd5cf0a160acd24d6c11377340967bce0d84230822385a25::penny {
    struct PENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENNY>(arg0, 6, b"PENNY", b"PENNY SUI", b"Just a little penny on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig5eoexemhr5lbuv7u6dfp7xzdvezrewhgadcptnw4jiemvg7xbfa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PENNY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

