module 0x30054e3d050f5273941022679356dedce4cebdfe4ce594f82cfe1b65a4d2f6de::jeans {
    struct JEANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEANS>(arg0, 9, b"JEANS", b"Jeans on m", b"Jeans on me;)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a680c3af-ba3e-4b34-ba24-a29070c07384.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

