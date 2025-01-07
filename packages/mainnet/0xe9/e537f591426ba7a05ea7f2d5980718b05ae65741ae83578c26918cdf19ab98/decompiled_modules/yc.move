module 0xe9e537f591426ba7a05ea7f2d5980718b05ae65741ae83578c26918cdf19ab98::yc {
    struct YC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YC>(arg0, 6, b"YC", b"You Cats", x"4469766520696e746f20746865207075727266656374206d656d6520746f6b656e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731009580377.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

