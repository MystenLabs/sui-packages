module 0x3695dbc865ba973ac284d410fda6a8170fe7a293ad6ed3d443c0dad0fb7d3210::who {
    struct WHO has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<WHO>, arg1: 0x2::coin::Coin<WHO>) {
        0x2::coin::burn<WHO>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<WHO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WHO> {
        0x2::coin::mint<WHO>(arg0, arg1, arg2)
    }

    fun init(arg0: WHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHO>(arg0, 6, b"WHO", b"What", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758609029470ZUOS.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHO>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<WHO>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WHO> {
        assert!(0x2::coin::total_supply<WHO>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<WHO>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

