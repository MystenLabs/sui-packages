module 0x2cdf6d61c10366fe68fc71f8f8183c3b6e5495b54721b25bb428211a50f2a9a1::deathai {
    struct DEATHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEATHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEATHAI>(arg0, 6, b"DeathAI", b"DEATH PixelVerse AI", b"Embark on a pixelated MMO adventure, where dark hooded figures with glowing red eyes wield their scythes against the shadows. Join forces with other players in a world of evolving quests, fierce battles, and limitless earning potential in this grim yet vibrant universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DEATH_e9225268a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEATHAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEATHAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

