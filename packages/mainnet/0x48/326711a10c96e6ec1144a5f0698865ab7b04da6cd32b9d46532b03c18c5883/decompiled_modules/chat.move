module 0x48326711a10c96e6ec1144a5f0698865ab7b04da6cd32b9d46532b03c18c5883::chat {
    struct CHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAT>(arg0, 6, b"CHAT", b"SUI CHAT", b"SUI CHAT is a token launched on the Sui network with real-world uses. It's not just for show, it's got utility!  Whether you're chatting or trading, this token has got your back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_1_bbf0a3f346.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

