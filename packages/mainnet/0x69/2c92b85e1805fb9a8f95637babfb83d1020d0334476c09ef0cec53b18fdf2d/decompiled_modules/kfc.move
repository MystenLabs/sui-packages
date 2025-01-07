module 0x692c92b85e1805fb9a8f95637babfb83d1020d0334476c09ef0cec53b18fdf2d::kfc {
    struct KFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFC>(arg0, 9, b"KFC", b"kfc", b"special fried chicken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95d3d38d-9242-4614-a7a8-7dd22b26933a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

