module 0x7e2cdf3a0e52cba48dc3f59a537781645fb9c028440ed11195e05ea52c652804::sanon {
    struct SANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANON>(arg0, 6, b"Sanon", b"Anon Man", b"secret and mysterious", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ervrbrbrbr_5defb16a9b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANON>>(v1);
    }

    // decompiled from Move bytecode v6
}

