module 0xdffa9272be54e0cb46b863f0d778ccf7b0c96d17850be1adde22226580813421::peanut86 {
    struct PEANUT86 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEANUT86, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEANUT86>(arg0, 9, b"PEANUT86", b"Peanut", b"Leanut is the extremely cute puppy of a young billionaire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71d135fc-534d-4543-97dd-fc24e46c4ed9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEANUT86>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEANUT86>>(v1);
    }

    // decompiled from Move bytecode v6
}

