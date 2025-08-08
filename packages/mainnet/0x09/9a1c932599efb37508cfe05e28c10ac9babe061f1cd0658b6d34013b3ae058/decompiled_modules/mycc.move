module 0x99a1c932599efb37508cfe05e28c10ac9babe061f1cd0658b6d34013b3ae058::mycc {
    struct MYCC has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYCC>, arg1: 0x2::coin::Coin<MYCC>) {
        0x2::coin::burn<MYCC>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MYCC> {
        0x2::coin::mint<MYCC>(arg0, arg1, arg2)
    }

    fun init(arg0: MYCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCC>(arg0, 6, b"MYCC", b"MyccCoin", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"xxxx.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCC>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<MYCC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MYCC> {
        assert!(0x2::coin::total_supply<MYCC>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<MYCC>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

