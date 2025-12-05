module 0xd6f636262da0e5c74750b39a10e6521cefcb8f7cbcfcf1d87af00a787371e00a::CHMMND {
    struct CHMMND has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHMMND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHMMND>(arg0, 9, 0x1::string::utf8(b"CHMMND"), 0x1::string::utf8(b"chammmanda"), 0x1::string::utf8(b"The ultimate chammmanda token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHMMND>>(0x2::coin_registry::finalize<CHMMND>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHMMND>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMMND>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMMND>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

