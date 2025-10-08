module 0xc106686addd10cb7f8ac6ca1a806a570ca8023feac9465228adabba490eec2ec::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"Sui", b"https://moonbags.io/bondingcurve/coins/create", x"7375692020e68ea8e789b9e7bfbbe8af91e698af2020e59ca8202020e68980e4bba5202020e59ca8e4babae7949f20202020e5a5bde5908de5ad97", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaemlqrbr6xpjisv23sxekcrpxayr42obmnllxqw3onmadv3ba4su")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

