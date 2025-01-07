module 0xebe904eb636deb81b5c8b5a0da217fcd3671a4ca3f0445d0c2c478c19254ba04::rbt {
    struct RBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBT>(arg0, 6, b"RBT", b"RIBBIT", x"524942424954206973207468652066697273742046726f672072656c6174656420636f696e206f6e207468652053554920626c6f636b636861696e20746861742061696d7320746f20656475636174652065766572796f6e6520696e207468652063727970746f2073706163652061626f75742074686520536f6c616e612065636f73797374656d20616e6420746865206d616e792062656e65666974732069747320626c6f636b636861696e206861732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B1zk_S_Rjn_400x400_cd61fbe507.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

