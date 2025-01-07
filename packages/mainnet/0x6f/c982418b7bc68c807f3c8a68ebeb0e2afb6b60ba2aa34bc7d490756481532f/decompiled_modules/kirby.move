module 0x6fc982418b7bc68c807f3c8a68ebeb0e2afb6b60ba2aa34bc7d490756481532f::kirby {
    struct KIRBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRBY>(arg0, 6, b"KIRBY", b"Kirby on Sui", b"kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby kirby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hmx9_A_Yam_RA_Cq_Lvxtc1q_Whc_Ptv_Ybs_Skvo_Ye97uffipump_b3b1e82cc7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIRBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

