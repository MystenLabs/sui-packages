module 0x21395fbcbcb184fe329901d0c1665ae03b193696d891e5bd21eba3155e87705d::spx6900 {
    struct SPX6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX6900>(arg0, 6, b"SPX6900", b"S&P6900", x"4675636b2053746f636b73200a46756c6c20506f7274205355490a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7372_3833dad083.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPX6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

