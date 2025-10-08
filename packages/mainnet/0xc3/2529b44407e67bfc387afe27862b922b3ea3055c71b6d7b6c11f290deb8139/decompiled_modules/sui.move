module 0xc32529b44407e67bfc387afe27862b922b3ea3055c71b6d7b6c11f290deb8139::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", x"e59ca8e4babae7949f", x"5375692020e68ea8e789b9e7bfbbe8af91e5908de5ad97e698af2020202020e59ca820202020e68980e4bba5e5b0b1e59ca8e4babae7949f20202020e69e9ce784b6e698afe5a5bde5908de5ad97", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaemlqrbr6xpjisv23sxekcrpxayr42obmnllxqw3onmadv3ba4su")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

