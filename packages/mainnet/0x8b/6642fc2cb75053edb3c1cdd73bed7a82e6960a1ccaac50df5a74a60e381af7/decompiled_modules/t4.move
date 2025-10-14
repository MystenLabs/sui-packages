module 0x8b6642fc2cb75053edb3c1cdd73bed7a82e6960a1ccaac50df5a74a60e381af7::t4 {
    struct T4 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<T4>, arg1: 0x2::coin::Coin<T4>) {
        0x2::coin::burn<T4>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<T4>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        0x2::coin::mint<T4>(arg0, arg1, arg2)
    }

    fun init(arg0: T4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T4>(arg0, 6, b"T4", b"Token4", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1760438260575NsRB.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T4>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<T4>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        assert!(0x2::coin::total_supply<T4>(arg0) + 1000000000 <= 1000000000, 0);
        0x2::coin::mint<T4>(arg0, 1000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

