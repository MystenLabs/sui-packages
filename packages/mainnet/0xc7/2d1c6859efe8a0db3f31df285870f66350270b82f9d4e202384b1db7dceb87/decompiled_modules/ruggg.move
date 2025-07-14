module 0xc72d1c6859efe8a0db3f31df285870f66350270b82f9d4e202384b1db7dceb87::ruggg {
    struct RUGGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGGG>(arg0, 6, b"Ruggg", b"Bad Rug token", b"Buy if gay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia3xqeazm4lrhu2ner6va4zbrujw5cja7cbj3u45c7jzb5wunx7nm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RUGGG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

