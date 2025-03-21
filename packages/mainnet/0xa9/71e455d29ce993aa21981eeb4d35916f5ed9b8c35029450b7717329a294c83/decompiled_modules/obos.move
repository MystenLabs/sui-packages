module 0xa971e455d29ce993aa21981eeb4d35916f5ed9b8c35029450b7717329a294c83::obos {
    struct OBOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBOS>(arg0, 9, b"OBOS", b"SOBO", b"Its create for a fun purpose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a89a10ed-f1ee-4d04-b4ef-92512fee19f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

