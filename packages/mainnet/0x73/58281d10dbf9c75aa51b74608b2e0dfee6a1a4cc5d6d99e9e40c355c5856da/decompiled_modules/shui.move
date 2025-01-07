module 0x7358281d10dbf9c75aa51b74608b2e0dfee6a1a4cc5d6d99e9e40c355c5856da::shui {
    struct SHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUI>(arg0, 6, b"SHUI", x"53485549202d20e4b88ae59684e88ba5e6b0b4f09f92a7", x"e4b88ae59684e88ba5e6b0b4e380820ae6b0b4e59684e588a9e4b887e789a9e8808ce4b88de4ba89efbc8ce5a484e4bc97e4babae4b98be68980e681b6efbc8ce69585e587a0e4ba8ee98193e380820ae5b185e59684e59cb0efbc8ce5bf83e59684e6b88aefbc8ce4b88ee59684e4bb81efbc8ce8a880e59684e4bfa1efbc8ce694bfe59684e6b2bbefbc8ce4ba8be59684e883bdefbc8ce58aa8e59684e697b6e380820ae5a4abe594afe4b88de4ba89efbc8ce69585e697a0e5b0a4e38082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731721941033.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

