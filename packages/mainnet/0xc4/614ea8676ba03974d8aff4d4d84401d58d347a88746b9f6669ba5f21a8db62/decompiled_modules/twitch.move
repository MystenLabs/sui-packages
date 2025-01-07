module 0xc4614ea8676ba03974d8aff4d4d84401d58d347a88746b9f6669ba5f21a8db62::twitch {
    struct TWITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWITCH>(arg0, 6, b"TWITCH", b"Twitch", b"Twitch has become a major platform for gamers and content creators, attracting millions of users worldwide. Its features include live streaming, a chat system, emotes (custom emojis), and support for subscriber-based channels, where fans can pay to support their favorite streamers and receive exclusive perks. Streamers can monetize their content through subscriptions, ads, and donations, making it an attractive space for professional and aspiring streamers alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Twitch_fab21728a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

