module 0xd0c3a32f14122acd0722bca55dd98276d64b2dcdcfc97d32c9774a1c79fbd8f2::stromdog {
    struct STROMDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: STROMDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STROMDOG>(arg0, 9, untag(b"SSTROMDOG"), untag(b"NStromdog"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeic3372olnfom5galddoma7e6q7yeoitwlvogr3xo75dfy23qty2ku"), arg1);
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

