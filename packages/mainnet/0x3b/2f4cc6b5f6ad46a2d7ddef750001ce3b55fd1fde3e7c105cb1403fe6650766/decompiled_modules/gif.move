module 0x3b2f4cc6b5f6ad46a2d7ddef750001ce3b55fd1fde3e7c105cb1403fe6650766::gif {
    struct GIF has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GIF>, arg1: 0x2::coin::Coin<GIF>) {
        0x2::coin::burn<GIF>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<GIF>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<GIF> {
        0x2::coin::mint<GIF>(arg0, arg1, arg2)
    }

    fun init(arg0: GIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIF>(arg0, 6, b"GIF", b"Webf", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758694624888qKSI.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIF>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<GIF>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<GIF> {
        assert!(0x2::coin::total_supply<GIF>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<GIF>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

