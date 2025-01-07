module 0xb3849d48024ac065dd4c54b60f4ee2bf653a93574c1cc0d484b8c7649c7bfc37::satowater {
    struct SATOWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOWATER>(arg0, 6, b"Satowater", b"Peter Todds Bottle of Water", x"506574657220546f64647320426f74746c65206f6620576174657220287469636b65723a205361746f7761746572290a4675636b2074686520706574732c206c6574732073656e64205361746f7368697320626f74746c65206f6620776174657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Smbjz734_K1zr_DMT_9_Krn_J_Gvv6q_F2w_Wr_HVYN_7uh9r_C_Vo1_39546e1d9e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

