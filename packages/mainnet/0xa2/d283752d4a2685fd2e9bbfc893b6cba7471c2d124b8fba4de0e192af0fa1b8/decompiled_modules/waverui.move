module 0xa2d283752d4a2685fd2e9bbfc893b6cba7471c2d124b8fba4de0e192af0fa1b8::waverui {
    struct WAVERUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVERUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVERUI>(arg0, 9, b"WAVERUI", b"Rui", b"A growing platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76b77981-df8d-4848-a433-64cf0f2f6540.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVERUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVERUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

