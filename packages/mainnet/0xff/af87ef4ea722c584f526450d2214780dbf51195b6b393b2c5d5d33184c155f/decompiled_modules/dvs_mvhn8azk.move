module 0xffaf87ef4ea722c584f526450d2214780dbf51195b6b393b2c5d5d33184c155f::dvs_mvhn8azk {
    struct DVS_MVHN8AZK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVHN8AZK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVHN8AZK>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvhn8azk"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVHN8AZK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVHN8AZK>>(0x2::coin_registry::finalize<DVS_MVHN8AZK>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

