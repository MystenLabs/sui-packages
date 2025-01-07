module 0x5033675576ea66985c5e526ce6219c42086f87d2b74cbe4c9df711f82c0335e2::manutd {
    struct MANUTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANUTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANUTD>(arg0, 9, b"MANUTD", b"Manutdian", b"Manutdian is meme man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/41b469f9-594d-4276-8c75-ca8eaaea79a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANUTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANUTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

