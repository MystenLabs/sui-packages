module 0x2348ee9266fa2a0af742d003fdaabe8cad92366a8b822798ff13036b9a34050::yo {
    struct YO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YO>(arg0, 9, b"YO", b"Yugi Oh", b"Gamble King", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25a5a21e-072d-43f1-9612-4afad0439d38.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YO>>(v1);
    }

    // decompiled from Move bytecode v6
}

