module 0x4e6444bf0bb475f9fb578fd48e240302e509ad130cbeff713dbdb9e6c4ba157::norawif {
    struct NORAWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORAWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORAWIF>(arg0, 6, b"NORAWIF", b"NoraWifHat", b"Cutest Nora with Hat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_g_A_r_A_nt_A_s_A_2024_09_14_185209_7a36e64c07.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORAWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORAWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

