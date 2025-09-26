module 0x69e8470534858225cc95b06b471b6491ada3a34a3ec4cab0a3ea0e6af55a8d0e::memoricz {
    struct MEMORICZ has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEMORICZ>, arg1: 0x2::coin::Coin<MEMORICZ>) {
        0x2::coin::burn<MEMORICZ>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEMORICZ>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MEMORICZ> {
        0x2::coin::mint<MEMORICZ>(arg0, arg1, arg2)
    }

    fun init(arg0: MEMORICZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMORICZ>(arg0, 6, b"MEMORICZ", b"easyit", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758851121448gbQ0.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMORICZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMORICZ>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<MEMORICZ>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MEMORICZ> {
        assert!(0x2::coin::total_supply<MEMORICZ>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<MEMORICZ>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

