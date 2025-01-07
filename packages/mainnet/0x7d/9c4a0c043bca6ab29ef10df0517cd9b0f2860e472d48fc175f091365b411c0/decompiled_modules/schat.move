module 0x7d9c4a0c043bca6ab29ef10df0517cd9b0f2860e472d48fc175f091365b411c0::schat {
    struct SCHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHAT>(arg0, 6, b"SCHAT", b"SUI CHAT", b"SUI CHAT is a token launched on the Sui network with real-world uses. It's not just for show, it's got utility!  Whether you're chatting or trading, this token has got your back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_1_6e16ef7028.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

