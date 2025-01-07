module 0x8f6151f8b3ef1711b05712729b4447d0b01e161750e3da123a09ca6c91aa4d0f::jkr {
    struct JKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKR>(arg0, 9, b"JKR", b"Joker ", b"We love joker ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99ed92ab-9148-49ce-a1e5-7ce817f069f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

