module 0xe1ad04d005a73ca3d3622ca69c07cf09845c090d7a06d0d3fbd7a60d9a156f7::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 9, b"WUKONG", b"SuiWuKong", b"Sun Wo Kong ($ SunWuKong ) is a next-generation SUI compatible MEME blockchain and ecosystem that runs on the support and love of the community. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2945b47-f918-49b7-b918-2a0139d00cb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

