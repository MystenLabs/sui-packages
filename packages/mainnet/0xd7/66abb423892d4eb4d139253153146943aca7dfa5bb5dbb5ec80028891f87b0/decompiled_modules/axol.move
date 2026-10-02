module 0xd766abb423892d4eb4d139253153146943aca7dfa5bb5dbb5ec80028891f87b0::axol {
    struct AXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AXOL>(arg0, 9, untag(b"SAXOL"), untag(b"NAXOLcoin"), untag(b"D||{\"twitter\":\"https://x.com/AxolOnSui\",\"website\":\"https://www.axolcoin.xyz/\",\"telegram\":\"https://t.me/AxolSUI\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiewg4z2cspytxi6hzicf2xfp7agd2cakpywkbymy5r54dhd6fka74"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<AXOL>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<AXOL>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AXOL>>(0x2::coin::mint<AXOL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

