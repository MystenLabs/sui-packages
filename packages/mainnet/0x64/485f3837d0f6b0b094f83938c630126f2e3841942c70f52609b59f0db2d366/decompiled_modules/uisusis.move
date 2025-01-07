module 0x64485f3837d0f6b0b094f83938c630126f2e3841942c70f52609b59f0db2d366::uisusis {
    struct UISUSIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UISUSIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UISUSIS>(arg0, 9, b"UISUSIS", b"Zjhsjsj", b"7Suausjsja", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a17613e4-196c-45b7-900f-15b478c27336.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UISUSIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UISUSIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

