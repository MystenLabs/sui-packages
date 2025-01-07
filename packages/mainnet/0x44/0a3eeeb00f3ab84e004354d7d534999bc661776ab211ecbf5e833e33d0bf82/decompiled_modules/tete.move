module 0x440a3eeeb00f3ab84e004354d7d534999bc661776ab211ecbf5e833e33d0bf82::tete {
    struct TETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETE>(arg0, 6, b"TETE", b"Sui Tete", b"Tete is set to dominate the waters of Sui!  With confidence and skill, Tete is ready to ride the waves and make a splash. Get ready, SuiTete is taking over the ocean! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_min_8751a94b7c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TETE>>(v1);
    }

    // decompiled from Move bytecode v6
}

