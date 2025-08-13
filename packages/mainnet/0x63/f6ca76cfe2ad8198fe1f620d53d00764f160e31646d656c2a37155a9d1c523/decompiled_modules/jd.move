module 0x63f6ca76cfe2ad8198fe1f620d53d00764f160e31646d656c2a37155a9d1c523::jd {
    struct JD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JD>, arg1: 0x2::coin::Coin<JD>) {
        0x2::coin::burn<JD>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<JD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JD> {
        0x2::coin::mint<JD>(arg0, arg1, arg2)
    }

    fun init(arg0: JD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JD>(arg0, 6, b"JD", b"dd", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"ddd"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JD>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<JD>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JD> {
        assert!(0x2::coin::total_supply<JD>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<JD>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

