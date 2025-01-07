module 0xb83bbfa4ae13c9c5bbf3934193770560279461453a8a52b66d5e4e546651e835::scape {
    struct SCAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAPE>(arg0, 6, b"SCAPE", b"SolScape", b"SolScape is merging the runescape classic gameplay with SCAPE token on Solana.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2024_10_14_a_I_s_00_08_53_c63f93c72d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

