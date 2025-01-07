module 0xb436aa10ac895ef3d9cf13d1855aae5216513a5bc214ccc72ff87a1d4c5dcfd7::swassi {
    struct SWASSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWASSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWASSI>(arg0, 6, b"SWASSI", b"SUIWASSI", x"496d206120245357415353492069776f21210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_70_1f34cf8164.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWASSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWASSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

