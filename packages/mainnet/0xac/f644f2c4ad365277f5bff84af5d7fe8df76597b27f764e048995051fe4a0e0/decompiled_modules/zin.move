module 0xacf644f2c4ad365277f5bff84af5d7fe8df76597b27f764e048995051fe4a0e0::zin {
    struct ZIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZIN>, arg1: 0x2::coin::Coin<ZIN>) {
        0x2::coin::burn<ZIN>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ZIN> {
        0x2::coin::mint<ZIN>(arg0, arg1, arg2)
    }

    fun init(arg0: ZIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIN>(arg0, 6, b"ZIN", b"dd", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIN>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<ZIN>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ZIN> {
        assert!(0x2::coin::total_supply<ZIN>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<ZIN>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

