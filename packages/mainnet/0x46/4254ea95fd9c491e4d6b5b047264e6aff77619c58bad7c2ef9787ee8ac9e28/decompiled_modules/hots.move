module 0x464254ea95fd9c491e4d6b5b047264e6aff77619c58bad7c2ef9787ee8ac9e28::hots {
    struct HOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTS>(arg0, 9, b"HOTS", b"HOT ", b"HOT FUTURE PLAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd399d96-7dcc-4b86-9d01-48a5b81a9038.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

