module 0xe13658d15ee76065fdbf4ca27b93610a7c87edfd1de7e75803f3ec00ca83eedf::mito {
    struct MITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MITO>(arg0, 9, b"MITO", b"Mito Token", b"mito crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d27158d-ba03-46ab-a0c8-a359c6e47b82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

