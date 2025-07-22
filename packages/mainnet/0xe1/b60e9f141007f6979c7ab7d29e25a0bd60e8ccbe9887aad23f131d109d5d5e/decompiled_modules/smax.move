module 0xe1b60e9f141007f6979c7ab7d29e25a0bd60e8ccbe9887aad23f131d109d5d5e::smax {
    struct SMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAX>(arg0, 6, b"SMAX", b"Sui Max", x"42656570206265657020537569204d6178206973206f6e210a4e6f20736572696f757320766962657320686572652c206a757374206d656d65732c206761696e732c20616e6420676f6f642074696d65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaot5gcrjeol2424euofkpqxp3eahqvwd354fdw2qw6mfrrpvfkmy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMAX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

