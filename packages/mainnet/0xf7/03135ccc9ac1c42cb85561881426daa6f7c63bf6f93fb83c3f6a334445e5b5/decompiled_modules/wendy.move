module 0xf703135ccc9ac1c42cb85561881426daa6f7c63bf6f93fb83c3f6a334445e5b5::wendy {
    struct WENDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WENDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WENDY>(arg0, 9, b"WENDY", b"Wendy cat", b"Wendycat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53bb2d12-5e3b-443d-b86a-1d53f3410593.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WENDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WENDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

