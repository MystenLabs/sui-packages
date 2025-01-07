module 0x50dc4c9b58eac6099afdb7fb17ca5a704b8ace9214bfa792fdcc01b6df177eb6::ttf {
    struct TTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTF>(arg0, 9, b"TTF", b"fire", b"heater", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/68cf8ad8-0d7f-4d5b-aedf-70d5b057a6c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTF>>(v1);
    }

    // decompiled from Move bytecode v6
}

