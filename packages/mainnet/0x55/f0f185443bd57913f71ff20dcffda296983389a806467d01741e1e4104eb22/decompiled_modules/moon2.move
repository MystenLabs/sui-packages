module 0x55f0f185443bd57913f71ff20dcffda296983389a806467d01741e1e4104eb22::moon2 {
    struct MOON2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON2>(arg0, 9, b"MOON2", b"Themoon", b"My meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a7c5a13-4709-4623-b847-aa85647f8487.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON2>>(v1);
    }

    // decompiled from Move bytecode v6
}

