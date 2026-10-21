module 0xed4db887086d84701b455ff63e55e3fc9f75104bf5724a7a39cd2fb67aae3040::dvs_mvhpslxn {
    struct DVS_MVHPSLXN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVHPSLXN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVHPSLXN>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvhpslxn"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVHPSLXN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVHPSLXN>>(0x2::coin_registry::finalize<DVS_MVHPSLXN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

