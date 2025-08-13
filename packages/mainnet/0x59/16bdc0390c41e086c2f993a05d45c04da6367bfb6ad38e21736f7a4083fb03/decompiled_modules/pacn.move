module 0x5916bdc0390c41e086c2f993a05d45c04da6367bfb6ad38e21736f7a4083fb03::pacn {
    struct PACN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PACN>, arg1: 0x2::coin::Coin<PACN>) {
        0x2::coin::burn<PACN>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<PACN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PACN> {
        0x2::coin::mint<PACN>(arg0, arg1, arg2)
    }

    fun init(arg0: PACN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACN>(arg0, 6, b"PACN", b"ppp", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"oic"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PACN>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<PACN>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PACN> {
        assert!(0x2::coin::total_supply<PACN>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<PACN>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

