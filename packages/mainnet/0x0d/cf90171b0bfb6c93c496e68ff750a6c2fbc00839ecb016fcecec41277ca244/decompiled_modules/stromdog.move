module 0xdcf90171b0bfb6c93c496e68ff750a6c2fbc00839ecb016fcecec41277ca244::stromdog {
    struct STROMDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: STROMDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STROMDOG>(arg0, 9, untag(b"SSTROMDOG"), untag(b"NStromDog"), untag(b"DStromDog"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreigzop63t6qnerfcu7wqohwectyz76qdutz5l2iogm63gttyfmjwei"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<STROMDOG>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<STROMDOG>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STROMDOG>>(0x2::coin::mint<STROMDOG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

