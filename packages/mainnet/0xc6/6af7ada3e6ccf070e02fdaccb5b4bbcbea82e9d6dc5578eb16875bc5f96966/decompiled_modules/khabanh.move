module 0xc66af7ada3e6ccf070e02fdaccb5b4bbcbea82e9d6dc5578eb16875bc5f96966::khabanh {
    struct KHABANH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KHABANH>, arg1: 0x2::coin::Coin<KHABANH>) {
        0x2::coin::burn<KHABANH>(arg0, arg1);
    }

    fun init(arg0: KHABANH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHABANH>(arg0, 9, b"KHB", b"KHABANH", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHABANH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHABANH>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KHABANH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KHABANH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

