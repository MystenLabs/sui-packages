module 0x65ef488a4a52e6ec401f929cd5c9fa8a9ff3ffc57de4950378260dce52e16181::inputs {
    struct INPUTS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<INPUTS>, arg1: 0x2::coin::Coin<INPUTS>) {
        0x2::coin::burn<INPUTS>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<INPUTS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<INPUTS> {
        0x2::coin::mint<INPUTS>(arg0, arg1, arg2)
    }

    fun init(arg0: INPUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INPUTS>(arg0, 6, b"INPUTS", b"inputs", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1757640032336b61X.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INPUTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INPUTS>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<INPUTS>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<INPUTS> {
        assert!(0x2::coin::total_supply<INPUTS>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<INPUTS>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

