module 0xbc1a3bbed886e9d32801ad78bd3dd7bd88de806a133d7d29e373668c3d4af034::maz {
    struct MAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAZ>(arg0, 9, b"MAZ", b"Mazoname", b"Meme 2024 to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90463dcc-69b5-4f49-bc3e-c759c905e44e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

