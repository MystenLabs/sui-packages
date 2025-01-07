module 0xf5d084234825b4f150ab610c0144dcb0018fbea9191b6a770993d0fc7e33572::ann {
    struct ANN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANN>(arg0, 9, b"ANN", b"Ayoyinka H", b"Wave wallet meme culture Ann", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/683a722a-bbc7-4707-b7fe-4c3696512312.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANN>>(v1);
    }

    // decompiled from Move bytecode v6
}

