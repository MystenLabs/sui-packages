module 0x338d41ec994ef185f019b992090fb0e5281a78913f1b9b991b7e0187173d1c7d::llwneb {
    struct LLWNEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLWNEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLWNEB>(arg0, 9, b"LLWNEB", b"jsskn", b"ksnsbw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14c0f13f-8e75-4f85-b647-5da46a57f223.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLWNEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLWNEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

