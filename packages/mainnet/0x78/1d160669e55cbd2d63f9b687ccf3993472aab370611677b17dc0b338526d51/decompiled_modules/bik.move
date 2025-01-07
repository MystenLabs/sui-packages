module 0x781d160669e55cbd2d63f9b687ccf3993472aab370611677b17dc0b338526d51::bik {
    struct BIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIK>(arg0, 9, b"BIK", b"Okx ", x"4869e1bb837520c491c6b0e1bba36320c3bd20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2cb074fe-6b0a-41fb-a8b1-598c8c3b9ab8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

