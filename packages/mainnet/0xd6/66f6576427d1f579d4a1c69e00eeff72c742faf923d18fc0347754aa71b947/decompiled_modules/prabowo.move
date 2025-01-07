module 0xd666f6576427d1f579d4a1c69e00eeff72c742faf923d18fc0347754aa71b947::prabowo {
    struct PRABOWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRABOWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRABOWO>(arg0, 9, b"PRABOWO", b"PRABOWO ID", b"PRESIDENT OF INDONESIA, 20 OCTOBER 2024 WILL GO TO 1 BILLION MARKET CAP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/073d1fec-f78b-4dc1-b94d-9ba27571b164.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRABOWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRABOWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

