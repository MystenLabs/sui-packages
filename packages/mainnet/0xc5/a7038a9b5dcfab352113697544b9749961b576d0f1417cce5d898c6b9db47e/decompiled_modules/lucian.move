module 0xc5a7038a9b5dcfab352113697544b9749961b576d0f1417cce5d898c6b9db47e::lucian {
    struct LUCIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCIAN>(arg0, 9, b"LUCIAN", b"Lucia", b"Lolvn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2fab6f1-be28-4d04-b458-a8b6d2fe453f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

