module 0x40f87195864bafdef08fc8dd873824a4f721c92dd916482e1c0261e8653000f6::lop {
    struct LOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOP>(arg0, 9, b"LOP", b"loopy", b"looky days Sui,are you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8807069f-503c-4310-b4ef-59ebe843e532.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

