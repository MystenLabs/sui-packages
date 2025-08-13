module 0x410de4837e56b1844f901b0903fa7461fc1fe5c105f9369d0bca66c25fb32fb8::oo {
    struct OO has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<OO>, arg1: 0x2::coin::Coin<OO>) {
        0x2::coin::burn<OO>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<OO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<OO> {
        0x2::coin::mint<OO>(arg0, arg1, arg2)
    }

    fun init(arg0: OO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OO>(arg0, 6, b"OO", b"ii", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"dd"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OO>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<OO>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<OO> {
        assert!(0x2::coin::total_supply<OO>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<OO>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

