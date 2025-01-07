module 0x7893ef350460ee7ef6e0e05783d97b7ac03b4e44dfb5eacd964a33634ef06b7c::nelly {
    struct NELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NELLY>(arg0, 6, b"NELLY", b"Turtle Nelly", b"coolest caretta caretta in sui universe..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_g_A_r_A_nt_A_s_A_2024_09_15_020126_ac22689b28.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

