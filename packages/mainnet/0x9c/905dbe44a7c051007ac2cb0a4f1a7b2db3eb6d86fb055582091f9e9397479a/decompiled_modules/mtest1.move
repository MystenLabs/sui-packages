module 0x9c905dbe44a7c051007ac2cb0a4f1a7b2db3eb6d86fb055582091f9e9397479a::mtest1 {
    struct MTEST1 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MTEST1>, arg1: 0x2::coin::Coin<MTEST1>) {
        0x2::coin::burn<MTEST1>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<MTEST1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MTEST1> {
        0x2::coin::mint<MTEST1>(arg0, arg1, arg2)
    }

    fun init(arg0: MTEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTEST1>(arg0, 6, b"MTest1", b"MTEST1", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1760423277085pKrA.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTEST1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTEST1>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<MTEST1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MTEST1> {
        assert!(0x2::coin::total_supply<MTEST1>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<MTEST1>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

