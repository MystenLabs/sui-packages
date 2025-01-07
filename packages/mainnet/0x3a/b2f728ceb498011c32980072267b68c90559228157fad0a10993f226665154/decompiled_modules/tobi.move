module 0x3ab2f728ceb498011c32980072267b68c90559228157fad0a10993f226665154::tobi {
    struct TOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBI>(arg0, 9, b"TOBI", b"Obito", b"A Broken Hero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1fc25534-d39e-4f72-9a58-6745173735c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

