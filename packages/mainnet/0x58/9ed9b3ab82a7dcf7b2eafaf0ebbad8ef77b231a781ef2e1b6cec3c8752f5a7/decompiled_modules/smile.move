module 0x589ed9b3ab82a7dcf7b2eafaf0ebbad8ef77b231a781ef2e1b6cec3c8752f5a7::smile {
    struct SMILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILE>(arg0, 9, b"SMILE", b"Wsmile", b"Word with Millions means", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7501d6a-7793-4ad7-8ad1-68747ce8c323.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

