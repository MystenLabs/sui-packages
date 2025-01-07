module 0x1bb260cabb36610c1a98284b0a0768c905ff6ee7d6e42ff0d3326578962753b1::leafm {
    struct LEAFM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEAFM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEAFM>(arg0, 6, b"LEAFM", b"Leafmoth", x"57656c636f6d6520746f20244c4541464d3a20546865206865617679776569676874206368616d70206f66206d656d6520746f6b656e7321202054686973204c65616679204d616d6d6f7468206973206865726520746f2068656c7020796f75206561726e20616e6420636172727920736572696f7573206761696e732e2057686574686572206974732070726f666974732c206d656d65732c206f72206a7573742074686520726964652c2074686973206d616d6d6f74687320737472656e6774682077696c6c2074616b65207573206661722e204a6f696e20746865206865726420616e642067726f7720776974682075732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R5ks_BKKE_5_ZG_Pm_Ur2v_Lofz_Bhs_BC_4_Hr_RXBHHFN_4_Ef_AV_Ym_F_5ef5820889.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEAFM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEAFM>>(v1);
    }

    // decompiled from Move bytecode v6
}

