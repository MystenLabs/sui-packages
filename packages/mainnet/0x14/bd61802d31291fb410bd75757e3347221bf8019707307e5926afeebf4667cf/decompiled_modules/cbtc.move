module 0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc {
    struct CBTC has key {
        id: 0x2::object::UID,
    }

    public fun new_cbtc(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CBTC> {
        let (v0, v1) = 0x2::coin_registry::new_currency<CBTC>(arg0, 9, 0x1::string::utf8(b"CBTC"), 0x1::string::utf8(b"CBTC"), 0x1::string::utf8(b" CBTC is capy_node reward token"), 0x1::string::utf8(b"https://example.com/cbtc.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<CBTC>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CBTC>>(0x2::coin_registry::finalize<CBTC>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::coin::mint<CBTC>(&mut v2, 21000000000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

