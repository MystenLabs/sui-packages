module 0x2ad3be4af5956c547a4af9eff040d3898f2186e2b1694b054ef9eb32b0ac0376::snek {
    struct SNEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEK>(arg0, 6, b"SNEK", b"BLUE SNEK SUI", b"SUI SNEK, the snake version of the iconic Pepe the Frog, slithered into the meme universe with a unique charm and mischievous spirit. SUI SNEK aims to unite fans of internet culture, memes, and humor in a community where laughter and creativity flow freely. By embodying the playful essence of Pepe, SUI SNEK has become a symbol of adaptability and wit, seamlessly transitioning from land to water, and now into the digital realm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3902_60f836718d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

