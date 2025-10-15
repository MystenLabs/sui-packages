module 0x8e411ea917a7be41ba9e2a846aeaf4d7189d0a5cda4125c90980a38be2b2fbcf::t1 {
    struct T1 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::coin::burn<T1>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::mint<T1>(arg0, arg1, arg2)
    }

    fun init(arg0: T1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T1>(arg0, 6, b"T1", b"Token1", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1760491402408y3YF.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T1>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::total_supply<T1>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<T1>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

