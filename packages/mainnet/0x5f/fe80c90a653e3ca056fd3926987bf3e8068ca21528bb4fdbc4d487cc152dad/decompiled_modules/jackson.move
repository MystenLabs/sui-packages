module 0x5ffe80c90a653e3ca056fd3926987bf3e8068ca21528bb4fdbc4d487cc152dad::jackson {
    struct JACKSON has key {
        id: 0x2::object::UID,
    }

    public fun new_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JACKSON> {
        let (v0, v1) = 0x2::coin_registry::new_currency<JACKSON>(arg0, 8, 0x1::string::utf8(b"JACKSON"), 0x1::string::utf8(b"JACKSON"), 0x1::string::utf8(b"The native utility token of Jackson.io GameFi Protocol"), 0x1::string::utf8(b"https://ipfs.io/ipfs/bafkreicn2t2ryh7f2nbpior3v6v6isr2c35ejzz2figro7wupimcxnr3aq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<JACKSON>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<JACKSON>>(0x2::coin_registry::finalize<JACKSON>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::coin::mint<JACKSON>(&mut v2, 999999999900000000, arg1)
    }

    // decompiled from Move bytecode v6
}

