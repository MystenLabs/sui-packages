module 0x63af7253dc2c151752ecac4fb1318bd06db36c19292944b965c7e6d5d0a30a48::acc {
    struct ACC has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ACC>, arg1: 0x2::coin::Coin<ACC>) {
        0x2::coin::burn<ACC>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<ACC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ACC> {
        0x2::coin::mint<ACC>(arg0, arg1, arg2)
    }

    fun init(arg0: ACC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACC>(arg0, 6, b"ACC", b"ACECOIN", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758789624190sS9s.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACC>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<ACC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ACC> {
        assert!(0x2::coin::total_supply<ACC>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<ACC>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

