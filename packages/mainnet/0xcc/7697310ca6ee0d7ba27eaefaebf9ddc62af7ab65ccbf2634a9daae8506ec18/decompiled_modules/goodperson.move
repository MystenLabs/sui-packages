module 0xcc7697310ca6ee0d7ba27eaefaebf9ddc62af7ab65ccbf2634a9daae8506ec18::goodperson {
    struct GOODPERSON has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GOODPERSON>, arg1: 0x2::coin::Coin<GOODPERSON>) {
        0x2::coin::burn<GOODPERSON>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOODPERSON>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<GOODPERSON> {
        0x2::coin::mint<GOODPERSON>(arg0, arg1, arg2)
    }

    fun init(arg0: GOODPERSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOODPERSON>(arg0, 6, b"GOODPERSON", b"dd", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOODPERSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOODPERSON>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<GOODPERSON>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<GOODPERSON> {
        assert!(0x2::coin::total_supply<GOODPERSON>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<GOODPERSON>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

