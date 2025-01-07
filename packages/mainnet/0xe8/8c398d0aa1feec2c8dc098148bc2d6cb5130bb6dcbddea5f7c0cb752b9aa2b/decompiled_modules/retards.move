module 0xe88c398d0aa1feec2c8dc098148bc2d6cb5130bb6dcbddea5f7c0cb752b9aa2b::retards {
    struct RETARDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDS>(arg0, 6, b"RETARDS", b"SUI-TRADER (S-TRADER)", b"SUI RETARDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_E8_O_Ae_N_460s_e1211365e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

