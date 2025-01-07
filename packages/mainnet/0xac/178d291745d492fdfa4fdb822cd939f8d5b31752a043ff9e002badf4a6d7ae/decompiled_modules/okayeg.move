module 0xac178d291745d492fdfa4fdb822cd939f8d5b31752a043ff9e002badf4a6d7ae::okayeg {
    struct OKAYEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKAYEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKAYEG>(arg0, 6, b"OKAYEG", b"Okayeg On Ethirium", b"the background story of Okayeg (OKAYEG) has strong Internet culture and social media elements, and is derived from the well-known Internet meme Pepe the Frog. Pepe was originally created by Matt Furie in his comic book series Boys Club in 2005, and has since spread quickly across the Internet and evolved into many forms of memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OKAY_9cfcd6fb82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKAYEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OKAYEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

