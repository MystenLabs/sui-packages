module 0x1d948fcf44f9cf6982af0a8c002a6201c76665c308825af097a5be6c8ee7a58e::japi {
    struct JAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAPI>(arg0, 6, b"JAPI", b"Japi On Sui", b"Japi is a newborn penguin with aura. Everyone loves being around Japi, not because of is aura tho, hes rich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_08_23_T172605_645_804a08be8f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

