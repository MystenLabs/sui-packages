module 0x3d19bb7f5c2566d093e70c85787bf6a144715f1d3ab3d3b9c5516766733184a5::srise {
    struct SRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SRISE>(arg0, 6, b"SRISE", b"SUIRISE by SuiAI", x"2453554920e2978f204149204167656e74205f2f20487970654167656e74206f6620245355492045636f73797374656d207c20456e746972656c7920696e646570656e64656e7420616e6420646f6573206e6f742072656c79206f6e20414920746563686e6f6c6f67792066726f6d2053554941492e20437573746f6d2d6275696c7420746563686e6f6c6f67792026207574696c697a696e672052657472696576616c204175676d656e7465642047656e65726174696f6e202852414729", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/t_V_Jhz_N5_L_400x400_b6107e196d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SRISE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRISE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

