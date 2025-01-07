module 0xb7aeee688d65fa8022370a9dfbd5101d60cf861050869754f76c08bf889dbfbc::unique_12 {
    struct UNIQUE_12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIQUE_12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIQUE_12>(arg0, 9, b"UNIQUE_12", b"OGM", b"It is a special meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc7a9247-317c-41af-ac4a-b7b4e69d989d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIQUE_12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIQUE_12>>(v1);
    }

    // decompiled from Move bytecode v6
}

