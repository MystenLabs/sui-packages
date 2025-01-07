module 0xea95e2d50b6da8eb157dfca86597cb906d9838c9412e2de87faab1e4d86deffc::tomorw {
    struct TOMORW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMORW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMORW>(arg0, 9, b"TOMORW", b"TOMORROW ", b"TOMORROW, is a TOMORROW, you wake up TOMORROW, you TOMORROW you wake up, you motivate TOMORROW TOMORROW you Wake up TOMORROW TOMORROW TOMORROW to wake up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0914778-6062-4531-a845-3dfff1295216.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMORW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMORW>>(v1);
    }

    // decompiled from Move bytecode v6
}

