module 0xb8fc493380145ced17f6b1aac345b1213e05b5694c925b6c44455d5002629132::krabs {
    struct KRABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRABS>(arg0, 6, b"KRABS", b"Mr Krabs", x"496d206a7573742061206d6973657261626c6520637261622074686174206973206f627365737365642077697468206d6f6e65790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X_Mb5w_Gx_UYY_8s_V_Ceom_Tgxp_K_Eac_G_Ak_Hr_X_Sz_Ty_Ajdw_Gr_Nf6_62c04351e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRABS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

