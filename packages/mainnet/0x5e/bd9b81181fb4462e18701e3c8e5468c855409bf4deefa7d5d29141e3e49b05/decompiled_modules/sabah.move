module 0x5ebd9b81181fb4462e18701e3c8e5468c855409bf4deefa7d5d29141e3e49b05::sabah {
    struct SABAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SABAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SABAH>(arg0, 9, 0x1::string::utf8(b"SABAH"), 0x1::string::utf8(b"SABAH"), 0x1::string::utf8(b"1"), 0x1::string::utf8(b"https://gateway.irys.xyz/-7WcyeCb0_wN4iBVgsbh0dwJzbYoPwRACukJwYnHSxA"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SABAH>>(0x2::coin::mint<SABAH>(&mut v2, 1000000000, arg1), @0x5da78138ab1b3ede93626a2563f88cca6bbb1bf42c5156979a55170f66e74799);
        0x2::coin_registry::make_supply_fixed_init<SABAH>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SABAH>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

