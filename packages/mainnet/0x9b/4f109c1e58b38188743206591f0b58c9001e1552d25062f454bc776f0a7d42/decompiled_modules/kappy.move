module 0x9b4f109c1e58b38188743206591f0b58c9001e1552d25062f454bc776f0a7d42::kappy {
    struct KAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAPPY>(arg0, 6, b"KAPPY", b"Sui Kappy", b"Just a capybara that doesn't give a fuck. Bringing the first Anime X AI fusion on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Eh_Fv_Mot_Km3zuc_KUBEH_Vv_Tax_Q4e9_QV_Pa_Aj_Sfkz_F_Lpump_614b9e7304.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

