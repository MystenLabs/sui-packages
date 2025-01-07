module 0xd7612a1f9093097d4cf7feea97c54b0cac28b6908a106a557e6f99b18b32cbc5::chat {
    struct CHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAT>(arg0, 6, b"CHAT", b"Chat", b"Suichat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731822062984.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

