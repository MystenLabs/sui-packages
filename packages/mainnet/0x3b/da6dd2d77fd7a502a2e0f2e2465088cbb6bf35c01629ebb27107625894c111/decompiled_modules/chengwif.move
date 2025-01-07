module 0x3bda6dd2d77fd7a502a2e0f2e2465088cbb6bf35c01629ebb27107625894c111::chengwif {
    struct CHENGWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHENGWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENGWIF>(arg0, 6, b"Chengwif", b"Chengwifhat", b"Evan cheng is the Co-founder & CEO of Mysten Labs who bless us with this great ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/evan_cheng_d2f0d4c89e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENGWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHENGWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

