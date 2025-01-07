module 0xf0117e5037eca29f0325d9b30f76bd6a1e9553e13b4dc5557c968b8511cb40e5::wavepump {
    struct WAVEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEPUMP>(arg0, 9, b"WAVEPUMP", b"Wave", b"Wave wallet is the best project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/882afeab-2562-4e54-bc58-d63af25fc10b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

