module 0xb8d7bc3f4bc17f0ecfe6e11d45915457e03382bf8ba25df4e826cb0828feb210::bhfd {
    struct BHFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHFD>(arg0, 9, b"BHFD", b"DSAF", b"EWT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6f6f387-2e2f-4052-b66d-69e792fee315.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BHFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

