module 0xa276c7f9d3db4e03af816986ebb0650fb6ec9e92f6ced3fb341cb62bf4e39453::d_123 {
    struct D_123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: D_123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D_123>(arg0, 9, b"D_123", b"FBW3", b"Just have some funbeyondweb3 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8acf1ab0-b587-4fc1-8b7a-7e8ee1fa68d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D_123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D_123>>(v1);
    }

    // decompiled from Move bytecode v6
}

