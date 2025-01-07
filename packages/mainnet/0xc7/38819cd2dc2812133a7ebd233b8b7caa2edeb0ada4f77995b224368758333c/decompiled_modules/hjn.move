module 0xc738819cd2dc2812133a7ebd233b8b7caa2edeb0ada4f77995b224368758333c::hjn {
    struct HJN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJN>(arg0, 9, b"HJN", b"GR", b"CV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34ac952f-114a-460e-ae4d-466a6ddd41a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HJN>>(v1);
    }

    // decompiled from Move bytecode v6
}

