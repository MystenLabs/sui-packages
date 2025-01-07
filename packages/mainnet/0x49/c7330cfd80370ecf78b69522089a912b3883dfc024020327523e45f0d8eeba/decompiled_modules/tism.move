module 0x49c7330cfd80370ecf78b69522089a912b3883dfc024020327523e45f0d8eeba::tism {
    struct TISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TISM>(arg0, 6, b"TISM", b"TISM SUI", b"The Tism spectrum directly aligns with crypto mastery. More Tism, more gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x6612c8419c70a706612e154ffcc0ef21b3fec6e4008b4b775ceae4e894d3484d_tism_tism_5cf550d08f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

