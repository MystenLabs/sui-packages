module 0xd5a21057a8c21390182778bf204b09939fac300b22dbad06d4fbac83a67f86e9::fcjkbsfgjm {
    struct FCJKBSFGJM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCJKBSFGJM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCJKBSFGJM>(arg0, 9, b"FCJKBSFGJM", b"Fhncdf", b"Cnkkddehjk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e99f648a-582c-4f97-9304-101dca925f87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCJKBSFGJM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCJKBSFGJM>>(v1);
    }

    // decompiled from Move bytecode v6
}

