module 0x90a443b346918d8d7bfcf3f1b331b78de655d347f7be5deea2ca832385c28644::samoyonsui {
    struct SAMOYONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMOYONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMOYONSUI>(arg0, 6, b"Samoyonsui", b"Samoyed Sui", b"SamoyedSui (SAMO)-  Inspired by the Samoyed dog breed, SAMO is one of Sui's most popular meme tokens. It's designed as a community-driven token with a playful branding similar to Dogecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/samoy_10b453d547.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMOYONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMOYONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

