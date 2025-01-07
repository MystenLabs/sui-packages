module 0xa96064a1be6d5efcfff4c3a528f7dbcedd425eeb171c6a399a79f1ba29608e83::wooff {
    struct WOOFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOFF>(arg0, 9, b"WOOFF", b"woof", x"576f6f6620776f6f6620776f6f6620f09f90b620", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2045e09d-a290-43bc-9ddf-cc82e348c975.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

