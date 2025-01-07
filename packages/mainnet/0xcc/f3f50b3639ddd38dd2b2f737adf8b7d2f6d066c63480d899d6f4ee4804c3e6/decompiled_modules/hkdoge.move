module 0xccf3f50b3639ddd38dd2b2f737adf8b7d2f6d066c63480d899d6f4ee4804c3e6::hkdoge {
    struct HKDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HKDOGE>, arg1: 0x2::coin::Coin<HKDOGE>) {
        0x2::coin::burn<HKDOGE>(arg0, arg1);
    }

    fun init(arg0: HKDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKDOGE>(arg0, 2, b"HKDOGE", b"HKDOGE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HKDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HKDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HKDOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

