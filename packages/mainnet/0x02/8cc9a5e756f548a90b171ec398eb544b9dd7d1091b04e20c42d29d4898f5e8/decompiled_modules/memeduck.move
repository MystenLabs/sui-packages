module 0x28cc9a5e756f548a90b171ec398eb544b9dd7d1091b04e20c42d29d4898f5e8::memeduck {
    struct MEMEDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEDUCK>(arg0, 9, b"MEMEDUCK", b"Duck", b"Mem duck coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/477ffede-625d-44ac-98e9-83eec5bd80ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

