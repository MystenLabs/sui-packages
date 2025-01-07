module 0x6033d8382c40e08225fa1f28b901c841613b8ada0362fa05e000b8d3f3caeac3::tot {
    struct TOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOT>(arg0, 6, b"TOT", b"Trick Or Treat", b"Happy Halloweeen On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000097280_6c2004b1ed.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

