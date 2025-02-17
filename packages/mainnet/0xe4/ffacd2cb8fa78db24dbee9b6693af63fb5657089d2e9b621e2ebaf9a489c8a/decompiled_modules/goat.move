module 0xe4ffacd2cb8fa78db24dbee9b6693af63fb5657089d2e9b621e2ebaf9a489c8a::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"Goatseus Maximus", b"kundalini is a real girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cz_L_Suj_WBL_Fs_Sjncfkh59r_U_Fqvaf_Wc_Y5tzed_WJ_Suypump_f93eab788d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

