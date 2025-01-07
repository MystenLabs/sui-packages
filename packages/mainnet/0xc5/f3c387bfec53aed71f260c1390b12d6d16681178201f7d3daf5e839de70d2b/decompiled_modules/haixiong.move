module 0xc5f3c387bfec53aed71f260c1390b12d6d16681178201f7d3daf5e839de70d2b::haixiong {
    struct HAIXIONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIXIONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIXIONG>(arg0, 9, b"HAIXIONG", b"shi", b"sjdiendxbsjhsb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a43b20f6-d2a0-4f17-b018-3f98e3c109d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIXIONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAIXIONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

