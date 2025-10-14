module 0x83e95f0b0337e1b6bf6f8548e8e446596779e11e35af8180e6276036c81a9ea6::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUN>, arg1: 0x2::coin::Coin<SUN>) {
        0x2::coin::burn<SUN>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUN> {
        0x2::coin::mint<SUN>(arg0, arg1, arg2)
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN>(arg0, 6, b"sun", b"SUN", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1760453352436ovSO.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUN>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<SUN>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUN> {
        assert!(0x2::coin::total_supply<SUN>(arg0) + 100000000 <= 100000000, 0);
        0x2::coin::mint<SUN>(arg0, 100000000, arg1)
    }

    // decompiled from Move bytecode v6
}

