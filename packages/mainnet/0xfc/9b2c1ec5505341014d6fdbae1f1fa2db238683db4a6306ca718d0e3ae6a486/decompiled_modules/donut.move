module 0xfc9b2c1ec5505341014d6fdbae1f1fa2db238683db4a6306ca718d0e3ae6a486::donut {
    struct DONUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONUT>(arg0, 6, b"DONUT", b"Sui Donut", b"Meet with the Sui $DONUT. The ultimate bite sized treat on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bonut_4520ee7dbc.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

