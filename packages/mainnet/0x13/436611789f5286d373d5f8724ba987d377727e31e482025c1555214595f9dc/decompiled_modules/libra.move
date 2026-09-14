module 0x13436611789f5286d373d5f8724ba987d377727e31e482025c1555214595f9dc::libra {
    struct LIBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LIBRA>(arg0, 9, untag(b"SLIBRA"), untag(b"NSui Original Name"), untag(x"44546865206e616d6520225375692220636f6d65732066726f6d20746865204a6170616e65736520776f726420666f722077617465722028e6b0b4292c2063686f73656e206265636175736520746865206e6574776f726b2773206172636869746563747572652069732064657369676e656420746f20626520666c7569642c20616461707461626c652c20616e6420666173742e"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreigf7goamgshivdjqsqxoicvtabkfgstdkpy7ckktj52axn3ijuckm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<LIBRA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<LIBRA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LIBRA>>(0x2::coin::mint<LIBRA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

