module 0x78fc3404559783dd1a297df8583d0cc1f6672b8cec2ea951a15f23372290350::wawawa {
    struct WAWAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWAWA>(arg0, 9, b"WAWAWA", b"Superwawa", b"Top1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d26c88d0-0888-4734-82d1-2d1d8855f578.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

