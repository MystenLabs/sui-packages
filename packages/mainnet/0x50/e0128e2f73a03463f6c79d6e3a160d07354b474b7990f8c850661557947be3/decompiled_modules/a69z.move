module 0x50e0128e2f73a03463f6c79d6e3a160d07354b474b7990f8c850661557947be3::a69z {
    struct A69Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: A69Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A69Z>(arg0, 6, b"A69Z", b"a69z", x"6d656d65732061726520656174696e672074686520776f726c640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_At_HX_6a_M_Gg_Grmu2_Fm_Xepu_Jve_Y_Apxe_X_Upi_Vfk5_HG_Nv6_Y2_82836cf578.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A69Z>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A69Z>>(v1);
    }

    // decompiled from Move bytecode v6
}

