module 0x2f1644455c575da31225b494a699d135977866899abefeed15fe91f1007375a::suira {
    struct SUIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRA>(arg0, 6, b"Suira", b"SUIRA", b"$Suira is on a mission to provide children with smiles all around the world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_66_8f430f4520.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

