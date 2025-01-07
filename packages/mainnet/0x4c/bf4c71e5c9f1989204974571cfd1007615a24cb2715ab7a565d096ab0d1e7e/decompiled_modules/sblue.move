module 0x4cbf4c71e5c9f1989204974571cfd1007615a24cb2715ab7a565d096ab0d1e7e::sblue {
    struct SBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLUE>(arg0, 6, b"SBLUE", b"Shades Of Blue", b"All shades of blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shades_c8c68a943c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

