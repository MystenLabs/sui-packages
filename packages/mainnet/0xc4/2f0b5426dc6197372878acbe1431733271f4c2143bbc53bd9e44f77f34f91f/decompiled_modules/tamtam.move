module 0xc42f0b5426dc6197372878acbe1431733271f4c2143bbc53bd9e44f77f34f91f::tamtam {
    struct TAMTAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMTAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMTAM>(arg0, 6, b"TAMTAM", b"Tam Tam", b"The famous pygmy hippo from Osaka zoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yk_RWE_2_K_Msa6t_EP_Hr4gq_Vs_An_Z4_Xnh_B2qp_ZWVEG_3_Syw_S_Ps_ed70629ac2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMTAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAMTAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

