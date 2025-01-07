module 0x9adc0ac58a4daec34b431fbcfedb274d3e174a709aa4cb771aa4715111c380fb::tino {
    struct TINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINO>(arg0, 9, b"TINO", b"MARTINO", b"Personal name ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26945700-8767-4e39-95c5-c88b69ffe4b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

