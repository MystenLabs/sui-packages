module 0xe947839f563df3b292e588868bb969d019918ee2db37f633040eba647f9f0f2::ronaldo {
    struct RONALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONALDO>(arg0, 9, b"RONALDO", b"Cr7", b"If you've already started, don't give up until you get what you want", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/590c1ae1-97bb-464f-9e62-a2fae345b684.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONALDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RONALDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

