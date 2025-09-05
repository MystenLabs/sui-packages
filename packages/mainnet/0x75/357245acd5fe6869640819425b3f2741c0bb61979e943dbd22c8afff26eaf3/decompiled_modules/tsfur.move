module 0x75357245acd5fe6869640819425b3f2741c0bb61979e943dbd22c8afff26eaf3::tsfur {
    struct TSFUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSFUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSFUR>(arg0, 9, b"TSFUR", b"TestCoin4", b"This is a test coin. | Website: https://interestlabs.io/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.interestlabs.io/files/61e311815059ee4c70fbd7d72da6ff7cd7409594330e0b43.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSFUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSFUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

