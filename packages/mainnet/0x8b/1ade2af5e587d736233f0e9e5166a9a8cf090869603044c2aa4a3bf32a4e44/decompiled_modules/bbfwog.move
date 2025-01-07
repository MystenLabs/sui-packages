module 0x8b1ade2af5e587d736233f0e9e5166a9a8cf090869603044c2aa4a3bf32a4e44::bbfwog {
    struct BBFWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBFWOG>(arg0, 6, b"BBFWOG", b"Baby Fwog", b"Just a baby fwog in a big pond.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_j_bitk_A_p_7d9ba675af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBFWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBFWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

