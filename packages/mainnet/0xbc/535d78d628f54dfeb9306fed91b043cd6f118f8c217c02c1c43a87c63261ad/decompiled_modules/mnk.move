module 0xbc535d78d628f54dfeb9306fed91b043cd6f118f8c217c02c1c43a87c63261ad::mnk {
    struct MNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNK>(arg0, 9, b"MNK", b"MEOWKING", b"Hub for all memecoins ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef732456-9fac-408b-95ff-17ec85d0412c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

