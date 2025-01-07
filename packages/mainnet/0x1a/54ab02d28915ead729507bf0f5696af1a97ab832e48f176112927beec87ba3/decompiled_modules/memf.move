module 0x1a54ab02d28915ead729507bf0f5696af1a97ab832e48f176112927beec87ba3::memf {
    struct MEMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMF>(arg0, 9, b"MEMF", b"Memefire", b"Meme token on wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf5a0f27-b15b-42af-a182-1a92861b56d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

