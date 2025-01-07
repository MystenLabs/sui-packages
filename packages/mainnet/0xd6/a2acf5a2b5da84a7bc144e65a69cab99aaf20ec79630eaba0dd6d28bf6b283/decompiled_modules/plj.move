module 0xd6a2acf5a2b5da84a7bc144e65a69cab99aaf20ec79630eaba0dd6d28bf6b283::plj {
    struct PLJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLJ>(arg0, 6, b"PLJ", b"PixelJackson", b"PixelJakson  um token digital exclusivo inspirado na lenda da musica pop Michael Jackson. Este token apresenta uma arte em estilo pixel art, com uma representao em 32 bits do ucnico Michael Jackson. Cada detalhe foi cuidadosamente projetado para capturar sua essencia e estilo unicos, trazendo  vida suas caractersticas mais marcantes em um visual retro. PixelJakson  uma homenagem ao Rei do Pop, combinando nostalgia e tecnologia em uma nica peca de arte digital..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_08_at_16_33_44_cdd30239e3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

