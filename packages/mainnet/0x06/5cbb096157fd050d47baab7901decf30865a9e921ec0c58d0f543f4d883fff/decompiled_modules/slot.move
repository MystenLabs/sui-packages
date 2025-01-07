module 0x65cbb096157fd050d47baab7901decf30865a9e921ec0c58d0f543f4d883fff::slot {
    struct SLOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SLOT>(arg0, 6, b"SLOT", b"Suilot  by SuiAI", b"The Intelligence Copilot for Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suilot_logo_1ba8ae6f5b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

