module 0xe4f387fc14efa2d568bf2d89dd464919909a559d0bc43e513465d02e2b16604::bh {
    struct BH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BH>(arg0, 9, b"BH", b"BullHigh", x"42657374206869676820706572666f726d616e636520f09f9a8020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3dc22b4a-7966-4a8c-9ad3-fa9ff5f6f0db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BH>>(v1);
    }

    // decompiled from Move bytecode v6
}

