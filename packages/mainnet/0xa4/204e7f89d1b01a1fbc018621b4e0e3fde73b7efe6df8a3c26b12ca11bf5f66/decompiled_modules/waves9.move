module 0xa4204e7f89d1b01a1fbc018621b4e0e3fde73b7efe6df8a3c26b12ca11bf5f66::waves9 {
    struct WAVES9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVES9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVES9>(arg0, 9, b"WAVES9", b"Babywaves ", b"Babywaves is a cryptocurrency created by the waves community. It allows users to create and trade custom digital tokens without needing extensive on waves surface", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ce74922-3e9e-4556-aa5d-154b1e123293.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVES9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVES9>>(v1);
    }

    // decompiled from Move bytecode v6
}

