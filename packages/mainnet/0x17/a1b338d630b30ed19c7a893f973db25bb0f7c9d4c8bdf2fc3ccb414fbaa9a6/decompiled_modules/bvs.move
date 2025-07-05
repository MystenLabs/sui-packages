module 0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs {
    struct BVS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BVS>, arg1: 0x2::coin::Coin<BVS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<BVS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BVS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BVS>>(0x2::coin::mint<BVS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BVS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVS>(arg0, 9, b"BVS", b"Beaver Sui", b"Beaver Sui is the fifth meme coin within the Panda Sui ecosystem to support a self burning model. All BVS obtained through trading fees will be burned entirely, with no reserves kept.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibyqxmb2ectyxktuxdnok2b4e2uexheimseopvw3yjjfgkg5hjhhi?filename=bvs.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BVS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

