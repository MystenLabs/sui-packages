module 0xf0f2589f3cace09696025c51d6b0aa7e134e1fef2dc8b35588b23064470dfa8b::s9_ {
    struct S9_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: S9_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S9_>(arg0, 9, b"S9_", b"misi", b"Help to be strong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02fd84b1-b164-4f3c-99cb-15f084e9850e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S9_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S9_>>(v1);
    }

    // decompiled from Move bytecode v6
}

