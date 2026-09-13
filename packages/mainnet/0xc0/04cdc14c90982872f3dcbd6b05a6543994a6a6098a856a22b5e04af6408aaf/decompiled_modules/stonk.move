module 0xc004cdc14c90982872f3dcbd6b05a6543994a6a6098a856a22b5e04af6408aaf::stonk {
    struct STONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STONK>(arg0, 9, untag(b"SSTONK"), untag(b"NSuiStonk"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreiel6b6rzbzte2gx6fftm3tixhpkxuf3qzl5x5hrixtr7tq2cfrizy"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<STONK>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<STONK>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STONK>>(0x2::coin::mint<STONK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

