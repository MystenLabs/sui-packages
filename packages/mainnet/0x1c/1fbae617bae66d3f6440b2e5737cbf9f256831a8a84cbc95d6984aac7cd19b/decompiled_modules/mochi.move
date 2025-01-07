module 0x1c1fbae617bae66d3f6440b2e5737cbf9f256831a8a84cbc95d6984aac7cd19b::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"MOCHI", b"MOCHI SUI", b"MOCHI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3bx_V_Js_Sk_WHRZ_4_Ue_Ag7_N5_Y_Yxz8_Z5_Ahpnr_Qj9_Fe3wgpump_c10ae49815.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

