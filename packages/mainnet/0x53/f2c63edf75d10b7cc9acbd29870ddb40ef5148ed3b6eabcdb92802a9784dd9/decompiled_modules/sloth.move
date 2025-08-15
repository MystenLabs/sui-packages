module 0x53f2c63edf75d10b7cc9acbd29870ddb40ef5148ed3b6eabcdb92802a9784dd9::sloth {
    struct SLOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTH>(arg0, 6, b"SLOTH", b"SUILOTH", b"I am so lazy to develop this project, so don't buy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicnkvbeimo2lxedzzr2ymu4vv2hy22qagkqycs7l4nlo4dlieibxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLOTH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

