module 0x45fa5420341d3b166e4083f3ceda39fe1cf492c01b083b18e649bb76921e3709::hfrog {
    struct HFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFROG>(arg0, 6, b"HFROG", b"HOPFROG", x"4920676f74207468697320486f6e6f72617279207066702066726f6d2040486f7046726f675375690a53656e736569206973206c6f636b656420696e2031322f31302f3234205768617420646f207468696e6b206f66206d7920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018270_d69b410c2b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

