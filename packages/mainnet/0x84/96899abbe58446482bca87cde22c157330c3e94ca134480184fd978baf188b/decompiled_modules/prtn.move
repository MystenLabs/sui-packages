module 0x8496899abbe58446482bca87cde22c157330c3e94ca134480184fd978baf188b::prtn {
    struct PRTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRTN>(arg0, 9, b"PRTN", b"Proton", b"Fan-token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21ee2a6c-107a-4ac2-8168-2ab8ea5715b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

