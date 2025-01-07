module 0x5f3a6aa34c5af181152c48f08ecb2f510011690041b7f4594a321304bd4860a6::tm {
    struct TM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TM>(arg0, 9, b"TM", b"ToMars", b"Fly any where you can", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbf37820-8e8b-4b58-aab1-c16b52b652be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TM>>(v1);
    }

    // decompiled from Move bytecode v6
}

