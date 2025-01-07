module 0x66285d7f85fcf97a1912eecc22aec94e2123dc59372424f377f3593b7ed68ec1::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 9, b"AI", b"AI agent", b"New AI generation ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b70d850-4d93-4a14-b6d0-d73a07cc4189.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

