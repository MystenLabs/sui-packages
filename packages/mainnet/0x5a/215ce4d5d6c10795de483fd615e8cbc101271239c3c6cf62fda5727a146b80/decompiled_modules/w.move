module 0x5a215ce4d5d6c10795de483fd615e8cbc101271239c3c6cf62fda5727a146b80::w {
    struct W has drop {
        dummy_field: bool,
    }

    fun init(arg0: W, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W>(arg0, 9, b"W", b"WaveS", b"WaveS and W", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/153e4f5c-48ff-4b6a-aa6c-2b104aa49017.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<W>>(v1);
    }

    // decompiled from Move bytecode v6
}

