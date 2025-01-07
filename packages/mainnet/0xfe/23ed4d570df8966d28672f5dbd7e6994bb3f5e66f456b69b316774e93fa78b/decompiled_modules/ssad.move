module 0xfe23ed4d570df8966d28672f5dbd7e6994bb3f5e66f456b69b316774e93fa78b::ssad {
    struct SSAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSAD>(arg0, 9, b"SSAD", b"ASDDAS", b"ASDQWF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fe1f6fd-c2b7-4212-8641-198efaf762fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

