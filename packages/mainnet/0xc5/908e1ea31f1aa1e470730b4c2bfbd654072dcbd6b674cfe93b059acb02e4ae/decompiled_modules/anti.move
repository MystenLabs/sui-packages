module 0xc5908e1ea31f1aa1e470730b4c2bfbd654072dcbd6b674cfe93b059acb02e4ae::anti {
    struct ANTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTI>(arg0, 9, b"ANTI", b"ANTIWEWE", b"We are anti ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e803434-0ef9-4632-b763-1108347691c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

