module 0xc46bb74148f6950ff050182bf2e892ebedce7a0fe5e68b8ae5996041d72ff932::dedpes {
    struct DEDPES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEDPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEDPES>(arg0, 6, b"DEDPES", b"PESS DED PAMPP", b"DED PESSSUN PAMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_be77882c23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEDPES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEDPES>>(v1);
    }

    // decompiled from Move bytecode v6
}

