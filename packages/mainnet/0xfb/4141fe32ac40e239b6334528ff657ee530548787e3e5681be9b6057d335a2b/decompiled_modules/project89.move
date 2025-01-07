module 0xfb4141fe32ac40e239b6334528ff657ee530548787e3e5681be9b6057d335a2b::project89 {
    struct PROJECT89 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROJECT89, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROJECT89>(arg0, 6, b"Project89", b"Project_89", b"This is interactive conduit for a neurolinguistic virus. Memetic Infection Machine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bz4_Mhm_VRQE_Ni_Cou7_Zp_J575wpj_N_Fj_Bj_VB_Si_Vhu_Ng1pump_8233f129e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROJECT89>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PROJECT89>>(v1);
    }

    // decompiled from Move bytecode v6
}

