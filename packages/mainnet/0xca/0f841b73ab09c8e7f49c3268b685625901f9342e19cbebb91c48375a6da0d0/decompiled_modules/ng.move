module 0xca0f841b73ab09c8e7f49c3268b685625901f9342e19cbebb91c48375a6da0d0::ng {
    struct NG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NG>(arg0, 9, b"NG", b"Ngozi", b"My personal coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/448628b2-0fb7-48de-b4c0-1a53c1f1182e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NG>>(v1);
    }

    // decompiled from Move bytecode v6
}

