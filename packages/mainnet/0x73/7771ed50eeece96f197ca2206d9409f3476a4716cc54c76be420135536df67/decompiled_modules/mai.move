module 0x737771ed50eeece96f197ca2206d9409f3476a4716cc54c76be420135536df67::mai {
    struct MAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAI>(arg0, 6, b"MAI", b"WeareMAI", b"Revolutionizing memetic generation through the power of AI learning", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_N_Rab31_Gj_YZXVJU_2pn_Ld_EYZT_Nh_N_Ewii_Vp_UA_Vue_Vi_H_Hhtn_add548b446.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

