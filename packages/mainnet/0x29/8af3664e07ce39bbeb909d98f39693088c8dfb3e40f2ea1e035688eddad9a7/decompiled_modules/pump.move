module 0x298af3664e07ce39bbeb909d98f39693088c8dfb3e40f2ea1e035688eddad9a7::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PUMP>, arg1: 0x2::coin::Coin<PUMP>) {
        assert!(false == false, 100);
        0x2::coin::burn<PUMP>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PUMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<PUMP>(0x2::coin::supply<PUMP>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMP>>(0x2::coin::mint<PUMP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 5, b"PUMP", b"PUMP kin", b"null", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/AgEnjKvKmlmpeBYUJAJ8xySyxn4F76wvsfc2pL_JkHY?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

