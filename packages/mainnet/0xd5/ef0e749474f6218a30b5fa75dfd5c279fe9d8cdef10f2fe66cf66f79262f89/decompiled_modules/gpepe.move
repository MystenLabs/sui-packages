module 0xd5ef0e749474f6218a30b5fa75dfd5c279fe9d8cdef10f2fe66cf66f79262f89::gpepe {
    struct GPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GPEPE>(arg0, 6, b"GPEPE", b"GiUSEPEPE by SuiAI", b"Meet Giusepepe, the raging italian fatfrog, that hates tourists eating Pizza wiffe ketchup, hates tourists who drink cappuccino after 12pm and in fact hates every cazzo tourist. When he once is not raging, he might be chilling on his 76 foot Riva yacht with some Pepinas in Bikinis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ghhzd_Sq_XMAA_5i3_T_5b1cd09cc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GPEPE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPEPE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

