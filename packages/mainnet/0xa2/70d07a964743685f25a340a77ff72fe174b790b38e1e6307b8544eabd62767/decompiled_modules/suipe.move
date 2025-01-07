module 0xa270d07a964743685f25a340a77ff72fe174b790b38e1e6307b8544eabd62767::suipe {
    struct SUIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPE>(arg0, 9, b"SUIPE", b"Sui Pepe", b"SuiPepe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/57594019-87df-4373-8ad1-1a11125ff1d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

