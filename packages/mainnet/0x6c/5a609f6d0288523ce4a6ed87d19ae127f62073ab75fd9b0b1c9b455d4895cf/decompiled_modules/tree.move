module 0x6c5a609f6d0288523ce4a6ed87d19ae127f62073ab75fd9b0b1c9b455d4895cf::tree {
    struct TREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREE>(arg0, 6, b"Tree", b"Thickquidity", b"Thickquidity (TREE) is the token that skipped leg day but still grew like a redwood! With roots deep in arboriculture and branches heavy with liquidity, this meme coin is here to leaf the competition behind. Plant a bag, sit back, and watch it get THICK while your gains photosynthesize.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiecyzluyawrejgazlm22o3ki6vmkav7wkyewqthkakjoclhxihrgi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TREE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

