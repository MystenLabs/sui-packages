module 0x34a5be3c2e37dbaa3018ac49390d9d98754a539d42ba4c7787074af1d6d40f6::dcake {
    struct DCAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DCAKE>(arg0, 9, untag(b"SDCAKE"), untag(b"NDoge Cake"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeicwx2wjivjy4six2nuwiij7ohv4jour75kanppzifz75aulv2bg6q"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<DCAKE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<DCAKE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DCAKE>>(0x2::coin::mint<DCAKE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

