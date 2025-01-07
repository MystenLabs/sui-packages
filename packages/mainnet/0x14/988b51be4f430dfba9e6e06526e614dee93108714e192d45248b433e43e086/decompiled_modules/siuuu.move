module 0x14988b51be4f430dfba9e6e06526e614dee93108714e192d45248b433e43e086::siuuu {
    struct SIUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUU>(arg0, 6, b"SIUUU", b"SIUUU on SUI", x"57656c636f6d6520746f20245349555555206f6e2053554920626c6f636b636861696e210a24534955555520697320746865206d656d6520636f696e207468617420756e69746573204352372066616e7320616e642063727970746f20656e74687573696173747321200a204a6f696e20757320696e206372656174696e6720746865206e657874206269672077617665206f662046616e20546f6b656e73206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/il_794x_N_3737930292_b1t9_02a75faeef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

