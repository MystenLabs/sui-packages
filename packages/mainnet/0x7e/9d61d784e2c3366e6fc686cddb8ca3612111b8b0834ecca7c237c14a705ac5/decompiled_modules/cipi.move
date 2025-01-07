module 0x7e9d61d784e2c3366e6fc686cddb8ca3612111b8b0834ecca7c237c14a705ac5::cipi {
    struct CIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIPI>(arg0, 6, b"CIPI", b"CIPI CAPA", x"434950492043495049204341504120434150412044554249445542494455203a0a534f4349414c5320555044415445204f4e20444558", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cup_f4b505f0c8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

