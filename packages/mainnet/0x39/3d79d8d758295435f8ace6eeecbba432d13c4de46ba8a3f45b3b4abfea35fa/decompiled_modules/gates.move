module 0x393d79d8d758295435f8ace6eeecbba432d13c4de46ba8a3f45b3b4abfea35fa::gates {
    struct GATES has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GATES>, arg1: 0x2::coin::Coin<GATES>) {
        0x2::coin::burn<GATES>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<GATES>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<GATES> {
        0x2::coin::mint<GATES>(arg0, arg1, arg2)
    }

    fun init(arg0: GATES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATES>(arg0, 6, b"GATES", b"Gates", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1757597612557ng4q.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GATES>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<GATES>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<GATES> {
        assert!(0x2::coin::total_supply<GATES>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<GATES>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

