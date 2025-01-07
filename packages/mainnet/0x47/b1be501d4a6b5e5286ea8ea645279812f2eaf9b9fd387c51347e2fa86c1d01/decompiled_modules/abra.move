module 0x47b1be501d4a6b5e5286ea8ea645279812f2eaf9b9fd387c51347e2fa86c1d01::abra {
    struct ABRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABRA>(arg0, 9, b"ABRA", b"Abracadabr", x"d0a2d0bed0bad0b5d0bd20d0b4d0bbd18f20d0b2d181d0b5d18520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7949ef3a-b4ef-4a46-bff7-5c5e719dc6d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

