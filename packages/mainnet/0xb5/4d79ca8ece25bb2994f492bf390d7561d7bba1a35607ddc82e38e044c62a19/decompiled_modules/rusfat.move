module 0xb54d79ca8ece25bb2994f492bf390d7561d7bba1a35607ddc82e38e044c62a19::rusfat {
    struct RUSFAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSFAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSFAT>(arg0, 6, b"RUSFAT", b"TheWalrusFat", b"Rusfat is a strong memecoin that was born on the sui chain, like its shape, Walrus Fat will be bigger than expect.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihh2cyti7ofazmthcuezr2k3gmaka67v2gbry77fbzxztbndc3rlu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSFAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RUSFAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

