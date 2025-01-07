module 0x6dbe463f29e85cce3b310cc2c4cad7b6338051fbe95f580805165dbe9e855f3c::wawawa {
    struct WAWAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWAWA>(arg0, 9, b"WAWAWA", b"Superwawa", b"Top1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/954462bf-0065-4d04-9526-f233c9486a4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

