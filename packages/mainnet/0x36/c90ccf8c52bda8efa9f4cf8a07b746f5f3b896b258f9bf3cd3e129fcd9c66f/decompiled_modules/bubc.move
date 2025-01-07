module 0x36c90ccf8c52bda8efa9f4cf8a07b746f5f3b896b258f9bf3cd3e129fcd9c66f::bubc {
    struct BUBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBC>(arg0, 9, b"BUBC", b"BubbleCat", b"Because cats need bubbles too.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ea95dbf-ca39-47b9-86f7-e19b8ef2a27a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

