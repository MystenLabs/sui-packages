module 0x27fe4865f4703f1d669ee23353ea5119b99790799b697bdfc799d187974f1093::chillpepe {
    struct CHILLPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLPEPE>(arg0, 6, b"CHILLPEPE", b"Just a Chill Pepe", b"Just a Chill Pepe was born from the idea that crypto should be fun and stress-free. Inspired by the internet's favorite meme, Pepe the Frog, but with a twistour Pepe is always seen with a laid-back vibe, maybe with a surfboard or a hammock, embodying ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048734_dc84e0d90b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

