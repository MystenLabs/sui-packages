module 0x3eae6573afb026a51fbbd85884bf261d97cb297712ef5a8f1e83eb149c192879::soho {
    struct SOHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOHO>(arg0, 9, b"SOHO", b"soho", b"sohopump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aed34f29-cfef-4cb0-b7ef-e54bf3b12707.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

