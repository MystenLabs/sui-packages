module 0x361b6bbe86a05e3d33e9abd5dbd354e4076ff37a433183ec9469ba071f369045::t3 {
    struct T3 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<T3>, arg1: 0x2::coin::Coin<T3>) {
        0x2::coin::burn<T3>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<T3>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0x2::coin::mint<T3>(arg0, arg1, arg2)
    }

    fun init(arg0: T3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T3>(arg0, 6, b"T3", b"Token3", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1760437482104MlOb.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T3>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<T3>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        assert!(0x2::coin::total_supply<T3>(arg0) + 1000000000 <= 1000000000, 0);
        0x2::coin::mint<T3>(arg0, 1000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

