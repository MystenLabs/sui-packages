module 0x51be855f3e66a2ff55811666fcf74862f911fd5954d126feb83a31fff8b0bfc2::amsh {
    struct AMSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMSH>(arg0, 9, b"AMSH", b"Amsha", b"Symbol for love and Compassion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e0d0ab9-fcfa-42bf-a816-aeb1ce58a9b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

