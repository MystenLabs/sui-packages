module 0xf8ae2e5a6f87a7c957b09a049c10937d55d2b13c43be2d4f83cab8051df7bd01::mush {
    struct MUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSH>(arg0, 9, b"MUSH", b"Mushi cat", b"Mushi on da head", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0aa6f7be-c3d3-48f3-9437-2536b15d7456.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

