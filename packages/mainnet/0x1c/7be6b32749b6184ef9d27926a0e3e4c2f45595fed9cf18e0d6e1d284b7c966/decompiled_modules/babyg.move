module 0x1c7be6b32749b6184ef9d27926a0e3e4c2f45595fed9cf18e0d6e1d284b7c966::babyg {
    struct BABYG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYG>(arg0, 9, b"BABYG", b"baby green", b"baby green token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0daf1bb1-46a7-4b03-b36b-23565efec75e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYG>>(v1);
    }

    // decompiled from Move bytecode v6
}

