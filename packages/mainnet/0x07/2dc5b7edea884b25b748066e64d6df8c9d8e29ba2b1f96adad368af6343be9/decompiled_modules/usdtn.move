module 0x72dc5b7edea884b25b748066e64d6df8c9d8e29ba2b1f96adad368af6343be9::usdtn {
    struct USDTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDTN>(arg0, 9, b"USDTN", b"ERRORS", b"404", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d10e6c22-a389-452c-bfc3-493d97031131.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

