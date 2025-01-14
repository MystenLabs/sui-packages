module 0xbb932aa56a225ecfb80536f24d72a4c3498efcf1fbec160cd847f4cade5cfa44::gcity {
    struct GCITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCITY>(arg0, 6, b"Gcity", b"GothamCity on sui", b"Welcome to the common home of the G-city community! Let's explore and experience interesting things together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_ef422732c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

