module 0x6b1257a87bdc0244e969482fbe69956f377ab7257de5f17ce17baed882f38b2c::steak {
    struct STEAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAK>(arg0, 6, b"Steak", b"Tbone", x"535445414b2020546865204a75696369657374204d656d6520436f696e0a0a4a757374206275792c20737465616b2c20616e6420666f72676574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic47y5ank56bbusfhclcqjgdpsfkaqowm6u6eamfzkzypsegpz5uq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STEAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

