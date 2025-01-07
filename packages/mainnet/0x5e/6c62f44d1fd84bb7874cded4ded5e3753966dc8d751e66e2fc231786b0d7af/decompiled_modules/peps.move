module 0x5e6c62f44d1fd84bb7874cded4ded5e3753966dc8d751e66e2fc231786b0d7af::peps {
    struct PEPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPS>(arg0, 9, b"PEPS", b"Pepe USA", b"The only thing that matters to you right ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6623c52-73e9-4aa1-adb9-8d0bbcee8215.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

