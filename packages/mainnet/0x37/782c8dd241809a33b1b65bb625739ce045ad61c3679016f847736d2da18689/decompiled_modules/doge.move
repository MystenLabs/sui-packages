module 0x37782c8dd241809a33b1b65bb625739ce045ad61c3679016f847736d2da18689::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"Department of Government Efficiency", x"576f726b696e67206f76657274696d6520746f20656e7375726520796f75722074617820646f6c6c6172732077696c6c206265207370656e7420776973656c79210a444f4745204f6e2053756920636861696e204d656d6520546f6b656e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003204_5f23ba2187.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

