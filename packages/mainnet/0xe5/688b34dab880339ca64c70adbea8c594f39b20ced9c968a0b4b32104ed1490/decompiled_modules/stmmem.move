module 0xe5688b34dab880339ca64c70adbea8c594f39b20ced9c968a0b4b32104ed1490::stmmem {
    struct STMMEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STMMEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STMMEM>(arg0, 9, b"STMMEM", b"STM", b"TOKENMEM STM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef8421bc-a2a0-420e-b654-e143ace5ef55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STMMEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STMMEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

