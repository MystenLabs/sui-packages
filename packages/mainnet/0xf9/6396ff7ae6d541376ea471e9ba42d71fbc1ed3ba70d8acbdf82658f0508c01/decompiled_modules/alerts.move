module 0xf96396ff7ae6d541376ea471e9ba42d71fbc1ed3ba70d8acbdf82658f0508c01::alerts {
    struct ALERTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALERTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALERTS>(arg0, 6, b"ALERTS", b"SUI Alerts", x"546865206e756d626572203120706c61636520746f2067657420616c6c2053554920426c6f636b636861696e20616c65727473206f6e2054656c656772616d0a2d20476574206e657720746f6b656e206465706c6f797320616c6572740a2d2047657420766f6c756d6520616c65727473206f6e206d6f766570756d700a2d20476574207768616c65206275797320616c65727473200a0a616e64206576656e206d6f72650a68747470733a2f2f742e6d652f6164646c6973742f5f685441303572757761557a4e7a4930", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/botpic_74bebe4208.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALERTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALERTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

