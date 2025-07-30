module 0x4211bae3ca1eb5a0ad192ac134d4f97e9a4ab956561cfe0ac1ce3ee45d731a89::cj {
    struct CJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CJ>(arg0, 6, b"CJ", b"Carl Johnson", b"CJ, the ultimate Grove Street OG! Invading SUI hood", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiay6p5k3kjkopyzhju2nbautsbm2mj2xjeu23uyfatxnwpynbd6su")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CJ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

