module 0x36950e8f69c3a2bc2ee49914b4311415777c9708fb80858423222746e6fa01cf::diamkau {
    struct DIAMKAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMKAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMKAU>(arg0, 9, b"DIAMKAU", b"Tolongkaki", b"Stupid meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/459917cd-53ce-4713-b020-cd6a3743dc3f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMKAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIAMKAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

