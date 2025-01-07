module 0x2709d035cfbb5a4d0f1a4b44b582091ae476ed1c6826e3ed4af1b954096a4289::blum {
    struct BLUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUM>(arg0, 9, b"BLUM", b"$BLUM", b"ALL CRYPTO - ONE APP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3c449ae-b6a3-4d9b-82be-157f80b247b6-1000175837.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

