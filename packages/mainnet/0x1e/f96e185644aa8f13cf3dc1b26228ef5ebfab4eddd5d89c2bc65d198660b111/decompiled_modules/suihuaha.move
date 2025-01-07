module 0x1ef96e185644aa8f13cf3dc1b26228ef5ebfab4eddd5d89c2bc65d198660b111::suihuaha {
    struct SUIHUAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHUAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHUAHA>(arg0, 6, b"SUIHUAHA", b"SUIBY-DOO", b"Suiby, the delightful gem in the meme coin universe on the SUI blockchain. Suiby adds a cheerful spin with its Scooby-Doo!-inspired flair. Discover the whimsical world of SUIBY, where crypto dances with humor, and embark on the journey to the next big meme coin phenomenon on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suihuaha_bd884f0700.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHUAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHUAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

