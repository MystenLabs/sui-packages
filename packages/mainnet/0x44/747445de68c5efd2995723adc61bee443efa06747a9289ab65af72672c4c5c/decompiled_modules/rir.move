module 0x44747445de68c5efd2995723adc61bee443efa06747a9289ab65af72672c4c5c::rir {
    struct RIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RIR>(arg0, 2, 0x1::string::utf8(b"RIR"), 0x1::string::utf8(b"richandrich"), 0x1::string::utf8(b"richandrich"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<RIR>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<RIR>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<RIR>>(0x2::coin::mint<RIR>(&mut v2, 10000000000000, arg1), @0xba77905719718062a60abaa020d0d5ab2a9fae2df8e3335e758dda6781770ed7);
    }

    // decompiled from Move bytecode v7
}

