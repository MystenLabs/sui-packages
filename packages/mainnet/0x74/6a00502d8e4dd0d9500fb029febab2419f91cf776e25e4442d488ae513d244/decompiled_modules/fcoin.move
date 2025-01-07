module 0x746a00502d8e4dd0d9500fb029febab2419f91cf776e25e4442d488ae513d244::fcoin {
    struct FCOIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FCOIN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FCOIN>>(0x2::coin::mint<FCOIN>(arg0, 1000000, arg2), arg1);
    }

    fun init(arg0: FCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCOIN>(arg0, 6, b"FCOIN", b"FC", b"faucet coin for test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

