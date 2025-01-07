module 0xa0242ccb6123c394840554a72651c56664c15b6590002a5afc7ca86904e9d70c::wbtc {
    struct WBTC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WBTC>, arg1: 0x2::coin::Coin<WBTC>) {
        0x2::coin::burn<WBTC>(arg0, arg1);
    }

    fun init(arg0: WBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBTC>(arg0, 9, b"Wrapped BTC", b"WBTC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WBTC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WBTC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

