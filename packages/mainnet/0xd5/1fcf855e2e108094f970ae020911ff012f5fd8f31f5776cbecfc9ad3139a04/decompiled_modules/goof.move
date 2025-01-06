module 0xd51fcf855e2e108094f970ae020911ff012f5fd8f31f5776cbecfc9ad3139a04::goof {
    struct GOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOF>(arg0, 6, b"GOOF", b"Goof", b"The greatest fisherman of the suinetwork. Ocean ready to $GOOF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/df8u_Sk4m_400x400_4a15e09220.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

