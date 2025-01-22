module 0x989d51f645f5d29605c14a4680ecaca0dace874f385ee9686bc2567fd10b8ce3::fight {
    struct FIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FIGHT>(arg0, 6, b"FIGHT", b"Trump Fight Agent by SuiAI", b"Sui's AI Agent: Redefining the future, making it great like Trump MAGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/super_resolution_20250119224204729_83747466456631929246447_09152063868835068748879_3cd5ad47c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIGHT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

