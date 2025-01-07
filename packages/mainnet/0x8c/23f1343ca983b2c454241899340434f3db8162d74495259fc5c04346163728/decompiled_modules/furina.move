module 0x8c23f1343ca983b2c454241899340434f3db8162d74495259fc5c04346163728::furina {
    struct FURINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURINA>(arg0, 9, b"FURINA", b"Furina Coi", b"Furina best girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5efd7815-07b3-44f2-9fb9-151475d8904e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FURINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

