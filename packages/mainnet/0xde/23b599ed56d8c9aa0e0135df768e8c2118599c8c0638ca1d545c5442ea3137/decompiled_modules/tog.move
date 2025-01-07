module 0xde23b599ed56d8c9aa0e0135df768e8c2118599c8c0638ca1d545c5442ea3137::tog {
    struct TOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOG>(arg0, 6, b"Tog", b"Tog the frog", x"546f67207468652074696e792066726f670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_USBJJC_89xh_Fp_Ryco44_Y_Py_H_Zn5_C_Sojtn_Te_U_Fdkr_Y6o_V2_X_a3989c1ca8.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

