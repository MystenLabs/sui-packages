module 0x89309ce74a7345f45b2887a074263d023c1cdf34fe725eb0dd361cf9f85809ad::sat {
    struct SAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAT>(arg0, 6, b"SAT", b"SUI Addict by SuiAI", b"AI. Rallying cry for SUI addicts everywhere. Bull-posting and harvesting alpha on the superior chain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dddd_88e229798e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

