module 0xa43259589f10c965958ebabd3d6e3c3fce8473e849e4b1f9d7765776d13056db::halloweenkin {
    struct HALLOWEENKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWEENKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWEENKIN>(arg0, 6, b"HALLOWEENKIN", b"Halloweenkin", x"48616c6c6f7765656e2050756d706b696e2073756920636861696e204d656d652050726f6a656374200a0a537469636b657220706163206973206c6976650a0a687474703a2f2f742e6d652f616464737469636b6572732f48616c6c6f7765656e6b696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031055_7ea9fbbea7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWEENKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOWEENKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

