module 0x28458ad16ada9bd239558a7b609949156c45752abce0e68320cef7f2331fe6cb::diahands {
    struct DIAHANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAHANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAHANDS>(arg0, 6, b"DIAHANDS", b"DIAMOND HANDS", b"I AM NOT FKING SELLING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/200w_e83bf7416f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAHANDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIAHANDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

