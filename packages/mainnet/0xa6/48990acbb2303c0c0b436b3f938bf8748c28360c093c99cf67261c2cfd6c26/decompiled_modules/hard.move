module 0xa648990acbb2303c0c0b436b3f938bf8748c28360c093c99cf67261c2cfd6c26::hard {
    struct HARD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HARD>, arg1: 0x2::coin::Coin<HARD>) {
        0x2::coin::burn<HARD>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<HARD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HARD> {
        0x2::coin::mint<HARD>(arg0, arg1, arg2)
    }

    fun init(arg0: HARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARD>(arg0, 6, b"HARD", b"hard", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1762064358803d28L.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HARD>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<HARD>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HARD> {
        assert!(0x2::coin::total_supply<HARD>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<HARD>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

