module 0x68d457d94d8446c01ead0083210e2c4a679f63f977aa34106eba3d8535fe7f81::op {
    struct OP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OP>(arg0, 10, b"OP", b"OceanPark", b"ipfs://QmV1t6xKXLfj7ZL3aZdSKZNYR55XCegsGRUqRN7hwUqBfQ", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OP>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<OP>(arg0) == 0, 1);
        0x2::coin::mint_and_transfer<OP>(arg0, 10000000000000000000, @0xbb2ab90a48b5bb11b276a680df5c90294c81d0be886c50a69596e4729d0ef7c3, arg1);
    }

    // decompiled from Move bytecode v6
}

