module 0x6ed818fda3edfcc07e84603422f0b146c33b7524934223e23d5d621cedb64cbc::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK>(arg0, 9, b"SHARK", b"Babyy Shar", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f306ddbd-b5f7-4016-9dba-312453d0663d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

