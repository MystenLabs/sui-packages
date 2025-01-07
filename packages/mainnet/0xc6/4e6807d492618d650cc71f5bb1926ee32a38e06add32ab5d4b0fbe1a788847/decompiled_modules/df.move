module 0xc64e6807d492618d650cc71f5bb1926ee32a38e06add32ab5d4b0fbe1a788847::df {
    struct DF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DF>(arg0, 9, b"DF", b"KJH", b"BBC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7700bdb7-2234-4289-b92c-7357e768e5c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DF>>(v1);
    }

    // decompiled from Move bytecode v6
}

