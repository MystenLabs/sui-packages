module 0x5dab4c53607650e69d859fe3c4988ac3021e23abbb9b0bbb575d5adc726d06b8::pigofsui {
    struct PIGOFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGOFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGOFSUI>(arg0, 6, b"PIGOFSUI", b"SUINK SUI", b"OINC OINC OINC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_165853616_29aea7400b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGOFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGOFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

