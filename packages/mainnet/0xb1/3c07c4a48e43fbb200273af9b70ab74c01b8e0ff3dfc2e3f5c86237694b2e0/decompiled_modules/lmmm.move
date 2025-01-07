module 0xb13c07c4a48e43fbb200273af9b70ab74c01b8e0ff3dfc2e3f5c86237694b2e0::lmmm {
    struct LMMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMMM>(arg0, 9, b"LMMM", b"LORDSHIP", b"Just being a human ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/339cace9-6b02-40e0-b3d7-c0f506ea27ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LMMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

