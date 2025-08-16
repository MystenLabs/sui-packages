module 0x83c7efb6ace2105ee313d1e4c15cf5e003ab5f59cbcc9355c5ef1575b4b113dd::astro {
    struct ASTRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTRO>(arg0, 9, b"ASTRO", b"AstroAi", b"AstroAI is a successful experiment of AI technologies. Join our community to talk with Astro about games and more! Press X to continue.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASTRO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTRO>>(v2, @0x3538fe7e59189b88a3aa50a2ebc65de07f0571da30e6ea44cccb4030356e5d90);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASTRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

