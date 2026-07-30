module 0xb31f3721f4bef41984ad46317409f6304fb3b94ef77b1d9783cc83d7ca9d5ede::t074378f3 {
    struct T074378F3 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<T074378F3>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T074378F3>>(0x2::coin::mint<T074378F3>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: T074378F3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T074378F3>(arg0, 9, b"TST", b"Test", b"Test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T074378F3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T074378F3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

