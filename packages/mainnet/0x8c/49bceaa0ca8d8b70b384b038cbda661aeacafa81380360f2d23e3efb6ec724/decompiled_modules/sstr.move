module 0x8c49bceaa0ca8d8b70b384b038cbda661aeacafa81380360f2d23e3efb6ec724::sstr {
    struct SSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SSTR>(arg0, 9, untag(b"SSSTR"), untag(b"NStrom Strategy"), untag(b"DBuying Strom from the market with fees and selling with 20% profit, which goes to buyback and burn of $SSTR."), untag(b"I"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SSTR>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SSTR>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SSTR>>(0x2::coin::mint<SSTR>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

