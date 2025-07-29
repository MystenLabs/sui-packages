module 0xc19192bdfdcdfe7d18371fa36495b353ef19514ca67ac760d9aa3bdf64b12247::plastic {
    struct PLASTIC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PLASTIC>, arg1: 0x2::coin::Coin<PLASTIC>) {
        0x2::coin::burn<PLASTIC>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PLASTIC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PLASTIC> {
        0x2::coin::mint<PLASTIC>(arg0, arg1, arg2)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<PLASTIC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PLASTIC>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PLASTIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLASTIC>(arg0, 3, b"PLASTIC", b"Plastic Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dxe233s0t38k9.cloudfront.net/Frame%203.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLASTIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLASTIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

