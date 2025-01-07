module 0x43c915dd797d6a6481ae1bc742cfd7929948b9439b54e06020f7cd5abf7709ca::ag {
    struct AG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AG>(arg0, 6, b"AG", b"Animale Gummies", b"Avec Animale Gummies il est devenu vraiment PUISSANT. Il n'y a plus de flegme ! Aprs avoir pris cette pilule, je n'ai plus de place pour la fatigue au lit. J'ai 38 ans, 20 cm et en train de redcouvrir le sexe !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/daerar_845698dce0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AG>>(v1);
    }

    // decompiled from Move bytecode v6
}

