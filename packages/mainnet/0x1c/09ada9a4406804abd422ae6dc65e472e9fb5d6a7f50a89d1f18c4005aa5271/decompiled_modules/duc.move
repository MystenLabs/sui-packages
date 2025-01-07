module 0x1c09ada9a4406804abd422ae6dc65e472e9fb5d6a7f50a89d1f18c4005aa5271::duc {
    struct DUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUC>(arg0, 9, b"DUC", b"Dugo", b"Dugo is the iconic of the American rapper which is popular to stand out from other meme and become the best meme in wave community with a real life utility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea45a608-1e25-436c-91f5-77c9b473b0cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

