module 0x5b5a6b91f53f96d9ba204fc7bd7392ad9954402bf1d84fb1d0cc73a5449583ee::wsbcoin {
    struct WSBCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WSBCOIN>, arg1: 0x2::coin::Coin<WSBCOIN>) {
        0x2::coin::burn<WSBCOIN>(arg0, arg1);
    }

    fun init(arg0: WSBCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSBCOIN>(arg0, 2, b"WSBCOIN", b"MNG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSBCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSBCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WSBCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WSBCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

