module 0x6b2ad481aa7af82ad4aa32abeb8c673c805a8f6915094aa0dcc74a2a1e60c783::Kick_Em {
    struct KICK_EM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KICK_EM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KICK_EM>(arg0, 9, b"KICK", b"Kick Em", b"kick em when they're down. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzSyzmoWMAEcdlX?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KICK_EM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KICK_EM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

