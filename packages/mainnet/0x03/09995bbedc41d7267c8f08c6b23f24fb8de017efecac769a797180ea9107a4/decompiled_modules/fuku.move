module 0x309995bbedc41d7267c8f08c6b23f24fb8de017efecac769a797180ea9107a4::fuku {
    struct FUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUKU>(arg0, 6, b"Fuku", b"FUKUONSUI", b"KabosuMama, the beloved owner of Kabosu the Shiba Inu. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2h_J7_Ms6_400x400_2966199e02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

