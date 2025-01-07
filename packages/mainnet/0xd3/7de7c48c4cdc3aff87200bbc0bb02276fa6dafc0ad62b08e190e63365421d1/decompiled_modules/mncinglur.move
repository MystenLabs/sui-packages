module 0xd37de7c48c4cdc3aff87200bbc0bb02276fa6dafc0ad62b08e190e63365421d1::mncinglur {
    struct MNCINGLUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNCINGLUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNCINGLUR>(arg0, 9, b"MNCINGLUR", b"MANCINGLUR", b"Mancinggassss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cdc80ae3-fe2f-45f5-a22d-e29eb793b6fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNCINGLUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNCINGLUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

