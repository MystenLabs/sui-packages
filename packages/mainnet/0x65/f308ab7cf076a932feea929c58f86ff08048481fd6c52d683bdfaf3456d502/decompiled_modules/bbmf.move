module 0x65f308ab7cf076a932feea929c58f86ff08048481fd6c52d683bdfaf3456d502::bbmf {
    struct BBMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BBMF>(arg0, 9, untag(b"SBBMF"), untag(b"NBillionaireBastard&hisMLNR FRNDS"), untag(x"444920616d2074686520626173746172642062696c6c696f6e61697265200a596f7520617265206d79206d696c6c696f6e6169726520467269656e64732e205468617427732069740a5472757374206d650a427579206d650a486f6c64206d650a416e64207769746e65737320746865206d6167696320f09faa84"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeiducjbhcoccurp5h2xuwguhwvxk2qwvzn2b64iqa4nee2qwfg7r34"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BBMF>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BBMF>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BBMF>>(0x2::coin::mint<BBMF>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

