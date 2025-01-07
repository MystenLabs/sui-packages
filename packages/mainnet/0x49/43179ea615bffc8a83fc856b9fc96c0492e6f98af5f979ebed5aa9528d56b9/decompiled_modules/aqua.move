module 0x4943179ea615bffc8a83fc856b9fc96c0492e6f98af5f979ebed5aa9528d56b9::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 9, b"AQUA", b"Minaaqua", b"Istanbun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e52ae56b-3e0b-45e3-9ccd-7b251b8d6899.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

