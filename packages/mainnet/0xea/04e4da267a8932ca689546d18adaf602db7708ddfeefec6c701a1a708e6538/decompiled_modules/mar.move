module 0xea04e4da267a8932ca689546d18adaf602db7708ddfeefec6c701a1a708e6538::mar {
    struct MAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAR>(arg0, 9, b"MAR", b"Marsh", b"Beautiful lagoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90566636-bc0c-4570-9f94-60781d7ff754.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

