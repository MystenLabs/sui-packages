module 0xb7dbd18a0273819786189c0db4d5e8779c72e99d6edfa557d3068757a3f7b1e4::mariosui {
    struct MARIOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIOSUI>(arg0, 6, b"Mariosui", b"marioonsui", b"$marioonsui, the new meme coin that will have you jumping for joy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2024_10_16_a_I_s_16_08_39_79ceafc8fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

