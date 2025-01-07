module 0x4142dc2fd7f21ca41b62c3dfd93d462a67fbff54ff170475687610595d1590b5::pumptest {
    struct PUMPTEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PUMPTEST>, arg1: 0x2::coin::Coin<PUMPTEST>) {
        0x2::coin::burn<PUMPTEST>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PUMPTEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMPTEST>>(0x2::coin::mint<PUMPTEST>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PUMPTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPTEST>(arg0, 9, b"pumpTEST", b"PUMPTEST", b"Tester", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMPTEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPTEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

