module 0x7b2264a87dfd684f70fec032bcabdfcd2dc3ddd87654dea6c8936f1269f2e06b::favy {
    struct FAVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAVY>(arg0, 9, b"FAVY", b"Favozy", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a087e6a9-5441-48cd-8a4a-822978047b00.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

