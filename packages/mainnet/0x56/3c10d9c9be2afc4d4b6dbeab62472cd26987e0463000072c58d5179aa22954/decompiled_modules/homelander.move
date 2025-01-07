module 0x563c10d9c9be2afc4d4b6dbeab62472cd26987e0463000072c58d5179aa22954::homelander {
    struct HOMELANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMELANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMELANDER>(arg0, 6, b"HOMELANDER", b"Homelander on Sui", x"24484f4d454c414e44455220666c69657320686967682061626f76652074686520537569204e6574776f726b2c20636f6d6d616e64696e6720617474656e74696f6e20616e64206372757368696e672065766572797468696e6720696e20686973207761792e205374726f6e672c20756e746f75636861626c652c20616e64206120666f72636520746f206265207265636b6f6e656420776974682e20506f7765727320696e20796f75722068616e6473206e6f77210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluedown_61567779b3.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMELANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMELANDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

