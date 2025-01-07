module 0x337fcbed4f3be15ad340a7c1a911da9ea91c91230ff143f625550d2a45911413::hold {
    struct HOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLD>(arg0, 9, b"HOLD", b"Big thing ", b"Just for fun buy and hold good news coming soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce32ea77-3660-4a71-8063-40780274282f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

