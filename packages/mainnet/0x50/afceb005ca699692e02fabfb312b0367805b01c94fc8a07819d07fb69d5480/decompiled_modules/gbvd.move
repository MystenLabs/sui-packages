module 0x50afceb005ca699692e02fabfb312b0367805b01c94fc8a07819d07fb69d5480::gbvd {
    struct GBVD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBVD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBVD>(arg0, 9, b"GBVD", b"WRQ", b"CXSCV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd4d9a8c-703c-4230-94dc-5e35a4fabf93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBVD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBVD>>(v1);
    }

    // decompiled from Move bytecode v6
}

