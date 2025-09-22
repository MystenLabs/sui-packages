module 0x7eaf80e1b64a1c07bc06c111e01bea1eb6555ea556edf7cf80aa1bb6c111ff21::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MONKEY>, arg1: 0x2::coin::Coin<MONKEY>) {
        0x2::coin::burn<MONKEY>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<MONKEY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MONKEY> {
        0x2::coin::mint<MONKEY>(arg0, arg1, arg2)
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"MONKEY", b"MONKEYs", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758511273328Yqcc.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<MONKEY>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MONKEY> {
        assert!(0x2::coin::total_supply<MONKEY>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<MONKEY>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

