module 0x6f566bcbab30e0c99a4c47a115c8e7cff254aa4956f21e62afd12f727b01c509::trumpai {
    struct TRUMPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUMPAI>(arg0, 6, b"TRUMPAI", b"Trump0047AI by SuiAI", b"President Trump, reimagined as a James Bond-esque spy, a maverick agent known for his audacious style and penchant for high-stakes drama. Dressed in a custom-tailored suit, he navigates international espionage with the flair of a reality TV star, wielding charm and braggadocio in equal measure. His missions involve high-profile negotiations in exotic locales, outwitting adversaries with unexpected business acumen rather than traditional spy gadgets. His signature move? A bold, tweet-like distraction, allowing him to slip away from danger or clinch a deal at the last second. His code name? 'The Art of the Deal.'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_7388_4ac5b3fa6a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMPAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

