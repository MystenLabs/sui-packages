module 0x656994405e67afe8fe3a6c46bf7e9437c2e5367059cc9041250b043870e41fd::dkfmm {
    struct DKFMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKFMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKFMM>(arg0, 9, b"DKFMM", b"Sysjwn", b"Fkfkfm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/169949b4-6059-468c-8450-b20c88cdf0cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKFMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKFMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

