module 0xe16e6b7e9b3fc7effa1ede536b18cd9f8d67cc1946ae299bab13bfbb055d8698::rocko {
    struct ROCKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKO>(arg0, 6, b"ROCKO", b"Rocko", b"$ROCKO is the ultimate champion with relentless determination. Our underdog community, fueled by the gaming world, will never stop fighting until we hit 1000x.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1723531094876_423f56bdfc1478c616052579ac14dd4b_eddbcabeae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

