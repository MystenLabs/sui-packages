module 0x2cdf9e59468cb7ed5832180eb52989fad74ef083c8eea01c18e7062b2c85f634::suini {
    struct SUINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINI>(arg0, 6, b"SUINI", b"Sydney SUINI", b"A tribute to acclaimed actress and crypto supporter Sydney Sweeney.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/maxresdefault_94c8252bc6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

