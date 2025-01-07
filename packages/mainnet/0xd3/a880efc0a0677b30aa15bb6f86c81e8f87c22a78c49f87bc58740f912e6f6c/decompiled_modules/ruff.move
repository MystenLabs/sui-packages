module 0xd3a880efc0a0677b30aa15bb6f86c81e8f87c22a78c49f87bc58740f912e6f6c::ruff {
    struct RUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUFF>(arg0, 6, b"RUFF", b"First Ruff On Sui", b"Ruff on Solana has skyrocketed by 100x, attracting significant attention. But what about Ruff on Sui?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_new_a9a3272677.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

