module 0xfa95356d888015d14d5875f512cf18a19ac6d325413c8e2847d7b389d86d624f::fillss {
    struct FILLSS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FILLSS>, arg1: 0x2::coin::Coin<FILLSS>) {
        0x2::coin::burn<FILLSS>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<FILLSS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FILLSS> {
        0x2::coin::mint<FILLSS>(arg0, arg1, arg2)
    }

    fun init(arg0: FILLSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FILLSS>(arg0, 6, b"FILLSS", b"fills", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1757641930423Aj3d.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FILLSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FILLSS>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<FILLSS>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FILLSS> {
        assert!(0x2::coin::total_supply<FILLSS>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<FILLSS>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

