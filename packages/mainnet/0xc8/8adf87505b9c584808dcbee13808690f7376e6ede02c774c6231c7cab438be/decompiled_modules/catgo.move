module 0xc88adf87505b9c584808dcbee13808690f7376e6ede02c774c6231c7cab438be::catgo {
    struct CATGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATGO>(arg0, 6, b"CATGO", b"Catgo", b"CATGOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Df2_Qe_Tc_Ai_Em_J5_Dtj_Cugju485ny_ME_9_K69m4tbb852pump_ed0df8eeae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

