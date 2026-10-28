module 0x87b75c0b522029575370fa4fba05582620b0d3a4782a3898081d493fbc421471::dvs_mvs5jk5y {
    struct DVS_MVS5JK5Y has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVS5JK5Y, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVS5JK5Y>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvs5jk5y"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVS5JK5Y>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVS5JK5Y>>(0x2::coin_registry::finalize<DVS_MVS5JK5Y>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

