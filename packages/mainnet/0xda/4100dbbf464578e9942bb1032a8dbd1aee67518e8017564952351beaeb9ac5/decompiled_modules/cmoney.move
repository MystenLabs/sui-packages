module 0xda4100dbbf464578e9942bb1032a8dbd1aee67518e8017564952351beaeb9ac5::cmoney {
    struct CMONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMONEY>(arg0, 6, b"Cmoney", b"Calling Money", b"Calling Money.  x: https://x.com/mrpunkdoteth/status/1845896466826457177", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GVT_Vnz_JW_0_A_Enk_Ub_b45567c260.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CMONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

