module 0x9bbbafc38d93acca23b89f5adece0a5fe6c5d4a26f70da595472811b86bdd3a7::plon {
    struct PLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLON>(arg0, 6, b"Plon", b"PepElon", b"Website | Twitter | Telegram coming soon! In a World Where Memes and Innovation Collide PepElon was born, not just as another meme coin, but as a revolutionary symbol of the internet's chaotic brilliance. Combining the genius of tech billionaire Musk with the timeless humor of Pepe the Frog, PepElon represents the fusion of visionary technology and meme culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pep_Elon_cb3567664e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLON>>(v1);
    }

    // decompiled from Move bytecode v6
}

