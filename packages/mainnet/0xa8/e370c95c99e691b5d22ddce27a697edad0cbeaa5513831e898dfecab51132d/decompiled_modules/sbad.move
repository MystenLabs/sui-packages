module 0xa8e370c95c99e691b5d22ddce27a697edad0cbeaa5513831e898dfecab51132d::sbad {
    struct SBAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBAD>(arg0, 6, b"SBAD", b"SINBAD", b" Sinbad Token  | Navigating the seas of crypto with innovation and purpose.  | Join our voyage to decentralized success! | ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2b_HRB_Iu7_R5_C_Tjv89vn_F_xg_232faec3fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

