module 0xf50722e0cd45e8e37bcdf8bb30a4d9f0b72fc0a272d9a11d1a6e649fb0046678::beagie {
    struct BEAGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAGIE>(arg0, 6, b"Beagie", b"Beagie The Beagle", x"436869656620476f6f6465737420426f7920617420426561676c65204461696c7920f09f93b00a596f7572206461696c7920646f7365206f66207061772d66657373696f6e616c207265706f7274696e672e20427265616b696e67206e6577732066726f6d20756e646572207468652064696e6e6572207461626c6520746f2061626f76652074686520636f7563682e204e6f20737175697272656c206d6f76656d656e7420676f657320756e7265706f72746564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734875605340.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAGIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAGIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

