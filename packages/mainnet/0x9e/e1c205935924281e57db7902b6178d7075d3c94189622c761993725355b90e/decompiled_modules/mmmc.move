module 0x9ee1c205935924281e57db7902b6178d7075d3c94189622c761993725355b90e::mmmc {
    struct MMMC has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MMMC>, arg1: 0x2::coin::Coin<MMMC>) {
        0x2::coin::burn<MMMC>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<MMMC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MMMC> {
        0x2::coin::mint<MMMC>(arg0, arg1, arg2)
    }

    fun init(arg0: MMMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMMC>(arg0, 6, b"MMMC", b"ooo", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"hhh"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMMC>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<MMMC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MMMC> {
        assert!(0x2::coin::total_supply<MMMC>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<MMMC>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

