module 0xe0eb3c09d5bc73d6212f9c1c223221e2e1843e1b0d7feb09c312389e665cbeab::please {
    struct PLEASE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PLEASE>, arg1: 0x2::coin::Coin<PLEASE>) {
        0x2::coin::burn<PLEASE>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PLEASE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PLEASE>>(0x2::coin::mint<PLEASE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PLEASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLEASE>(arg0, 9, b"PLEASE", b"PLEASE", b"PLEASE SIR", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLEASE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLEASE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

