module 0x63211ff2ee7755887a5b864709325e63a00128b9d284bcd7866c5e606c46b525::yup {
    struct YUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUP>(arg0, 6, b"YUP", b"YUPPI", b"yupping my way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiabgkys6jm6ym3z2774nj36cyezuxwxz7fukkjnx47akslul23p6e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YUP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

