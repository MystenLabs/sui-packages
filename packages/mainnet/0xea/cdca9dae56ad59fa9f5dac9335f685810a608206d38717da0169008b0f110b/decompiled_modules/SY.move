module 0xeacdca9dae56ad59fa9f5dac9335f685810a608206d38717da0169008b0f110b::SY {
    struct SY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SY>(arg0, 6, 0x1::string::utf8(b"SY-eEARN"), 0x1::string::utf8(b"SY-eEARN"), 0x1::string::utf8(b"SY token for Jitter Ember eEARN."), 0x1::string::utf8(b"https://cdn.bluefin.io/images/eEARN.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SY>>(0x2::coin_registry::finalize<SY>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

