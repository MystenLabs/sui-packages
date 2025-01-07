module 0xabc607d4c3d523d3cba0664d49564a7c26120bb4b408c48cc32f0f4fc6c20851::ughugh {
    struct UGHUGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: UGHUGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UGHUGH>(arg0, 6, b"UGHUGH", b"aaaUGHaaa", b"aaa ugh aaa ugh aaa ugh aaa ugh aaa ugh aaa ugh aaa ugh aaa ugh aaa ugh aaa ugh aaa ugh aaa ugh ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_0918b4ca51.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UGHUGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UGHUGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

