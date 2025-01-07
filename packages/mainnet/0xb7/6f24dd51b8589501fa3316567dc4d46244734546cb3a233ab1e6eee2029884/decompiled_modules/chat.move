module 0xb76f24dd51b8589501fa3316567dc4d46244734546cb3a233ab1e6eee2029884::chat {
    struct CHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAT>(arg0, 6, b"CHAT", b"SUI CHAT", b"SUI CHAT is a token launched on the Sui network with real-world uses. It's not just for show, it's got utility!  Whether you're chatting or trading, this token has got your back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_1_62057c53d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

