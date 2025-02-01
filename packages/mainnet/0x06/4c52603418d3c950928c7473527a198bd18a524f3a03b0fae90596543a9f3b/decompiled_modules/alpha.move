module 0x64c52603418d3c950928c7473527a198bd18a524f3a03b0fae90596543a9f3b::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA>(arg0, 9, b"ALPHA", b"ALPHA ON S", b"Be what you hold. Hold $ALPHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26ed7577-47df-486b-ad25-c07072e8fcff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALPHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

