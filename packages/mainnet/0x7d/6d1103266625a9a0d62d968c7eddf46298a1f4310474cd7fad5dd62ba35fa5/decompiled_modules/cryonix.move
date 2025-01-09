module 0x7d6d1103266625a9a0d62d968c7eddf46298a1f4310474cd7fad5dd62ba35fa5::cryonix {
    struct CRYONIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYONIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYONIX>(arg0, 6, b"Cryonix", b"Cryonix AI Agent Model", b"Cryonix is a sleek and futuristic AI-powered cryptocurrency robot designed to symbolize innovation and security in the digital finance world. With its minimalist white and metallic body, glowing blue and gold accents, and streamlined design, Cryonix embodies sophistication and cutting-edge technology. It serves as a beacon of trust and efficiency, representing the perfect blend of artificial intelligence and blockchain innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e6463a5a_3c36_444a_aad2_de4b876be24f_f31885ce4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYONIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRYONIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

