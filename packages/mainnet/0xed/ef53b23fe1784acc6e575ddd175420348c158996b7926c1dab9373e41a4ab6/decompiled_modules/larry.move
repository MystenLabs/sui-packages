module 0xedef53b23fe1784acc6e575ddd175420348c158996b7926c1dab9373e41a4ab6::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARRY>(arg0, 6, b"LARRY", b"Larry Sui", b"LARRY IN THE SEA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxscx6bkijahx7ffvrflii5pzvxd75uyu7mvsbhdumcwnoajc4ta")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LARRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

