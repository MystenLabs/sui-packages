module 0x1602e10c12ddfdae3e5183ea783c641527ae74da523fbf438e30714487c1ad4f::sdcoin {
    struct SDCOIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SDCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SDCOIN>>(0x2::coin::mint<SDCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SDCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDCOIN>(arg0, 6, b"SDCOIN", b"SDCOIN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

