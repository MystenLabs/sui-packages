module 0xe285bfca88b2832356563565f9b949bbf1ec4e5f25c9408d04727ece8e0f43c1::simple_token {
    struct SIMPLE_TOKEN has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SMPL", b"Simple Token", b"Simple Token showcases", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIMPLE_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SIMPLE_TOKEN>>(0x2::coin::mint<SIMPLE_TOKEN>(arg0, arg1, arg3), arg2);
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<SIMPLE_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * 1 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<SIMPLE_TOKEN>>(0x2::coin::split<SIMPLE_TOKEN>(arg0, v0, arg3), @0xfee);
        0x2::transfer::public_transfer<0x2::coin::Coin<SIMPLE_TOKEN>>(0x2::coin::split<SIMPLE_TOKEN>(arg0, arg1 - v0, arg3), arg2);
    }

    fun init(arg0: SIMPLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SIMPLE_TOKEN>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPLE_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

