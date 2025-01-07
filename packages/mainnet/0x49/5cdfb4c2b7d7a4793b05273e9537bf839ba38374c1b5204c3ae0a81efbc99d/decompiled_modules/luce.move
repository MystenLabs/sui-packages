module 0x495cdfb4c2b7d7a4793b05273e9537bf839ba38374c1b5204c3ae0a81efbc99d::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 9, b"LUCE", b"LUZE", b"Official Mascot of the Holy Year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f186e4a6-dd0d-43ac-921a-23a0877ef1a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

