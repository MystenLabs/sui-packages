module 0xbc5b217e0469925591211bc35c75f5475a72bbc7d4514274a18ce66e00360968::salmoon {
    struct SALMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALMOON>(arg0, 6, b"SALMOON", b"SALMOON ON SUI", b"Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_03_at_00_58_04_salmon_meme_Recherche_Google_40c809ea6d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

