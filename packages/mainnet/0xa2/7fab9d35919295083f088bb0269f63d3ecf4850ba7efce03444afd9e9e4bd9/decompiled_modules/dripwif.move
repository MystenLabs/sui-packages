module 0xa27fab9d35919295083f088bb0269f63d3ecf4850ba7efce03444afd9e9e4bd9::dripwif {
    struct DRIPWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIPWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIPWIF>(arg0, 6, b"DRIPWIF", b"DripWifHat", b"DRIP DRIP DRIP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6583_41754cac35.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIPWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRIPWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

