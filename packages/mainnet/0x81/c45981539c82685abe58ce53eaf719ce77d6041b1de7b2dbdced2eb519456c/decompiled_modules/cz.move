module 0x81c45981539c82685abe58ce53eaf719ce77d6041b1de7b2dbdced2eb519456c::cz {
    struct CZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZ>(arg0, 9, b"CZ", b"BINANCE CZ", b"Nothing. Have no purpose / Nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/55eb9c8e-f0bb-4e7a-8156-fc00dcb7a87f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

