module 0x7d6260e9ba750e11e90d376ecbd6ff7e92e88d590d6d52187cb91d26d7fadcf3::tem {
    struct TEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEM>(arg0, 6, b"TEM", b"TOKEN EASY to MISS", x"536f6d6520636861736520746865206c6967687420616e64206d6973732074686520676c65616d2c0a4d697374616b696e67206e6f69736520666f7220747275746827732070757265206265616d2e0a4275742074686f73652077686f20706175736520616e64206c6574207468696e67732062652c0a4d69676874206a75737420756e636f76657220776861742063616e2774206265207365656e2e0a5468652074727574682c206c696b652073746172732c20636f6e6e6563747320696e2073706f7473e280940a596f75e280996c6c206f6e6c792066696e64206974202774776978742074686520646f74732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751010189913.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

