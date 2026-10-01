module 0xb2439e5182f10066a1d75f01d5081ff347e89bcb1f56a81354c22bbea27613bd::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PUMP>(arg0, 9, untag(b"SPUMP"), untag(b"NPump.fun"), untag(b"D||{\"twitter\":\"https://x.com/pumpdotfun\",\"website\":\"https://pump.fun/board\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreidvmbtvn2xfwcdhkaq64o4dn42sfddjmx6c4gnndvdvchd5qcai3i"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<PUMP>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PUMP>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMP>>(0x2::coin::mint<PUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

