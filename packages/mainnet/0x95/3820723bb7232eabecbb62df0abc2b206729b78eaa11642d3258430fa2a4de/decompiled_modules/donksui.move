module 0x953820723bb7232eabecbb62df0abc2b206729b78eaa11642d3258430fa2a4de::donksui {
    struct DONKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKSUI>(arg0, 6, b"DonkSui", b"Sui$Donk", b"Donksui, the blue donkey, was born from a group of tech-savvy Telegram enthusiasts aiming to create a fun and engaging mascot that embodies the platform's essencefast, secure, and user-friendly. Conceived during a late-night brainstorming session, Tonkey quickly became a symbol of community spirit and creativity. Launched as a meme coin on the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/donkey_cba469fc08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

