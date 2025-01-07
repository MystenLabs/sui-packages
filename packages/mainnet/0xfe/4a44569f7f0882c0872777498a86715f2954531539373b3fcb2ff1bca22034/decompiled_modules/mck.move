module 0xfe4a44569f7f0882c0872777498a86715f2954531539373b3fcb2ff1bca22034::mck {
    struct MCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCK>(arg0, 9, b"MCK", b"MoonCake", b"MoonCake token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b54ab9e-38c8-4c10-aecb-70d9562c5ba1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

