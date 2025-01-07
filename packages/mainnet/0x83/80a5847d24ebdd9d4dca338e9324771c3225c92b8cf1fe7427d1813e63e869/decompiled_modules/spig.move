module 0x8380a5847d24ebdd9d4dca338e9324771c3225c92b8cf1fe7427d1813e63e869::spig {
    struct SPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIG>(arg0, 6, b"SPIG", b"SuiPig", b"SPIG is a degen by night, also degen and gambler by day. I'm sure You have a lot in common.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_TGTW_3cab5e7ec3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

