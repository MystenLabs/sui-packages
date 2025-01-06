module 0x385dd1f0bf23473caef1c3d3b1676df9399dfe415e1e7f9a6599feb86cfbdf8e::durag {
    struct DURAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DURAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DURAG>(arg0, 6, b"DURAG", b"TIKTOK AI DURAGS", x"61692067656e657261746564206368617261637465727320776974682064757261677320766972616c2074696b746f6b206d656d650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P_Gn_Mom1y_R_Ny_WHF_Au_Kjf_Zr3k3_W_Whe8_Sug7_Nuf9_Yf_Q6_Ch_F_cb9cdf5d76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DURAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DURAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

