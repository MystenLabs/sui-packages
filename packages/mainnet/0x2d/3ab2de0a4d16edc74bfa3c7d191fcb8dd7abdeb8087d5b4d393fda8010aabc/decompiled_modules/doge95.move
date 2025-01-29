module 0x2d3ab2de0a4d16edc74bfa3c7d191fcb8dd7abdeb8087d5b4d393fda8010aabc::doge95 {
    struct DOGE95 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE95, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE95>(arg0, 6, b"Doge95", b"WINDOGE95", b"Windoge95 is the latest addition to the Windoge family on the SUI proudly following in the footsteps of Windoge98 and Windogexp. Inspired by the iconic Windows 95 era and infused with the playful spirit of the Doge meme Windoge95 aims to bring a wave of 90s nostalgia to the cutting-edge world of Web3.By blending vintage aesthetics meme culture and powerful decentralized technology Windoge95 delivers a truly retro-futuristic experience to its holders. Whether youre a collector of meme tokens a blockchain enthusiast or simply a lover of all things nostalgic Windoge95 provides a fun and dynamic way to celebrate the pastwhile building toward the future of the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000041953_fee2db7602.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE95>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE95>>(v1);
    }

    // decompiled from Move bytecode v6
}

