module 0x880c281a5b2b64a2f4bb216d661dc4fbff45721b34fd632abf260be572d0e24c::suiduck {
    struct SUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUCK>(arg0, 6, b"SUIDUCK", b"SUI DUCK", b"Sui Duck is the OG Duck meme on SUI Network. PNG, animated stickers, and emojis compatible with most social apps, aiming to be the top trending meme icon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_duck_logo_5b12fb5a86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

