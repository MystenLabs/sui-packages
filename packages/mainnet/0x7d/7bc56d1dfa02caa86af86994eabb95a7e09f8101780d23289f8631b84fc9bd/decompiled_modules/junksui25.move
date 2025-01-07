module 0x7d7bc56d1dfa02caa86af86994eabb95a7e09f8101780d23289f8631b84fc9bd::junksui25 {
    struct JUNKSUI25 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUNKSUI25, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNKSUI25>(arg0, 6, b"Junksui25", b"JUNK25", b"Junk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_c1d51c9d21.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNKSUI25>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUNKSUI25>>(v1);
    }

    // decompiled from Move bytecode v6
}

