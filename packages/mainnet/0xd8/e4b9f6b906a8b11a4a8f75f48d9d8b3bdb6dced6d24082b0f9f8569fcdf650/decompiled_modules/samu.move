module 0xd8e4b9f6b906a8b11a4a8f75f48d9d8b3bdb6dced6d24082b0f9f8569fcdf650::samu {
    struct SAMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMU>(arg0, 9, b"SAMU", b"SUI SAMURAI", x"53616d7572616920436f696e2069736ee2809974206a7573742061206d656d65202d206974e28099732061206d6f76656d656e742e204120636f6d6d756e69747920626f756e6420627920636f75726167652c20726573706563742c20616e64207468652072656c656e746c6573732070757273756974206f6620676c6f727920696e207468652063727970746f20776f726c642e207c20576562736974653a2068747470733a2f2f692e696d6775722e636f6d2f616f32775951742e6a706567", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/ao2wYQt.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

