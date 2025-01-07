module 0x534b5b7479174d01d1546107d9c69480026f4448e44f2d432e069b251198ba75::xgala {
    struct XGALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XGALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XGALA>(arg0, 9, b"XGALA", b"GALAx", b"GALAXI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c3de3b5-435e-4053-ab5f-553511f35659.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XGALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XGALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

