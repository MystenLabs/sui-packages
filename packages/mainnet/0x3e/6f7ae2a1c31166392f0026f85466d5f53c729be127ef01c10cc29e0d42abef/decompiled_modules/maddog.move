module 0x3e6f7ae2a1c31166392f0026f85466d5f53c729be127ef01c10cc29e0d42abef::maddog {
    struct MADDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADDOG>(arg0, 6, b"MADDOG", b"Mad Dog", b"$MADDOG, the legendary Madman of Perth Western Australia, has been riding his push bike since the '80s all over Perth, evading kangaroos and shocking onlookers. His outrageous antics made him a national icon, leading to lawsuits and social media censorship. Now, hes back, this time on the Sui blockchain, redefining his story once again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_fbcc4cc5b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MADDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

