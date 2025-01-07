module 0xf7d73aa1d654f99b65433fc458eb83ccdc3a798133682002a48d09a441b5c91f::genkii {
    struct GENKII has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENKII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENKII>(arg0, 6, b"GENKII", b"GENKI", x"42726f74686572206f6620504f43484954410a47454e4b49206d65616e7320676f6f64206865616c74682e2057652061696d20746f2073707265616420676f6f64206865616c74682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sni_I_mek_obrazovky_2024_10_03_v_A_11_47_22_fe6772332e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENKII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENKII>>(v1);
    }

    // decompiled from Move bytecode v6
}

