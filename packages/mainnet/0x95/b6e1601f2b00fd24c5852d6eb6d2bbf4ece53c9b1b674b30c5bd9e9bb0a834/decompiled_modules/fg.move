module 0x95b6e1601f2b00fd24c5852d6eb6d2bbf4ece53c9b1b674b30c5bd9e9bb0a834::fg {
    struct FG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FG>(arg0, 9, b"FG", b"SAF", b"Q", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0bb5983-590b-4b21-80be-0d6c6d8de568.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FG>>(v1);
    }

    // decompiled from Move bytecode v6
}

