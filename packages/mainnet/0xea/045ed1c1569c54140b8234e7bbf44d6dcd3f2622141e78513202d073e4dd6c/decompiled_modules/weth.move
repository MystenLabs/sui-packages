module 0xea045ed1c1569c54140b8234e7bbf44d6dcd3f2622141e78513202d073e4dd6c::weth {
    struct WETH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WETH>, arg1: 0x2::coin::Coin<WETH>) {
        0x2::coin::burn<WETH>(arg0, arg1);
    }

    fun init(arg0: WETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETH>(arg0, 8, b"Wrapped Ether", b"WETH", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETH>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WETH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WETH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

