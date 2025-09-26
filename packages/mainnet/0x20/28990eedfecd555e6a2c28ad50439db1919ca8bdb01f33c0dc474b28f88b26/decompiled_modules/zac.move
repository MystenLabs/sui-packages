module 0x2028990eedfecd555e6a2c28ad50439db1919ca8bdb01f33c0dc474b28f88b26::zac {
    struct ZAC has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZAC>, arg1: 0x2::coin::Coin<ZAC>) {
        0x2::coin::burn<ZAC>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZAC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ZAC> {
        0x2::coin::mint<ZAC>(arg0, arg1, arg2)
    }

    fun init(arg0: ZAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAC>(arg0, 6, b"ZAC", b"recinned", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758864632992O6bo.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAC>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<ZAC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ZAC> {
        assert!(0x2::coin::total_supply<ZAC>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<ZAC>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

