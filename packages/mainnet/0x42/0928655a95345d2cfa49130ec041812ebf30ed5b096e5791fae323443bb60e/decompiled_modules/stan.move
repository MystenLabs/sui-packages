module 0x420928655a95345d2cfa49130ec041812ebf30ed5b096e5791fae323443bb60e::stan {
    struct STAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAN>(arg0, 6, b"STAN", b"STAN ON SUI", x"49205553454420544f204245204120544f502d5449455220434941204147454e542c20534156494e472054484520434f554e5452592c200a4c4956494e472054484520414d45524943414e20445245414d2e2e2e200a0a414e44204e4f573f20494d2041204d454d4520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Es_MJ_78u_Xg6_Aj4r_B_Kg_HN_5_L9_Xcxah4_F_Ny_Gjr3u_L_Qb3pump_9ae8b1c908.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

