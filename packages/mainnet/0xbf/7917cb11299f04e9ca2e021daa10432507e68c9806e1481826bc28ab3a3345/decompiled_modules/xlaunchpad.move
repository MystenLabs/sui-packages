module 0xbf7917cb11299f04e9ca2e021daa10432507e68c9806e1481826bc28ab3a3345::xlaunchpad {
    struct XLAUNCHPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: XLAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XLAUNCHPAD>(arg0, 6, b"XLaunchpad", b"xLaunchpad Sui", b"Pioneering change. Accelerating high impact projects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicgydovgxyzvmwa7fgw4ig3ejyi3h7nnf5wxrss5t7akgn5revv2y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XLAUNCHPAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XLAUNCHPAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

