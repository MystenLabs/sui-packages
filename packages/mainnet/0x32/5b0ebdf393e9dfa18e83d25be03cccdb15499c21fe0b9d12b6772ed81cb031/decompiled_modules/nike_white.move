module 0x325b0ebdf393e9dfa18e83d25be03cccdb15499c21fe0b9d12b6772ed81cb031::nike_white {
    struct NIKE_WHITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKE_WHITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKE_WHITE>(arg0, 9, b"NIKE_WHITE", b"white nike", b"Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5bbb0694-0bfd-41ed-9fce-a9a4562ab336.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKE_WHITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIKE_WHITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

