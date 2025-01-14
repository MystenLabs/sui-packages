module 0x3535885c9d53edffd24abbf3078702e468d73c7e05b8f3a6671afbbfe4135ca0::ffttyy {
    struct FFTTYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFTTYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFTTYY>(arg0, 6, b"FFTTYY", b"DFYGUHIUOI", b"FYUIKMNRFYH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CFM_3a85384816.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFTTYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFTTYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

