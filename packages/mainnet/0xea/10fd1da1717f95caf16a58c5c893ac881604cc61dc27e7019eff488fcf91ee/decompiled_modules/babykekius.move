module 0xea10fd1da1717f95caf16a58c5c893ac881604cc61dc27e7019eff488fcf91ee::babykekius {
    struct BABYKEKIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYKEKIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYKEKIUS>(arg0, 6, b"BabyKekius", b"Baby Kekius Maximus", b"Baby Kekius Maximus ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y8rw_W3w_He_Cnqi_Tuhh_KV_Apb_ZLF_Tbnc_Pg_U6r_H8_S9711a_Ht_d918557c23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYKEKIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYKEKIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

