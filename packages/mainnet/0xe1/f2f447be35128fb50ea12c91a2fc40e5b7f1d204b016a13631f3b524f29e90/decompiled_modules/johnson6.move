module 0xe1f2f447be35128fb50ea12c91a2fc40e5b7f1d204b016a13631f3b524f29e90::johnson6 {
    struct JOHNSON6 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON6>, arg1: 0x2::coin::Coin<JOHNSON6>) {
        0x2::coin::burn<JOHNSON6>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON6>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JOHNSON6> {
        0x2::coin::mint<JOHNSON6>(arg0, arg1, arg2)
    }

    fun init(arg0: JOHNSON6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOHNSON6>(arg0, 6, b"JOHNSON6", b"johnson6", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758974015134GanP.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOHNSON6>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOHNSON6>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON6>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JOHNSON6> {
        assert!(0x2::coin::total_supply<JOHNSON6>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<JOHNSON6>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

