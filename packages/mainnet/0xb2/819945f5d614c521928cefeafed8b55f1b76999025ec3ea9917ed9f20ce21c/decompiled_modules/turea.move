module 0xb2819945f5d614c521928cefeafed8b55f1b76999025ec3ea9917ed9f20ce21c::turea {
    struct TUREA has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TUREA>, arg1: 0x2::coin::Coin<TUREA>) {
        0x2::coin::burn<TUREA>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<TUREA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TUREA> {
        0x2::coin::mint<TUREA>(arg0, arg1, arg2)
    }

    fun init(arg0: TUREA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUREA>(arg0, 6, b"TUREA", b"pictu", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758872602667R7i6.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUREA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUREA>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<TUREA>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TUREA> {
        assert!(0x2::coin::total_supply<TUREA>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<TUREA>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

