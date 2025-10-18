module 0x66b1a87edfc25be4fe2555b9883bdeb5308c7057faa2743ba6e3ad8a98ad1961::token1 {
    struct TOKEN1 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN1>, arg1: 0x2::coin::Coin<TOKEN1>) {
        0x2::coin::burn<TOKEN1>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TOKEN1> {
        0x2::coin::mint<TOKEN1>(arg0, arg1, arg2)
    }

    fun init(arg0: TOKEN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN1>(arg0, 6, b"Token1", b"Token2", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1760774107488anyP.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN1>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<TOKEN1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TOKEN1> {
        assert!(0x2::coin::total_supply<TOKEN1>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<TOKEN1>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

