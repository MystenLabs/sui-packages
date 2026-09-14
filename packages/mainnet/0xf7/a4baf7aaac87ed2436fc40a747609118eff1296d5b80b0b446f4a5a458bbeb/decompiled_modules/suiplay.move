module 0xf7a4baf7aaac87ed2436fc40a747609118eff1296d5b80b0b446f4a5a458bbeb::suiplay {
    struct SUIPLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUIPLAY>(arg0, 9, untag(b"SSUIPLAY"), untag(b"NSui Play"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreih6dim4fkn52uoj7iik7epnix4f3d45nm7b5ch5vvwvwph4inq3xi"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUIPLAY>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUIPLAY>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPLAY>>(0x2::coin::mint<SUIPLAY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

