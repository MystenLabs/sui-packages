module 0xf37174bb55138293817d3bc17b22b8f01483f92e386309f2d6943e60a47c0051::uhhh {
    struct UHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: UHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UHHH>(arg0, 6, b"Uhhh", b"uhhh", b"uhhhhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SRDN_7npw9_S8_Rowvwt_Bf_Uqa_Pe_R8ib_Qq4u_D29_Zep_D79_M_Gw_241dc60aab.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UHHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

