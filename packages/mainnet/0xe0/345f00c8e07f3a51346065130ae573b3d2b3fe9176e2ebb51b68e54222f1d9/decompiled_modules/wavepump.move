module 0xe0345f00c8e07f3a51346065130ae573b3d2b3fe9176e2ebb51b68e54222f1d9::wavepump {
    struct WAVEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEPUMP>(arg0, 9, b"WAVEPUMP", b"Wave ", b"Wave is the best project ever for everything ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66abe0ad-5177-41d7-8668-78bd84c014eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

