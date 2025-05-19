module 0x8590b0a35bd4973d4c5c93d6816fc3e823dd223a952b8afccfffb25e6d2834cf::suigetsu {
    struct SUIGETSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGETSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGETSU>(arg0, 6, b"SUIGETSU", b"Sui Getsu", b"The goal of SUIGETSU is to become one of the most traded tokens on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieuu52vvbucj4raxxiqspmwzvpiidlu4ctapme5uv6qw4zxeecafa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGETSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGETSU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

