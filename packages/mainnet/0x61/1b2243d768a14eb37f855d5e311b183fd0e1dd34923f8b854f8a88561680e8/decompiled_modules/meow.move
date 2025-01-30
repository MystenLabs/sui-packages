module 0x611b2243d768a14eb37f855d5e311b183fd0e1dd34923f8b854f8a88561680e8::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"MEOW Task Force", x"4d616e6167656d656e74206f66204574686963616c204f7665727369676874202620576f726b666f72636520284d454f57292070726f74656374732064656d6f63726163792c20636f756e746572696e6720444f4745e2809973206d697373696f6e20746f207765616b656e206f757220676f7665726e6d656e7420616e642064657374726f792074686520555320436f6e737469747574696f6e2e0a0a4669676874696e6720556e636865636b656420436f7272757074696f6e2c204b656570696e67200a44656d6f6372616379204f7065726174696f6e616c2c2047756172616e746565696e67204574686963732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738202430804.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

