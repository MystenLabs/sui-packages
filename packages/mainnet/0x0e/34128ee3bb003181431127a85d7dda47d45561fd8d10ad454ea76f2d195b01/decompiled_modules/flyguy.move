module 0xe34128ee3bb003181431127a85d7dda47d45561fd8d10ad454ea76f2d195b01::flyguy {
    struct FLYGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLYGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYGUY>(arg0, 6, b"FLYGUY", b"FlyGuy", x"576861742773207570206974277320466c794775792c206a6f696e206d7920646973636f726420696620796f7527726520636f6f6c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_NX_2_Lydfw4_Ty2e_H_Se_Z_Vm_Qw_Hin_U_Weyes_V_Rd_Khh_R4_Uuz6kd_891092831d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLYGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

