module 0x94a512afafbdb4f92e15564a47058f9bcf2ecffa315ae44ebeb6cd8df2f66af9::zevus {
    struct ZEVUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEVUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEVUS>(arg0, 9, b"ZEVUS", b"Zevs", b"Zevs cats ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea3361e9-7d3e-42ca-915b-949dd5a45a45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEVUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEVUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

