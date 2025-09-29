module 0xf01831aa54675ebc8b6ffccdac210a932626f678a80012b1df2d6628074aa08b::johnson9 {
    struct JOHNSON9 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON9>, arg1: 0x2::coin::Coin<JOHNSON9>) {
        0x2::coin::burn<JOHNSON9>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON9>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JOHNSON9> {
        0x2::coin::mint<JOHNSON9>(arg0, arg1, arg2)
    }

    fun init(arg0: JOHNSON9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOHNSON9>(arg0, 6, b"JOHNSON9", b"johnson9", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/175911884915124uq.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOHNSON9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOHNSON9>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON9>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JOHNSON9> {
        assert!(0x2::coin::total_supply<JOHNSON9>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<JOHNSON9>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

