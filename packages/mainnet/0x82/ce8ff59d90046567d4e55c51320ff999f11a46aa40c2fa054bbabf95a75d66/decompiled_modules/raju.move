module 0x82ce8ff59d90046567d4e55c51320ff999f11a46aa40c2fa054bbabf95a75d66::raju {
    struct RAJU has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RAJU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RAJU>>(0x2::coin::mint<RAJU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RAJU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAJU>(arg0, 8, b"RAJU", b"raju", b"Rajwanshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAJU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<RAJU>>(0x2::coin::mint<RAJU>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAJU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

