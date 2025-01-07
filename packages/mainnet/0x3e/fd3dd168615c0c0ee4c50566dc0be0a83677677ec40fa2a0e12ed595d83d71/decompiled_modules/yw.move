module 0x3efd3dd168615c0c0ee4c50566dc0be0a83677677ec40fa2a0e12ed595d83d71::yw {
    struct YW has drop {
        dummy_field: bool,
    }

    fun init(arg0: YW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YW>(arg0, 9, b"YW", b"Yyuu", b"Qjj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c3d7585-24b7-443f-bab8-d45cab4645f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YW>>(v1);
    }

    // decompiled from Move bytecode v6
}

