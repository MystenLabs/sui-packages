module 0xc0964442f38eec45c463b3927ec4fe14bbed6a831ffc4efd15c4a823ad71c005::MOODENG {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 9, b"MOODENG", b"Bouncy Pork", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CoUxXvFyK8GEaTSfgTQn8ktiRCyXz33bmuk24Affcvzk.png?size=xl&key=7012fb")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOODENG>>(0x2::coin::mint<MOODENG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOODENG>>(v2);
    }

    // decompiled from Move bytecode v6
}

