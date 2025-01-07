module 0x107b9527d80961213ba5a572c20559fce7c7e23cea2d027f44a92498e0363f37::fhippo {
    struct FHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHIPPO>(arg0, 6, b"FHIPPO", b"Flip The Hippo", x"54686520486970706f20697320666c6970200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P24_GW_Ff_Q8_L7nw4hj_Hkm2iv_D_Kx_APM_Xh4v1wknxy7_W45z6_c6a315186c.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

