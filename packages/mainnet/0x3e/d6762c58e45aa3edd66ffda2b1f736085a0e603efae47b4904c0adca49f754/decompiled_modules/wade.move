module 0x3ed6762c58e45aa3edd66ffda2b1f736085a0e603efae47b4904c0adca49f754::wade {
    struct WADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WADE>(arg0, 9, b"WADE", b"Wave Ride", b"Celebrate WAVE breaking and wishing future success", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1bfa40f5-a397-44f5-960b-27df5ae9afe9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

