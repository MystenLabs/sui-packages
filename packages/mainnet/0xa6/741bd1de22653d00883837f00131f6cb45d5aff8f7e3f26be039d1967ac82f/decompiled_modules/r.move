module 0xa6741bd1de22653d00883837f00131f6cb45d5aff8f7e3f26be039d1967ac82f::r {
    struct R has drop {
        dummy_field: bool,
    }

    fun init(arg0: R, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<R>(arg0, 6, b"R", b"rifa by SuiAI", b"Rifa Token is the new Agent From SUAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/flux_dev_create_an_eyecatching_visual_illustration_of_rifa_a_h_0_b291c4cc_eecc_41ef_90ce_34e5f043e9af_4bd1e1e512.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<R>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

