module 0xd37b32651e99424538e1e50bc50ef8c47c21539817c246e4135cfa1a8fb35ffa::odor {
    struct ODOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODOR>(arg0, 9, b"ODOR", b"THE ODOR ON SUI", x"53616d7572616920436f696e2069736ee2809974206a7573742061206d656d65202d206974e28099732061206d6f76656d656e742e204120636f6d6d756e69747920626f756e6420627920636f75726167652c20726573706563742c20616e64207468652072656c656e746c6573732070757273756974206f6620676c6f727920696e207468652063727970746f20776f726c642e207c20576562736974653a2068747470733a2f2f692e696d6775722e636f6d2f334d487a6d70472e6a706567", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/3MHzmpG.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

