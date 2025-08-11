module 0xac9944c538cf351ecf49fbaecb7823f2ce6ac60eeec080eee2a0b7ab76fa004e::tesapp {
    struct TESAPP has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESAPP>, arg1: 0x2::coin::Coin<TESAPP>) {
        0x2::coin::burn<TESAPP>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESAPP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TESAPP> {
        0x2::coin::mint<TESAPP>(arg0, arg1, arg2)
    }

    fun init(arg0: TESAPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESAPP>(arg0, 6, b"TESAPP", b"tesapp", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://lks3-bucket.s3.ap-southeast-1.amazonaws.com/175464719410974ai.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESAPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESAPP>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<TESAPP>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TESAPP> {
        assert!(0x2::coin::total_supply<TESAPP>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<TESAPP>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

