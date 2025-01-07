module 0x99e2026f472c6435ea54cd6892aeffdcc2aecd8d68039fa8407733883b5fa528::donksui {
    struct DONKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKSUI>(arg0, 6, b"DonkSui", b"Donkey on Sui", b"Donksui, the blue donkey, was born from a group of tech-savvy Telegram enthusiasts aiming to create a fun and engaging mascot that embodies the platform's essencefast, secure, and user-friendly. Conceived during a late-night brainstorming session, Tonkey quickly became a symbol of community spirit and creativity. Launched as a meme coin on the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/donkey_7ae1f48e56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

