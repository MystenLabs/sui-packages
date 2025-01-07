module 0x30408e7731d13e4c394731e842ec2e4647c2f7ae93fc5dbfabacd85f41733a84::dera {
    struct DERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERA>(arg0, 9, b"DERA", b"CHI", b"Memecoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/019a3afa-9694-4c28-b25d-f97cc7a96cad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DERA>>(v1);
    }

    // decompiled from Move bytecode v6
}

