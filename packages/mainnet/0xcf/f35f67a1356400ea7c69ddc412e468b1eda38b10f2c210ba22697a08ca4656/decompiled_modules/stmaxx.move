module 0xcff35f67a1356400ea7c69ddc412e468b1eda38b10f2c210ba22697a08ca4656::stmaxx {
    struct STMAXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: STMAXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STMAXX>(arg0, 9, b"STMAXX", b"Stmax", b"Stmaxxxxxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45f0c9c9-6c60-42a3-8e7d-18663b92b5e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STMAXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STMAXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

