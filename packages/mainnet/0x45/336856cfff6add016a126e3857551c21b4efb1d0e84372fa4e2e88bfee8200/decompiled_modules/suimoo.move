module 0x45336856cfff6add016a126e3857551c21b4efb1d0e84372fa4e2e88bfee8200::suimoo {
    struct SUIMOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOO>(arg0, 6, b"SUIMOO", b"Suimoo", b"Missed Sudeng? Don't missed suimo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052122_1df3a606a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

