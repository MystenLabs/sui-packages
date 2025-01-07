module 0xa9b45ffdd2da78152d4006d41cf75334f3c44a3473aaed89070462d085d6507f::ajakan {
    struct AJAKAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AJAKAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AJAKAN>(arg0, 9, b"AJAKAN", b"Jwwkja", b"Ajajs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74131f6f-1e6c-40c9-a436-69037628dfc2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AJAKAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AJAKAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

