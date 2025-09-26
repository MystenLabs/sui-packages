module 0x39f5791d2f6e260ce8fc9c71c3db5cde37ba6cb5c64ffa3f1b156bcda81358b5::lllll {
    struct LLLLL has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LLLLL>, arg1: 0x2::coin::Coin<LLLLL>) {
        0x2::coin::burn<LLLLL>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<LLLLL>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LLLLL> {
        0x2::coin::mint<LLLLL>(arg0, arg1, arg2)
    }

    fun init(arg0: LLLLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLLLL>(arg0, 6, b"LLLLL", b"nasj", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758871456051Agdc.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLLLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLLLL>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<LLLLL>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LLLLL> {
        assert!(0x2::coin::total_supply<LLLLL>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<LLLLL>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

