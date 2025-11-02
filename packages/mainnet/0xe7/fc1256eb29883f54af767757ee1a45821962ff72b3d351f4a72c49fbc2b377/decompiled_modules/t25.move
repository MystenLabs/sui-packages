module 0xe7fc1256eb29883f54af767757ee1a45821962ff72b3d351f4a72c49fbc2b377::t25 {
    struct T25 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<T25>, arg1: 0x2::coin::Coin<T25>) {
        0x2::coin::burn<T25>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<T25>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T25> {
        0x2::coin::mint<T25>(arg0, arg1, arg2)
    }

    fun init(arg0: T25, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T25>(arg0, 6, b"t25", b"Token25", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1762073684127D8eG.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T25>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T25>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<T25>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T25> {
        assert!(0x2::coin::total_supply<T25>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<T25>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

