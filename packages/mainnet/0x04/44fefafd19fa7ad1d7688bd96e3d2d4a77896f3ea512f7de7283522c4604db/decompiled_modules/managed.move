module 0x444fefafd19fa7ad1d7688bd96e3d2d4a77896f3ea512f7de7283522c4604db::managed {
    struct MANAGED has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MANAGED>, arg1: 0x2::coin::Coin<MANAGED>) {
        0x2::coin::burn<MANAGED>(arg0, arg1);
    }

    fun init(arg0: MANAGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGED>(arg0, 6, b"USDT", b"USDT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAGED>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mintAndTransfer(arg0: &mut 0x2::coin::TreasuryCap<MANAGED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MANAGED>>(0x2::coin::mint<MANAGED>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

