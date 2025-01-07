module 0x3828b09e82e6be5c8ec64f11ecd41975bacbce1ed265fc807e9efebb64691123::xtn {
    struct XTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XTN>(arg0, 9, b"XTN", b"xinthenho", b"xinquaday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa400680-91ae-420b-a7b9-39ddee8aba49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

