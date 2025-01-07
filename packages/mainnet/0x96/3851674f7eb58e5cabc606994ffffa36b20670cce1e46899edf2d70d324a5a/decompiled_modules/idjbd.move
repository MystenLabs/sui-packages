module 0x963851674f7eb58e5cabc606994ffffa36b20670cce1e46899edf2d70d324a5a::idjbd {
    struct IDJBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDJBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDJBD>(arg0, 9, b"IDJBD", b"jdnd", b"hddn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27665166-5061-457e-808e-718205a5f369.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDJBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDJBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

