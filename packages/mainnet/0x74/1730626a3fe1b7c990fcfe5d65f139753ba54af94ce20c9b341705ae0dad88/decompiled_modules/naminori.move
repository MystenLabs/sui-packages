module 0x741730626a3fe1b7c990fcfe5d65f139753ba54af94ce20c9b341705ae0dad88::naminori {
    struct NAMINORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMINORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMINORI>(arg0, 9, b"NAMINORI", b"WAVER", b"TUNAMI IN JAPAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c0a649f-3835-4967-bbc1-4af5857dfeb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMINORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAMINORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

