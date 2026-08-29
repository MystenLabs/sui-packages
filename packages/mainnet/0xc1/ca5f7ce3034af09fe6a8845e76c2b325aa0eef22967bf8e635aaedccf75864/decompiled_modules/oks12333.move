module 0xc1ca5f7ce3034af09fe6a8845e76c2b325aa0eef22967bf8e635aaedccf75864::oks12333 {
    struct OKS12333 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKS12333, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<OKS12333>(arg0, 9, 0x1::string::utf8(b"OKS12333"), 0x1::string::utf8(b"OKS12333"), 0x1::string::utf8(b"11"), 0x1::string::utf8(b"https://gateway.irys.xyz/aQ-Kk_FwvVfiH4JegGZAmf7FA97t87lZ7NrE4dJFJ4Q"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OKS12333>>(0x2::coin::mint<OKS12333>(&mut v2, 1000000000, arg1), @0xee8ade9c3ae68177288a1247b56d41f66488045dabcdcd13e8ddbc7da34be99d);
        0x2::coin_registry::make_supply_fixed_init<OKS12333>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<OKS12333>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

