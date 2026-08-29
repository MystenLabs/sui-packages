module 0xb93b65e0b0c29fe137cd442adc2eaadbf737f9ab13a79d0e89ec7b99ac2775de::phan {
    struct PHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PHAN>(arg0, 9, 0x1::string::utf8(b"PHAN"), 0x1::string::utf8(b"phan"), 0x1::string::utf8(b"phan"), 0x1::string::utf8(b"https://gateway.irys.xyz/Kg-pZJpUfIFafxQo41AZO7RQEbAS7bHDDgpQH8hl6ek"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PHAN>>(0x2::coin::mint<PHAN>(&mut v2, 1000000000, arg1), @0x5da78138ab1b3ede93626a2563f88cca6bbb1bf42c5156979a55170f66e74799);
        0x2::coin_registry::make_supply_fixed_init<PHAN>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PHAN>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

