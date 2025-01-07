module 0x549c94eb816f284323dd6f8bb87c7ff9fe780eb2bcc097bf9c234d1cb899ddcd::suiper {
    struct SUIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPER>(arg0, 6, b"Suiper", b"Suiperman", b"Our mission? To make $SUIPER a project that rewards YOU.  Gains are coming, stay with us for the ride!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_R24_RD_Wc_A_Aa1u_V_0cb05cc213.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

