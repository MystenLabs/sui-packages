module 0x55b1c84ccf64ae591285e2e24f86fcf430ff58eca4d4284670c0539b824c84c6::len {
    struct LEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEN>(arg0, 6, b"LEN", b"SUI LEN", b"Foundoooor of Bitcoin - Len Sussaman $LEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dyg9_Hthwdken_Tocc_ZQM_76_Tj_W_Foq_S_Pf_Qd5d8i_R8vspump_6678304ca4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

