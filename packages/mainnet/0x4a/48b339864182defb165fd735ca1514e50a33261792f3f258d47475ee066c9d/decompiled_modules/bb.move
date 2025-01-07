module 0x4a48b339864182defb165fd735ca1514e50a33261792f3f258d47475ee066c9d::bb {
    struct BB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BB>(arg0, 9, b"BB", b"Bybut", b"Bybit lo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/025e5d65-717d-4c3a-a906-6b694251439a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BB>>(v1);
    }

    // decompiled from Move bytecode v6
}

