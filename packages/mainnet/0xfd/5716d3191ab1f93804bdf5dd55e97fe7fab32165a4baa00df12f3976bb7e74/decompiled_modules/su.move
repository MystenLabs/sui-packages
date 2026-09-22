module 0xfd5716d3191ab1f93804bdf5dd55e97fe7fab32165a4baa00df12f3976bb7e74::su {
    struct SU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SU>(arg0, 9, untag(b"SSU"), untag(b"NSuiper inu"), untag(b"Dalready using Suiper inu Intelligence."), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreidvnrcj5o5v2ezfagrhjaygk4eketgr4ph3mnvc6tcxykw4mgfprq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SU>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SU>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SU>>(0x2::coin::mint<SU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

