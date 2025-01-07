module 0x7af405c0d36558d47a33a654f457b7aa2e0cd2b30cebfceb33dcf4ff0073946f::tpain {
    struct TPAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPAIN>(arg0, 9, b"TPAIN", b"T-pain", b"Community driven token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eed5fe0b-cf32-4e7d-b488-f5a4b666797a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

