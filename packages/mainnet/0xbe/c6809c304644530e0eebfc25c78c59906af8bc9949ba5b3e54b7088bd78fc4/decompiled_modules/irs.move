module 0xbec6809c304644530e0eebfc25c78c59906af8bc9949ba5b3e54b7088bd78fc4::irs {
    struct IRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRS>(arg0, 6, b"IRS", b"Iridescent Rabbit Shark", b"$IRS - iridescent rabbit shark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_PQ_7_QYV_8_Cua_Z_Tjyn_W_Tj_Nama_E3_E_Zo6_Gs_N_Fes_W_Nor_BZM_4m_c5dfe1530e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

