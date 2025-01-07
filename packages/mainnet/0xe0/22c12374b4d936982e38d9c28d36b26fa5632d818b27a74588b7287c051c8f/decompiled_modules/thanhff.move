module 0xe022c12374b4d936982e38d9c28d36b26fa5632d818b27a74588b7287c051c8f::thanhff {
    struct THANHFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: THANHFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THANHFF>(arg0, 9, b"THANHFF", b"Xuan", b"Cuti", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb1c0d2a-c0a5-4e02-ba7e-fc5710efe13c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THANHFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THANHFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

