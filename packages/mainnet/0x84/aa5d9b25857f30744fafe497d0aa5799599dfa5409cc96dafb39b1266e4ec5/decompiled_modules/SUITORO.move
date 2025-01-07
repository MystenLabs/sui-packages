module 0x84aa5d9b25857f30744fafe497d0aa5799599dfa5409cc96dafb39b1266e4ec5::SUITORO {
    struct SUITORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITORO>(arg0, 9, b"Suitoro", b"Suitoro Bull", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FSuitoro_twitter_profile_a1460d11c2.png&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITORO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITORO>>(0x2::coin::mint<SUITORO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUITORO>>(v2);
    }

    // decompiled from Move bytecode v6
}

