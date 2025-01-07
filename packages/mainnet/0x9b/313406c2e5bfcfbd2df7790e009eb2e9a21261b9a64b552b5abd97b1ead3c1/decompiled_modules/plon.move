module 0x9b313406c2e5bfcfbd2df7790e009eb2e9a21261b9a64b552b5abd97b1ead3c1::plon {
    struct PLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLON>(arg0, 6, b"Plon", b"PepElon", b"Website/ twitter/ telegram coming soon! In a World Where Memes and Innovation Collide PepElon was born, not just as another meme coin, but as a revolutionary symbol of the internet's chaotic brilliance. Combining the genius of tech billionaire Musk with the timeless humor of Pepe the Frog, PepElon represents the fusion of visionary technology and meme culture. Website/ twitter/ telegram are coming soon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pep_Elon_be9fa114a0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLON>>(v1);
    }

    // decompiled from Move bytecode v6
}

