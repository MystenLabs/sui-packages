module 0x66829b25bf6ad14cd5b949d198d1a5190a5fd73ab4c1a74008432e6a6ad8034d::boss {
    struct BOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSS>(arg0, 9, b"BOSS", b"BOSS LOUNG", b"Exclusive loungers ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b881d5a4-64ea-4746-9fa5-d637dab86cdd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

