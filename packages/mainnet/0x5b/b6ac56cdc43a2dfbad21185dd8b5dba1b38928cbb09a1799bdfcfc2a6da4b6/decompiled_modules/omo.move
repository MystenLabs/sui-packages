module 0x5bb6ac56cdc43a2dfbad21185dd8b5dba1b38928cbb09a1799bdfcfc2a6da4b6::omo {
    struct OMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMO>(arg0, 6, b"OMO", b"Suimo Water", b"Ready for the mighty $SUIMO? The heavier he gets, the more force a jeet needs to exert to get us down back to the trenches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040046_6796767962.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

