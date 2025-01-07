module 0xd918f13c323ec682a99969f6c49548bbee77ae8809cf41bd7d2cff745eaf1947::bui {
    struct BUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUI>(arg0, 9, b"BUI", b"Baby Sui ", b"Just a meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/964b4d7f-766b-4f50-8a71-74b294dc3e29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

