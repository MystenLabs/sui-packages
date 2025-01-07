module 0x1e8475985a0b999887ea5db3c304f34065b51121159fbc02b3c835ef9e1673c0::bick {
    struct BICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BICK>(arg0, 9, b"BICK", b"GotBigBick", b"Elon Musk Twitted, \"I got a big bick\". Does he?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d56ccc9a-95a7-4440-8771-8cf40a6adf8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

