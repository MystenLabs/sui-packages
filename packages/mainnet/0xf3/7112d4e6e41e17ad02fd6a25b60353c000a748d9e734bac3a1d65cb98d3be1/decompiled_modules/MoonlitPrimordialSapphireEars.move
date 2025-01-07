module 0xf37112d4e6e41e17ad02fd6a25b60353c000a748d9e734bac3a1d65cb98d3be1::MoonlitPrimordialSapphireEars {
    struct MOONLITPRIMORDIALSAPPHIREEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONLITPRIMORDIALSAPPHIREEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONLITPRIMORDIALSAPPHIREEARS>(arg0, 0, b"COS", b"Moonlit Primordial Sapphire Ears", b"Graced with light from distant lands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Moonlit_Primordial_Sapphire_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONLITPRIMORDIALSAPPHIREEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONLITPRIMORDIALSAPPHIREEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

