module 0x8aa872bea204f43cc28df7689520d3048910f5fd497e29fdb2a6ef84a69d6cba::snut {
    struct SNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUT>(arg0, 6, b"SNUT", b"Arc On SUI", b"Not a copy, just thinking in simply net, it is what a catching vibe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_Oj_Zdgpc_400x400_fc4fb5ef7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

