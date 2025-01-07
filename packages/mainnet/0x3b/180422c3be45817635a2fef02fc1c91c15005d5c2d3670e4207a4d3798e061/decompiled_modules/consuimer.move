module 0x3b180422c3be45817635a2fef02fc1c91c15005d5c2d3670e4207a4d3798e061::consuimer {
    struct CONSUIMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONSUIMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONSUIMER>(arg0, 6, b"Consuimer", b"consuimer", b"Consuimer: the guy who eats, sleeps, and breathes Sui. Consuimer's motto: \"In Sui we trust, everything else is dust!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032552_d3fac9ede9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONSUIMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CONSUIMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

