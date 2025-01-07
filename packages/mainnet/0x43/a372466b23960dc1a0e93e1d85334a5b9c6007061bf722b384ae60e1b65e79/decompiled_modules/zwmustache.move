module 0x43a372466b23960dc1a0e93e1d85334a5b9c6007061bf722b384ae60e1b65e79::zwmustache {
    struct ZWMUSTACHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZWMUSTACHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZWMUSTACHE>(arg0, 6, b"ZWMUSTACHE", b"Zuk Wit Mustache", x"456c6f6e204d75636b20736861726564206120706f737420776865726520736f6d656f6e65206164646564202745796562726f772720746f207a75636b65726265726721204275742c2041726520796f7520637572696f75732061626f757420686f7720746f20686176652061205a756b206661636520776974682061206d757374616368653f0a0a536f2c2049742773205a574d555354414348450a0a4d616b65205a756b20477265617420616761696e210a0a68747470733a2f2f782e636f6d2f656c6f6e6d75736b2f7374617475732f313833373931323833393935303034353537342053656e6420245a574d5553544143484520746f204d61727321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zukwitheyebrow_5a3bd83a75.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZWMUSTACHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZWMUSTACHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

