module 0x4ddd057ea71e5d6bc76c0743ae6a7d8e5fafddb759cc8b7cfdd9ee9dd641822::cwu {
    struct CWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CWU>(arg0, 6, b"CWU", b"Crypto Workers Union by SuiAI", b"These people from the future are launching these meme coins next to nothn, now we cant get no gains, .and ohh yea #TheyTookOurJobs!!!!.Join Our Union and help us get our gains back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/s_l1600_43377f7d_89c9_42b9_a03d_e2989bf2af71_97723ad4ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CWU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

