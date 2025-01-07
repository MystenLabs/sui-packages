module 0x481d087d17de4edab36fe1b3be0f36dbf54f10753a6bac80632e736ca763d42::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 6, b"PUMP", b"President PUMP", b"$PUMP $PUMP $PUMP $PUMP $PUMP $PUMP $PUMP $PUMP $PUMP $PUMP $PUMP $PUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NEW_BUY_1_9e78ed6a52.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

