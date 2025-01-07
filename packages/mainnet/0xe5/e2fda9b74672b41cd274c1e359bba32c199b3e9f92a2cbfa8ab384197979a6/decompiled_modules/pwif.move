module 0xe5e2fda9b74672b41cd274c1e359bba32c199b3e9f92a2cbfa8ab384197979a6::pwif {
    struct PWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWIF>(arg0, 6, b"PWIF", b"Penguin Wif Hat", b"This cute an adorable penguin has a hat . And the hat stays on !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmax_Ht_Gs_MZ_8_Annn_U3k_R_Mzvqe_F_Xit_B6f_Ay_F_Bb_Jdod_XNP_Fs9_3cc41489b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

