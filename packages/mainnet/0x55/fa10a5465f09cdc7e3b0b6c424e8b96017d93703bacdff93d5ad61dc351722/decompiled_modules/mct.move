module 0x55fa10a5465f09cdc7e3b0b6c424e8b96017d93703bacdff93d5ad61dc351722::mct {
    struct MCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCT>(arg0, 9, b"MCT", b"1$MECYT", b"A fluffy cat sat gracefully on the lap of a young lady who was smiling warmly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61eb589e-e2e6-4f4a-82d7-ea61f4ac9182.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

