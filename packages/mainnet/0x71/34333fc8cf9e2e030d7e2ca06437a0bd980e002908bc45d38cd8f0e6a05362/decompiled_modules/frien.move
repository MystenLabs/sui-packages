module 0x7134333fc8cf9e2e030d7e2ca06437a0bd980e002908bc45d38cd8f0e6a05362::frien {
    struct FRIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIEN>(arg0, 9, b"FRIEN", b"Frieren AI", b"Frieren is meme coin on Sui network,this coin is connecting between anime and sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c585135-649b-496d-af7f-97e667586526.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

