module 0x48e889379b08398bd3911af35eb1f4107598817e434ad79e774e4ded35a7dd22::rain {
    struct RAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAIN>(arg0, 6, b"RAIN", b"Rain the parrot", b"rain the parrot goes graaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_35_87253b55f5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

