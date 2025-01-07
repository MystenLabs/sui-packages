module 0x6351631f31c0c01947a8fe4cff5b39e9128029a90dfca8514c3b62831fa8dd30::xgala {
    struct XGALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XGALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XGALA>(arg0, 9, b"XGALA", b"GALAx", b"GALAXI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c23231f6-d094-4c65-9782-aeafe1ba40a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XGALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XGALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

