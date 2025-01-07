module 0x4a7383b0fcbbb5400f1417286d32db36383b94dea4b70c34d6ca86fc8ca22d61::elg {
    struct ELG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELG>(arg0, 9, b"ELG", b"Erlanggu", b"Its okay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f8e094d-2d19-4e8d-a201-24b0ce017385.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELG>>(v1);
    }

    // decompiled from Move bytecode v6
}

