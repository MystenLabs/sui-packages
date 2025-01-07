module 0x81673d6b5d12b92fb82d7f4dbce342fff41b0b43ee8d8160c35763f952913111::mgc {
    struct MGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGC>(arg0, 6, b"MGC", b"magcat", b"Welcome to the magical world of MagCat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Z_Ted436_Fox1if_Gy_Ju_EQ_Vao1tds3z4m_Rbv_Xacq_Z_Quezv_a990e88ad9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

