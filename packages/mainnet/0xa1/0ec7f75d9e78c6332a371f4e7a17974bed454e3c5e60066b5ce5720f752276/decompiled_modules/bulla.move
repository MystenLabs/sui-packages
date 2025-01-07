module 0xa10ec7f75d9e78c6332a371f4e7a17974bed454e3c5e60066b5ce5720f752276::bulla {
    struct BULLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLA>(arg0, 9, b"BULLA", b"BULLish", b"The bullish market come back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cdf320e7-fe1d-4a50-9096-ac3220269a99.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

