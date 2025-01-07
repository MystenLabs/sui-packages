module 0x40a8788606554e7e01ffca4bb587fe9b287ff3471ecd073561b8a96d06b35dec::breadmask {
    struct BREADMASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREADMASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREADMASK>(arg0, 6, b"BreadMask", b"Dog wif BreadMask", b"Over on Instagram, using hashtags including #breadface, people have been sharing photos of their good boys and girls wearing masks made from slices of bread  as you do.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ufz_HCP_Lpxwp9_Vm_Q_Gk_XRX_4f63nu2vx_MN_Dq_DWMCHGBQ_8tn_7983058d60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREADMASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREADMASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

