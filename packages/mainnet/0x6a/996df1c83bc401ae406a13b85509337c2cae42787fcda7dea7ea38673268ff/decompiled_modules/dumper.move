module 0x6a996df1c83bc401ae406a13b85509337c2cae42787fcda7dea7ea38673268ff::dumper {
    struct DUMPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMPER>(arg0, 6, b"DUMPER", b"$DUMPER", b"Dumper - is the cat that loves money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/28827_45003904b6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

