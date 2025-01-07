module 0x6f84a51675614b6d407f319bc73c079902746af4be02166980343e17b01d3ef4::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 9, b"LOVE", b"Sos", b"Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29e0d8a1-1280-45e7-a1da-86529fb7ca4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

