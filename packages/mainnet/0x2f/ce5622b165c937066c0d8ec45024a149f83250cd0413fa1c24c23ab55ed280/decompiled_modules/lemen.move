module 0x2fce5622b165c937066c0d8ec45024a149f83250cd0413fa1c24c23ab55ed280::lemen {
    struct LEMEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LEMEN>, arg1: 0x2::coin::Coin<LEMEN>) {
        0x2::coin::burn<LEMEN>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<LEMEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LEMEN> {
        0x2::coin::mint<LEMEN>(arg0, arg1, arg2)
    }

    fun init(arg0: LEMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMEN>(arg0, 6, b"LEMEN", b"elemen77", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758873066129nCbK.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEMEN>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<LEMEN>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LEMEN> {
        assert!(0x2::coin::total_supply<LEMEN>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<LEMEN>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

