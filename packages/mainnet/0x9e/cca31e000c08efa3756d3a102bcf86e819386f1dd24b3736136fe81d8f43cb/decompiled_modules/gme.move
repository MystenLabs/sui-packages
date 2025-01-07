module 0x9ecca31e000c08efa3756d3a102bcf86e819386f1dd24b3736136fe81d8f43cb::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GME>(arg0, 6, b"GME", b"GameStop", x"47616d6553746f7020746f20746865206d6f6f6e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8w_Xt_Pe_U6557_E_Tkp9_WHFY_1n1_Ec_U6_Nx_Dvb_Agg_H_Gs_M_Yi_Hs_B_d01d689efc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GME>>(v1);
    }

    // decompiled from Move bytecode v6
}

