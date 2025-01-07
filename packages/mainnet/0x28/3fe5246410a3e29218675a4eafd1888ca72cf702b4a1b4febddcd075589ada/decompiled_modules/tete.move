module 0x283fe5246410a3e29218675a4eafd1888ca72cf702b4a1b4febddcd075589ada::tete {
    struct TETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETE>(arg0, 6, b"TETE", b"Sui Tete", b"Tete is set to dominate the waters of Sui!  With confidence and skill, Tete is ready to ride the waves and make a splash. Get ready, SuiTete is taking over the ocean! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_86_ae21fe1470.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TETE>>(v1);
    }

    // decompiled from Move bytecode v6
}

