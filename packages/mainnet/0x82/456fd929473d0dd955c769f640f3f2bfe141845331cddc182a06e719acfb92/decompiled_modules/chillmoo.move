module 0x82456fd929473d0dd955c769f640f3f2bfe141845331cddc182a06e719acfb92::chillmoo {
    struct CHILLMOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLMOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLMOO>(arg0, 9, b"CHILLMOO", b"CHILL MOO", b"Just a Chill Moodeng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce8b2234-719c-4731-ab88-53d3fb0871d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLMOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLMOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

