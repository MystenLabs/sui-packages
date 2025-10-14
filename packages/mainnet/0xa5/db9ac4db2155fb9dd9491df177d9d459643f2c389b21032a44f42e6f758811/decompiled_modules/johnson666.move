module 0xa5db9ac4db2155fb9dd9491df177d9d459643f2c389b21032a44f42e6f758811::johnson666 {
    struct JOHNSON666 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON666>, arg1: 0x2::coin::Coin<JOHNSON666>) {
        0x2::coin::burn<JOHNSON666>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON666>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JOHNSON666> {
        0x2::coin::mint<JOHNSON666>(arg0, arg1, arg2)
    }

    fun init(arg0: JOHNSON666, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOHNSON666>(arg0, 6, b"JOHNSON666", b"johnson666", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1760454300188c42n.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOHNSON666>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOHNSON666>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON666>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JOHNSON666> {
        assert!(0x2::coin::total_supply<JOHNSON666>(arg0) + 100000000 <= 100000000, 0);
        0x2::coin::mint<JOHNSON666>(arg0, 100000000, arg1)
    }

    // decompiled from Move bytecode v6
}

