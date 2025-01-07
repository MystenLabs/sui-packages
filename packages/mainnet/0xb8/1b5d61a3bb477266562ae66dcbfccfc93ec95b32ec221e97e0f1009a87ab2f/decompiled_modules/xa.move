module 0xb81b5d61a3bb477266562ae66dcbfccfc93ec95b32ec221e97e0f1009a87ab2f::xa {
    struct XA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XA>(arg0, 9, b"XA", b"ZANNA ", b"Greatness ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/864d05ca-6e7b-4cbf-9c53-76ad67e6a84b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XA>>(v1);
    }

    // decompiled from Move bytecode v6
}

