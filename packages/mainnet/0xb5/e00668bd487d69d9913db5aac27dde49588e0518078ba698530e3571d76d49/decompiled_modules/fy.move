module 0xb5e00668bd487d69d9913db5aac27dde49588e0518078ba698530e3571d76d49::fy {
    struct FY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FY>(arg0, 6, b"FY", b"Fuck You", b"Fuck all the jeeters, Scammers, Rugg pull, bad whales and Market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000_F_336934660_TLYNV_Iw4_X_Ff_Sv_PVKV_Rrpr_Ko6q_EI_Czd_RI_589955ce44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

