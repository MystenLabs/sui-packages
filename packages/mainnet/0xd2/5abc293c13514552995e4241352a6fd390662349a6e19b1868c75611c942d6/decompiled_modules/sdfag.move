module 0xd25abc293c13514552995e4241352a6fd390662349a6e19b1868c75611c942d6::sdfag {
    struct SDFAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFAG>(arg0, 9, b"SDFAG", b"NG", b" BX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44e6f929-049a-4963-aa49-26327bc14b53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDFAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

