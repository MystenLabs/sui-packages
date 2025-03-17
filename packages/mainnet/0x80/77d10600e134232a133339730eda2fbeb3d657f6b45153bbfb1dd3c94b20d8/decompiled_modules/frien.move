module 0x8077d10600e134232a133339730eda2fbeb3d657f6b45153bbfb1dd3c94b20d8::frien {
    struct FRIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIEN>(arg0, 9, b"FRIEN", b"Frieren AI", b"Frieren is meme coin on Sui network,this coin is connecting between anime and sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ac99334-3c50-429d-b035-b0b5edfababe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

