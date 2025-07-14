module 0xab67ab929fd59ca1ee069a575cc9645cf7a39ecf8b55d86adc75c6e2bf6f3467::ruggg {
    struct RUGGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGGG>(arg0, 6, b"Ruggg", b"Rug", b"Rugggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia3xqeazm4lrhu2ner6va4zbrujw5cja7cbj3u45c7jzb5wunx7nm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RUGGG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

