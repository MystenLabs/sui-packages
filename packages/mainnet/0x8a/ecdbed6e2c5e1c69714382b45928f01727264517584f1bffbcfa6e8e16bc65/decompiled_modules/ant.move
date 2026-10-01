module 0x8aecdbed6e2c5e1c69714382b45928f01727264517584f1bffbcfa6e8e16bc65::ant {
    struct ANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ANT>(arg0, 9, untag(b"SANT"), untag(b"NAntMiner"), untag(b"D||{\"twitter\":\"https://x.com/The_ant_miner\",\"website\":\"https://theantminer.xyz/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreicekiuaberdl6mouuqiaeagx7c2pe552aydpnps3a4h5umnxydoz4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ANT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ANT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ANT>>(0x2::coin::mint<ANT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

