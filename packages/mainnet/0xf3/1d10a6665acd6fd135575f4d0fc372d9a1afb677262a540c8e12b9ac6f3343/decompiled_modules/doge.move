module 0xf31d10a6665acd6fd135575f4d0fc372d9a1afb677262a540c8e12b9ac6f3343::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DOGE>(arg0, 9, untag(b"SDOGE"), untag(b"NDoge"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreiaewgmkl65gsvhrsjmrrxh5t4fdzsvzyokfaxpiqnl3uwzhwjeeo4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<DOGE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<DOGE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGE>>(0x2::coin::mint<DOGE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

