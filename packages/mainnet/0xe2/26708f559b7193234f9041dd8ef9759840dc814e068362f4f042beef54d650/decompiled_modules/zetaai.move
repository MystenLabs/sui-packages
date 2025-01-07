module 0xe226708f559b7193234f9041dd8ef9759840dc814e068362f4f042beef54d650::zetaai {
    struct ZETAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZETAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZETAAI>(arg0, 9, b"ZETAAI", b"ZETAA", b"Ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ad5650d-9e33-466c-a660-6e8511d86d57.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZETAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZETAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

