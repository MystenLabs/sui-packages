module 0xcf53b549a7d7de98ff2d1a892810d4a86771b2a1021cd27e87f652c599ae4dcb::jui_on_sui {
    struct JUI_ON_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUI_ON_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUI_ON_SUI>(arg0, 9, b"JUI", b"Jui On Sui", x"54686f75207368616c74206e6f742070617065722068616e642e2054686520776f726c642773206669727374206b6f73686572206d656d6520636f696e206861732064657363656e6465642066726f6d204d6f756e742053554920e28094205a696f6e6973742c2062617365642c20616e64204c50206275726e656420696e746f2074686520657465726e616c20666c616d652e204f79205665792c2077656c636f6d6520746f207468652070726f6d697365642070756d702e20f09f94a5e29ca1efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmNfMJWHvZvRsgCZk6LhmMBNyw7jAAqVewRvEBnXePSytF")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<JUI_ON_SUI>>(0x2::coin::mint<JUI_ON_SUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUI_ON_SUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JUI_ON_SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

