module 0x30710aff1ff194e60bc4578ded3ffb0a7bf83c021ed05859c8b560a2e647d954::froge {
    struct FROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGE>(arg0, 6, b"FROGE", b"FROGE on SUI", x"2446524f474520636f6d6d756e697479206f6e205355492e2046726f676520746865206d6f7374206d656d6561626c652066726f67206973206865726520746f20737461792e2044696420796f75206865617220746861742046726f67652069732074686520756e6f6666696369616c206f6666696369616c206d6173636f74206f66206f70656e41493f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_wm_N6_LR_400x400_7c9a29560c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

