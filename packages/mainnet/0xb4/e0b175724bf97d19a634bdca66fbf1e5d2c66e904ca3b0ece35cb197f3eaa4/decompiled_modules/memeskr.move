module 0xb4e0b175724bf97d19a634bdca66fbf1e5d2c66e904ca3b0ece35cb197f3eaa4::memeskr {
    struct MEMESKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMESKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMESKR>(arg0, 9, b"MEMESKR", b"SKR", b"Memeskr on sui block chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3dbe6810-468a-4b81-8ea9-f36b88d9cc7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMESKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMESKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

