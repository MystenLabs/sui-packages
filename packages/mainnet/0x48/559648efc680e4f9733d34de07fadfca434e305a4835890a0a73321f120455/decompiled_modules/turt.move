module 0x48559648efc680e4f9733d34de07fadfca434e305a4835890a0a73321f120455::turt {
    struct TURT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURT>(arg0, 6, b"TURT", b"TURT ON SUI", b"Hold TURT, join the shell gang, and let the good energy flow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiatvgfhjvxitp7ve4byyce5e66v5znf734w2byzbnbopexyv5krki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TURT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

