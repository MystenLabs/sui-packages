module 0xd0f12b1b4cc5039701e8a090f43b430c6eab9bb4d6808de62b0d5e6365f508e1::sus {
    struct SUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUS>(arg0, 9, b"SUS", b"SUS ON SUI", b"In a world teeming with myriad coins of every hue and shape, one shall rise above the rest, cloaked in mystery and mischief. Behold, the Sussiest Coin of All.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdvR2yW3BzxHR8bMPMqCkxovNbeA71RRG1FJ65tkiagEE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

