module 0xed2d121c05eac4ad9c66a7e05171d085cf3c8d2884d307a1689147dba4c7e55::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: 0x2::coin::Coin<TEST>) {
        0x2::coin::burn<TEST>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST> {
        0x2::coin::mint<TEST>(arg0, arg1, arg2)
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TEST", b"good", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://example"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST> {
        assert!(0x2::coin::total_supply<TEST>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<TEST>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

