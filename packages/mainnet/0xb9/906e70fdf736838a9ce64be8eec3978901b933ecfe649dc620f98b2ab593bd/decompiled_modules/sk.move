module 0xb9906e70fdf736838a9ce64be8eec3978901b933ecfe649dc620f98b2ab593bd::sk {
    struct SK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SK>(arg0, 9, b"SK", b"Sketch ", b"The most important aspect is ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae375cf3-265d-48e5-8065-7c804cb0ee57.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SK>>(v1);
    }

    // decompiled from Move bytecode v6
}

