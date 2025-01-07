module 0x5e0e2d455bf85dea0bfc8672090181b603e43ca3143424e62597c30fe57989a5::joe {
    struct JOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOE>(arg0, 6, b"JOE", b"Sui Joe", x"4a6f652069732061206d656d6520636f696e20637265617465642061726f756e642074686520696e7465726e65742073656e736174696f6e2022656d6f746920677579222e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GW_1do_Mw_Xk_A_Aw7_Vc_94a065bc5a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

