module 0xcaf4601efc9e858ed49c400c294e2f3313f332002da386751853ca4a40e0e0e3::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SHARK>(arg0, 9, untag(b"SSHARK"), untag(b"NShark"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreig2c5dqrpmhzp2hdjhdcxzuqobjzka77h2sciqrdur4guynqfry3u"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SHARK>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SHARK>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHARK>>(0x2::coin::mint<SHARK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

