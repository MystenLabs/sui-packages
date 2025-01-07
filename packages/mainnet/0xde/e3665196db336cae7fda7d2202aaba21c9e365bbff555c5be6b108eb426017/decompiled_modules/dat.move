module 0xdee3665196db336cae7fda7d2202aaba21c9e365bbff555c5be6b108eb426017::dat {
    struct DAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAT>(arg0, 6, b"DAT", b"Moon Dat", x"4865617264205355492069732074686520636861696e20746f206265206f6e2e2e2e200a0a596561682062726f2c204d4f4f4e204441542e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Moon_b04a764c51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

