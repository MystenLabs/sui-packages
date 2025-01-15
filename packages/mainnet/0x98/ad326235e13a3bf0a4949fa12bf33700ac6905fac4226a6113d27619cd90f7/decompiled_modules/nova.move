module 0x98ad326235e13a3bf0a4949fa12bf33700ac6905fac4226a6113d27619cd90f7::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NOVA>(arg0, 6, b"NOVA", b"Nova AI by SuiAI", b"AI agent that will help you invest and manage your finances! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2148_35bdaf70e3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOVA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

