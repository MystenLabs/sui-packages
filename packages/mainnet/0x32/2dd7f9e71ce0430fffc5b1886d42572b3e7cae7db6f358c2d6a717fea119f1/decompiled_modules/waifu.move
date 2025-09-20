module 0x322dd7f9e71ce0430fffc5b1886d42572b3e7cae7db6f358c2d6a717fea119f1::waifu {
    struct WAIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIFU>(arg0, 6, b"WAIFU", b"WA1FU", x"4e6f205761316675204e6f204c616966750a4469676974616c204c6f7665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibbowntzvzrafdzlwjiucbga3ukpkjrusfnx4t22fz5c6gufwvgki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAIFU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

