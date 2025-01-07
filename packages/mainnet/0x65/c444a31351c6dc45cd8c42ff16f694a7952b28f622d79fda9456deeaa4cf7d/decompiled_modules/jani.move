module 0x65c444a31351c6dc45cd8c42ff16f694a7952b28f622d79fda9456deeaa4cf7d::jani {
    struct JANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JANI>(arg0, 6, b"JANI", b"JANISUI", b"Relentless conquest to dominate SUI once and for all! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_Y_Sgra_YK_400x400_26a526e46d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JANI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JANI>>(v1);
    }

    // decompiled from Move bytecode v6
}

