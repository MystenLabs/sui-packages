module 0x9da480ca60f41d92bf961f1263ef41dabdcfcdf3ff0a2b420af9dba34572a16a::enzo {
    struct ENZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENZO>(arg0, 6, b"ENZO", b"enzo on SUI", b"ENZO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/enzo_9ef67008bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

