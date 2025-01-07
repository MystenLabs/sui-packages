module 0xf6e94b1fa805b46f10fbed2b4b11b408b78edf51302f21ef39b8b5ce29de30bc::apy {
    struct APY has drop {
        dummy_field: bool,
    }

    fun init(arg0: APY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APY>(arg0, 9, b"APY", b"AgentiPy", x"54686520507974686f6e206672616d65776f726b20666f7220636f6e6e656374696e67204149206167656e747320746f20616e79206f6e636861696e20617070206f6e20536f6c616e612020f09f908d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbFik3oCbTJ2L4Ggqqsg9W9C2KWJW7srysZ2824a6L1Vz")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

