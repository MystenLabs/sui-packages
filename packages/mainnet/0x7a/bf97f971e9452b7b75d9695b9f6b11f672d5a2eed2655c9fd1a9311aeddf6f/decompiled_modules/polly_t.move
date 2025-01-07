module 0x7abf97f971e9452b7b75d9695b9f6b11f672d5a2eed2655c9fd1a9311aeddf6f::polly_t {
    struct POLLY_T has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLLY_T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLLY_T>(arg0, 9, b"POLLY_T", b"Poollyyy", b"Just test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6edd9bd-e3e5-4578-bb0e-1bbb3ab16e1f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLLY_T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLLY_T>>(v1);
    }

    // decompiled from Move bytecode v6
}

