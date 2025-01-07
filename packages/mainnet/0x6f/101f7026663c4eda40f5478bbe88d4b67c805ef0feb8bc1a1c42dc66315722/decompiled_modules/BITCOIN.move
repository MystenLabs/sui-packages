module 0x6f101f7026663c4eda40f5478bbe88d4b67c805ef0feb8bc1a1c42dc66315722::BITCOIN {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BITCOIN>, arg1: 0x2::coin::Coin<BITCOIN>) {
        0x2::coin::burn<BITCOIN>(arg0, arg1);
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 2, b"BTC", b"BITCOIN", b"Bitcoin on sui blockhain", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BITCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BITCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

