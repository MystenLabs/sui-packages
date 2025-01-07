module 0xdc102ae6a74f63c37c15163c8d5f7495df6209d4ca6f7248803b992ff166e230::bbgl {
    struct BBGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBGL>(arg0, 9, b"BBGL", b"BurritoBea", b"A tasty pup-powered coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d1d1b8c-f4ab-4e1d-9959-a34a7f4d2fe3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

