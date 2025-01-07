module 0xfff01555a7ca3d052801bc645d10a1f954d8b9fec61e990ed6ac3ab829780fbf::TAIKO {
    struct TAIKO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TAIKO>, arg1: 0x2::coin::Coin<TAIKO>) {
        0x2::coin::burn<TAIKO>(arg0, arg1);
    }

    fun init(arg0: TAIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAIKO>(arg0, 9, b"TAIKO", b"TAIKO", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAIKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAIKO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TAIKO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TAIKO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

