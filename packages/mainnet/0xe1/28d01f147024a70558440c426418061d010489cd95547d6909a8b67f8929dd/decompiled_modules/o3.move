module 0xe128d01f147024a70558440c426418061d010489cd95547d6909a8b67f8929dd::o3 {
    struct O3 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<O3>, arg1: 0x2::coin::Coin<O3>) {
        0x2::coin::burn<O3>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<O3>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<O3> {
        0x2::coin::mint<O3>(arg0, arg1, arg2)
    }

    fun init(arg0: O3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<O3>(arg0, 6, b"o3", b"OOO", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1762094773586CIpb.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<O3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<O3>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<O3>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<O3> {
        assert!(0x2::coin::total_supply<O3>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<O3>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

