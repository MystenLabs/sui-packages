module 0xf3aaf3ed77d4999b59dffc51a7cba52cbb5e71d8b041871e6793d50e2038957e::suimilly {
    struct SUIMILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMILLY>(arg0, 6, b"SuiMilly", b"Milly On Sui", b"SuiMilly - Spray Your Dreams, Own Your Future!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihzhfotgrwp4nzfivku7qftnmr5i5ggstszt4nv77n3zxte5goeci")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMILLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

