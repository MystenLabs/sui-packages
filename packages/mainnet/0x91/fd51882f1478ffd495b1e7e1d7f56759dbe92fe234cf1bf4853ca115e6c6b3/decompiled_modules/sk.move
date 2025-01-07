module 0x91fd51882f1478ffd495b1e7e1d7f56759dbe92fe234cf1bf4853ca115e6c6b3::sk {
    struct SK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SK>(arg0, 6, b"SK", b"Ski cat", b"Let's go skiing together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RJ_Nzd_QDYPYZ_Vnsupfg4_Kx3_Ld7c_FA_2c_Vvz_G_Gtj_Xjo_Ez9_R_1006e5746d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SK>>(v1);
    }

    // decompiled from Move bytecode v6
}

