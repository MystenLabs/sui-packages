module 0x56849f7cf21882dbe12dac306e11af87c91e2e1d552afa7a454d9765002ebb8c::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"SIU", b"SIU on SUI", x"496e74726f647563696e6720245349552c20746865206d656d6520636f696e207468617420636f6d62696e657320437269737469616e6f20526f6e616c646f27732069636f6e6963202253495555555555222063656c6562726174696f6e2077697468207468652053554920626c6f636b636861696e2e204a6f696e207468652024534955207265766f6c7574696f6ee2809463656c6562726174652c20696e766573742c20616e642073686f757420275349555555555521272061732077652073656e64207468697320636f696e20746f20746865206d6f6f6e210a0a235349556f6e535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748025825878.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

