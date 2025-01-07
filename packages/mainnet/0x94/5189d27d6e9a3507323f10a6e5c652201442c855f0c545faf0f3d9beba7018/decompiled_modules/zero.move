module 0x945189d27d6e9a3507323f10a6e5c652201442c855f0c545faf0f3d9beba7018::zero {
    struct ZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZERO>(arg0, 6, b"ZERO", b"zero", b"Jack Skellington's pet ghost dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_APV_Ba_Rw_Wyz_C4s5_V_Bh_Snh5xqfi_VH_75_Ev_A_Aszmb_Crib_Pr_d0a437bffe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

