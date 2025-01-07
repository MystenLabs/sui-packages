module 0xb7abfbd0bb0ccbadb3ae93c39d0b83734703706f052b833fff82861a574853f4::bkieu {
    struct BKIEU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKIEU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKIEU>(arg0, 9, b"BKIEU", b"Bang", b"Air01", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f1f03ba3-c6f4-491d-9677-16c790e502a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKIEU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKIEU>>(v1);
    }

    // decompiled from Move bytecode v6
}

