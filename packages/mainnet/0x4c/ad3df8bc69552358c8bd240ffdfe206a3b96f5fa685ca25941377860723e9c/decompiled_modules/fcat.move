module 0x4cad3df8bc69552358c8bd240ffdfe206a3b96f5fa685ca25941377860723e9c::fcat {
    struct FCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCAT>(arg0, 6, b"FCAT", b"FxckCat", b"Fxck it,Fxck it,Fxck it,Fxck it,Fxck it,Fxck it,Fxck it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_G4_RFU_5q_400x400_d91edf5acc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

