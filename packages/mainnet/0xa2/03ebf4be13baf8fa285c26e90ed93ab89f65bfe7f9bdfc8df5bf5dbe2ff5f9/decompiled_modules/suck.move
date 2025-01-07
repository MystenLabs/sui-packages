module 0xa203ebf4be13baf8fa285c26e90ed93ab89f65bfe7f9bdfc8df5bf5dbe2ff5f9::suck {
    struct SUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCK>(arg0, 6, b"SUCK", b"SUI DUCK", b"Sui Duck is the OG Duck meme on SUI Network. PNG, animated stickers, and emojis compatible with most social apps, aiming to be the top trending meme icon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/345f2470_c9de_4089_a0c2_034b32dfd56e_60163197bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

