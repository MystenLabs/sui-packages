module 0x2d7bdb3dd6c1e7a91a23bb1a89828edee631c3b799ff4ca771b2a827caa74139::perhino {
    struct PERHINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERHINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERHINO>(arg0, 6, b"PERHINO", b"perhino", b"PERHINO ON MOVE PUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_36dd99b861.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERHINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERHINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

