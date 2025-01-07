module 0x6fcd80624fee7cdceb899a6fda1beb502f5f023cc41c78d6d78ff8e321ee4409::el {
    struct EL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EL>(arg0, 9, b"EL", b"Elon", b"Cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4c98141-a485-495c-ae14-89d47dcd6939.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EL>>(v1);
    }

    // decompiled from Move bytecode v6
}

