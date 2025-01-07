module 0xdf60c0f592b967e264e6dab462226d7d34a460ab87e0ed397faa843342eb8d5f::ag {
    struct AG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AG>(arg0, 6, b"AG", b"Animale Gummies", b"Avec Animale Gummies il est devenu vraiment PUISSANT. Il n'y a plus de flegme ! Aprs avoir pris cette pilule, je n'ai plus de place pour la fatigue au lit. J'ai 38 ans, 20 cm et en train de redcouvrir le sexe !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/adzta_af3e8dcfcc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AG>>(v1);
    }

    // decompiled from Move bytecode v6
}

