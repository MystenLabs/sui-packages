module 0x4efae69d15e869d55f93266bf41197dae484d116ea31838a3eb257c15e043d4f::eco {
    struct ECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ECO>(arg0, 6, b"ECO", b"ECO AI by SuiAI", b"EcoAl: Al-driven agents ecosystem creating innovative utilities, generating revenue, and promoting sustainability..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1737244556397_e67041cede.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ECO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

