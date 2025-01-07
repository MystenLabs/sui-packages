module 0x48c496fd5e391c12a12902b03e9597c358095866b93fe4168bc8dd217b139bb3::froggy {
    struct FROGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGY>(arg0, 6, b"FROGGY", b"froggy", b"Froggy is a laid-back and often humorous character known for his relaxed demeanor and occasional antics with his friends. The character gained significant attention online, evolving into the popular meme \"Pepe the frog\" Which has various interpretations", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FROGGY_ICON_1_0dfc0d529f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

