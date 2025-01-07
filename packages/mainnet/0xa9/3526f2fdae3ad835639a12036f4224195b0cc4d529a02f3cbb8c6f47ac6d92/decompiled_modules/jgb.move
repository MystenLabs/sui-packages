module 0xa93526f2fdae3ad835639a12036f4224195b0cc4d529a02f3cbb8c6f47ac6d92::jgb {
    struct JGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JGB>(arg0, 9, b"JGB", b"Jahh", b"A coin for bullrun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04bc9762-1a63-4418-afb7-29e52df0ec05.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

