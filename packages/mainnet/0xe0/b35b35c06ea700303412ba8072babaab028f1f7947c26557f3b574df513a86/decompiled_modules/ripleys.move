module 0xe0b35b35c06ea700303412ba8072babaab028f1f7947c26557f3b574df513a86::ripleys {
    struct RIPLEYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIPLEYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIPLEYS>(arg0, 9, b"rSui", b"rSui", b"rSui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIPLEYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPLEYS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

