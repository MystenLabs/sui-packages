module 0xb401d54f1fe499b634510fbbfba1989817f62d492c856042561b7a28425e3c26::bartolomeo {
    struct BARTOLOMEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARTOLOMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARTOLOMEO>(arg0, 9, b"BARTOLOMEO", b"BART ", b"B. J. Simpson ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cda41dac-803d-4278-be6e-5775a20e7150.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARTOLOMEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARTOLOMEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

