module 0x17c20b3294b91d082dc057fd99575bb28092eafc28760c7590984daa576caf96::goof {
    struct GOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOF>(arg0, 6, b"GOOF", b"Captain GOOFY", b"The greatest fisherman of the @suinetwork ocean rdy to $GOOF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Sf_Y01_K6_C_400x400_e8f6d13e32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

