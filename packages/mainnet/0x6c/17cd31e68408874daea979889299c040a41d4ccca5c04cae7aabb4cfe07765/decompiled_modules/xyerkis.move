module 0x6c17cd31e68408874daea979889299c040a41d4ccca5c04cae7aabb4cfe07765::xyerkis {
    struct XYERKIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XYERKIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XYERKIS>(arg0, 9, b"XYERKIS", b"SMRK", b"Blum ))", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99a2760a-60b4-4939-9d6b-c270e099a12d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XYERKIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XYERKIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

