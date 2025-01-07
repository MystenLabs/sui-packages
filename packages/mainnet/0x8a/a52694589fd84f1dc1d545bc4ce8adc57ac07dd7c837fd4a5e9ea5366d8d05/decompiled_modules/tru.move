module 0x8aa52694589fd84f1dc1d545bc4ce8adc57ac07dd7c837fd4a5e9ea5366d8d05::tru {
    struct TRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRU>(arg0, 9, b"TRU", b"Trumpa", b"Trumps Pump it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d67d1ec-038c-4c4f-aee5-ac1c13b8ec9e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRU>>(v1);
    }

    // decompiled from Move bytecode v6
}

