module 0x72de836598aade22a644d9d3ae5aba25e371f698a7a76c261ceb0860448e8eae::seed {
    struct SEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEED>(arg0, 9, b"SEED", b"Seed Sui", b"Community token for all sui users", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8556292-4ba4-4ea4-abc6-ad7413d741b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

