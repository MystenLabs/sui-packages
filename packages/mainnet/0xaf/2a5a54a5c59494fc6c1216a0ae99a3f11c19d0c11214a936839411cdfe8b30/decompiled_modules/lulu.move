module 0xaf2a5a54a5c59494fc6c1216a0ae99a3f11c19d0c11214a936839411cdfe8b30::lulu {
    struct LULU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LULU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LULU>(arg0, 6, b"LULU", b"Lulu the Cat", x"4c554c553a2041206272617665206b697474656e207075727375696e672074686520647265616d206f662064656c6963696f757320666f6f6420616e642066726565646f6d21200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_Ummd9_N_Jd743_Tu9_E_Hn729bu_S_Fpz_Rc_Fi_Kve_C5f9_U28_N_Hd_b6ef284db3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LULU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LULU>>(v1);
    }

    // decompiled from Move bytecode v6
}

