module 0x61f920bdef3b0aac28ea8dc99e532a6646dd4b69c7198960e40d5f03128a79f0::salmoon {
    struct SALMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALMOON>(arg0, 6, b"SALMOON", b"SALMOON ON SUI", b"The Salmon on SUI taking us to the mooon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_03_at_00_58_04_salmon_meme_Recherche_Google_797e7fb36f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

