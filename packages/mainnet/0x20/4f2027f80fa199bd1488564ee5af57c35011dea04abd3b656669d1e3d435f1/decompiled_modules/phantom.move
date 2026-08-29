module 0x204f2027f80fa199bd1488564ee5af57c35011dea04abd3b656669d1e3d435f1::phantom {
    struct PHANTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHANTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PHANTOM>(arg0, 9, 0x1::string::utf8(b"PHANTOM"), 0x1::string::utf8(b"PHANTOM"), 0x1::string::utf8(b"PHANTOM"), 0x1::string::utf8(b"https://gateway.irys.xyz/KPM1bkb2WmfHo0YpO0SWt17b-d4okgHB2Srpg9zgoZA"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PHANTOM>>(0x2::coin::mint<PHANTOM>(&mut v2, 1000000000, arg1), @0x5da78138ab1b3ede93626a2563f88cca6bbb1bf42c5156979a55170f66e74799);
        0x2::coin_registry::make_supply_fixed_init<PHANTOM>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PHANTOM>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

