module 0x12b0aeda71709046f62d2bd44aa793515d712dab1dbaa740670f100d4149faef::kakai {
    struct KAKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKAI>(arg0, 9, b"KAKAI", b"KAKAS", b"WHEN THIS THAT THEY DO IN FOR YOU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/586b4a13-1f43-43c7-92b4-dda395af7ce7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

