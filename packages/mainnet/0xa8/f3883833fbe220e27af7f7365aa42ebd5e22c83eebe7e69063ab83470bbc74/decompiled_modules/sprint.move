module 0xa8f3883833fbe220e27af7f7365aa42ebd5e22c83eebe7e69063ab83470bbc74::sprint {
    struct SPRINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SPRINT>(arg0, 9, untag(b"SSPRINT"), untag(b"NStrom Printer"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeihwjrxpkhb5a5lyqcsrvwfmkddnj3cftv3uq3z36ghyeodkybggqe"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SPRINT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SPRINT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SPRINT>>(0x2::coin::mint<SPRINT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

