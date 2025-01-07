module 0x105dce4c1acb60b254d8397b2152bf53a97c6faba3554fe560a4d0116c363610::suilisa {
    struct SUILISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILISA>(arg0, 6, b"SUILISA", b"SUINALISA", b"ART SUINALISA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_14_A_s_00_21_42_c63b8d96_50cbeca5d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILISA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILISA>>(v1);
    }

    // decompiled from Move bytecode v6
}

