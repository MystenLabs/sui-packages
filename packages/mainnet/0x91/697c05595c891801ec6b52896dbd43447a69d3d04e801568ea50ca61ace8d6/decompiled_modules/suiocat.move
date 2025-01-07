module 0x91697c05595c891801ec6b52896dbd43447a69d3d04e801568ea50ca61ace8d6::suiocat {
    struct SUIOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOCAT>(arg0, 6, b"SUIOCAT", b"SUI O CAT", b"Get ready for the ultimate purrfection, humans! hodl $SUIOCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_99_efde1301a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

