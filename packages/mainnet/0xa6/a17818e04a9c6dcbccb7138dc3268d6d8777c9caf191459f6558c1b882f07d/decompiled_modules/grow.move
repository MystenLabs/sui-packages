module 0xa6a17818e04a9c6dcbccb7138dc3268d6d8777c9caf191459f6558c1b882f07d::grow {
    struct GROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROW>(arg0, 6, b"Grow", b"SuiGrow", b"Together, Sui grow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011541_7f9eadd16d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

