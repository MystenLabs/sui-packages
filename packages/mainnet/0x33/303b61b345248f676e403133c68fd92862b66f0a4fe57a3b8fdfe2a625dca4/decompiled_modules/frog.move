module 0x33303b61b345248f676e403133c68fd92862b66f0a4fe57a3b8fdfe2a625dca4::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 6, b"FROG", b"HOPFROGSUI", x"4920676f74207468697320486f6e6f72617279207066702066726f6d2040486f7046726f675375690a53656e736569206973206c6f636b656420696e2031322f31302f3234205768617420646f207468696e6b206f66206d7920234e657750726f66696c655069633f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018269_378c058987.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

