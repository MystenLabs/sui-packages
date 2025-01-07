module 0x2a1e179c106b39d564833f9aa3fc39465ff32865081c50e2bb57e438e793f09b::dorm {
    struct DORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORM>(arg0, 8, b"DORM", b"DORM", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DORM>>(v1);
        0x2::coin::mint_and_transfer<DORM>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DORM>>(v2);
    }

    // decompiled from Move bytecode v6
}

