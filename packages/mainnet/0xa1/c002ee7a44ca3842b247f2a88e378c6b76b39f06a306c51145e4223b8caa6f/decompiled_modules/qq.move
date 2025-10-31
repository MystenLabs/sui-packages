module 0xa1c002ee7a44ca3842b247f2a88e378c6b76b39f06a306c51145e4223b8caa6f::qq {
    struct QQ has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<QQ>, arg1: 0x2::coin::Coin<QQ>) {
        0x2::coin::burn<QQ>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<QQ>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<QQ> {
        0x2::coin::mint<QQ>(arg0, arg1, arg2)
    }

    fun init(arg0: QQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQ>(arg0, 6, b"qq", b"QQ", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1761924119711ZhEv.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QQ>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<QQ>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<QQ> {
        assert!(0x2::coin::total_supply<QQ>(arg0) + 1000000000000000 <= 1000000000000000, 0);
        0x2::coin::mint<QQ>(arg0, 1000000000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

