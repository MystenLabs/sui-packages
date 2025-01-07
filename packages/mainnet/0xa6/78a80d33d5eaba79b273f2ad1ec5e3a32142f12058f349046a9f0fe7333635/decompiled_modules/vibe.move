module 0xa678a80d33d5eaba79b273f2ad1ec5e3a32142f12058f349046a9f0fe7333635::vibe {
    struct VIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIBE>(arg0, 6, b"VIBE", b"Vibe Cat", x"43616e27742073746f7020766962696e672c20776f6e27742073746f7020766962696e672e20556c74696d61746520766962696e67206361742e20466f726576657220766962657320696e20796f75722077616c6c65742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbej_Uh9j_P_Bi_H_Kx9_Erfuodx_Nfxmdg5s_Cej_Pn_Go_JGWJB_Wyu_f682720526.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

