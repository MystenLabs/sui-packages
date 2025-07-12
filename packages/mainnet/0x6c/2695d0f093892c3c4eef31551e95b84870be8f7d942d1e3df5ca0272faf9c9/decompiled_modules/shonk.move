module 0x6c2695d0f093892c3c4eef31551e95b84870be8f7d942d1e3df5ca0272faf9c9::shonk {
    struct SHONK has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHONK>, arg1: 0x2::coin::Coin<SHONK>) {
        0x2::coin::burn<SHONK>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<SHONK>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHONK>>(arg0, @0x0);
    }

    fun init(arg0: SHONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHONK>(arg0, 6, b"SHONK", b"SHONK", x"53484f4e4b2069732061206d656d6520636f696e207377696d6d696e67207468726f75676820746865206368616f73206f66207468652063727970746f206f6365616e20e2809420666561726c6573732c20626f6c642c20616e6420616c776179732068756e6772792e204974e280997320636f6d6d756e6974792d66697273742c20646563656e7472616c697a65642c20616e642064657369676e656420746f2062652066756e2c20747261646561626c652c20616e64206d656d652d776f727468792e204e6f2070726f6d697365732c206e6f2063656e7472616c20617574686f726974792e204a75737420707572652c20736861726b2d6675656c65642066756e2e2042652074686520736861726b2c206e6f742074686520666973682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/hHcSNnD.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHONK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHONK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHONK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHONK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

