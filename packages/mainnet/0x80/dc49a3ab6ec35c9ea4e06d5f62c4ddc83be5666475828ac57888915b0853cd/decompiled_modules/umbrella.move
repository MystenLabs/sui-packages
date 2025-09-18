module 0x80dc49a3ab6ec35c9ea4e06d5f62c4ddc83be5666475828ac57888915b0853cd::umbrella {
    struct UMBRELLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UMBRELLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UMBRELLA>(arg0, 6, b"UMBRELLA", b"T-SUI Virus", x"24554d4252454c4c410a0a41206461726b206d656d65636f696e206f6e205355492c20696e73706972656420627920736563726574206578706572696d656e747320616e6420766972616c206f7574627265616b732e20546865206d697373696f6e3a207370726561642074686520542d535549205669727573206163726f73732074686520636861696e20616e642067726f77206120706f77657266756c20636f6d6d756e69747920756e6465722074686520556d6272656c6c61204f7267616e697a6174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibe743h7i2cqsxgknxljm43ivf7orgbicachtb6ch4tf4krwcx45u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UMBRELLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UMBRELLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

