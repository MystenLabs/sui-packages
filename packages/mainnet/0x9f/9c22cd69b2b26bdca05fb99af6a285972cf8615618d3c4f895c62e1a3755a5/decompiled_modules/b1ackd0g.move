module 0x9f9c22cd69b2b26bdca05fb99af6a285972cf8615618d3c4f895c62e1a3755a5::b1ackd0g {
    struct B1ACKD0G has drop {
        dummy_field: bool,
    }

    fun init(arg0: B1ACKD0G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<B1ACKD0G>(arg0, 9, untag(b"SB1ACKD0G"), untag(b"Nb1ackd0g"), untag(b"Di made move language thats why you are here right now . degen u fools . woof woof!"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreib7zlkzkxngpijxrnbx7eny2lbhnhoaojhpmrjwqs5xd74dswruha"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<B1ACKD0G>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<B1ACKD0G>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<B1ACKD0G>>(0x2::coin::mint<B1ACKD0G>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

