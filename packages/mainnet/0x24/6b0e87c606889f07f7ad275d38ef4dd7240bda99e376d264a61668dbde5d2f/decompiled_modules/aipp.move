module 0x246b0e87c606889f07f7ad275d38ef4dd7240bda99e376d264a61668dbde5d2f::aipp {
    struct AIPP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIPP>, arg1: 0x2::coin::Coin<AIPP>) {
        0x2::coin::burn<AIPP>(arg0, arg1);
    }

    fun init(arg0: AIPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPP>(arg0, 2, b"AIPP", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIPP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIPP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIPP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

