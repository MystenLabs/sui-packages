module 0xd0a333621ae4ac1b762866d764444d0ea03c7dabe622a80232c44b7dd067468a::sweets {
    struct SWEETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWEETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEETS>(arg0, 9, b"SWEETS", b"Sweets", b"Let's celebrate BTC all time high with buying SWEETS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0a46585-aab3-4572-8d53-97def2c65b49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWEETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

