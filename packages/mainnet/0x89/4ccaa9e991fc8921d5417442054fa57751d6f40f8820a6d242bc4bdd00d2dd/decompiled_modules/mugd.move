module 0x894ccaa9e991fc8921d5417442054fa57751d6f40f8820a6d242bc4bdd00d2dd::mugd {
    struct MUGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUGD>(arg0, 6, b"MUGD", b"MEMES UNDERGROUND", b"MEMES UNDERGROUND ARRIVED AT MOVEPUMP NOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_190712416_f1055d181e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

