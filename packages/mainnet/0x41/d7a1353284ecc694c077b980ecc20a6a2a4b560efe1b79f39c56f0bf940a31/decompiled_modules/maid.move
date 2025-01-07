module 0x41d7a1353284ecc694c077b980ecc20a6a2a4b560efe1b79f39c56f0bf940a31::maid {
    struct MAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAID>(arg0, 9, b"MAID", b"Mermaid", b"Cute and beautiful mermaid roars across the vast ocean ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f55003d-535b-4fbd-b2eb-78554ec9a6be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAID>>(v1);
    }

    // decompiled from Move bytecode v6
}

