module 0x3f46f3381063161e981f1bf0996e57566e6f51a1935a92e5651b67807367466b::t8898e28c {
    struct T8898E28C has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<T8898E28C>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T8898E28C>>(0x2::coin::mint<T8898E28C>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: T8898E28C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T8898E28C>(arg0, 9, b"MTK", b"MyToken", b"MyToken", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T8898E28C>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T8898E28C>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

