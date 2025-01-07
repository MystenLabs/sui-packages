module 0xa74971c1d127a82260f4cabf231541cf7aa79e231a285ccf6f7a211bfdad3b97::pussui {
    struct PUSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSUI>(arg0, 6, b"PUSSUI", b"Pussui Cat", b"Ansems worst nightmare", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_54_162914c90a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

