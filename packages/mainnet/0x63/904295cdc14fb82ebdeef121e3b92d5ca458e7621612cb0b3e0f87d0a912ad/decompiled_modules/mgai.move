module 0x63904295cdc14fb82ebdeef121e3b92d5ca458e7621612cb0b3e0f87d0a912ad::mgai {
    struct MGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGAI>(arg0, 6, b"MGAI", b"Massive Gains AI", b"Massive Gains AI ($MGAI) is a next-gen Sui memecoin blending AI hype with unstoppable gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_12_9ea6540cad.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

