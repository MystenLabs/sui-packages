module 0x96404a04ead9a51e1e5425f92d788b540753cedaa82c213337236e1275fe3152::wooo {
    struct WOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOO>(arg0, 6, b"WOOO", b"WOO0!", x"546865205374796c696e272c2070726f66696c696e272c206c696d6f7573696e6520726964696e672c206a657420666c79696e672c206b6973732d737465616c696e672c20776865656c696e27206e27206465616c696e2720736f6e206f6620612067756e210a496620796f7520646f6e2774206c696b652069742c206c6561726e20746f202a6c6f76652a2069742120574f4f4f4f4f4f212121212120434f4d4d554e4954592057494c4c204d4f4f4e205553204153205745204255494c4420574f4f4f204d494c4c494f4e414952455320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6295_a48cf769d6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

