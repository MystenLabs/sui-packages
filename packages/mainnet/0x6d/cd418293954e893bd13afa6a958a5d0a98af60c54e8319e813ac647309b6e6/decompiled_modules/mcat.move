module 0x6dcd418293954e893bd13afa6a958a5d0a98af60c54e8319e813ac647309b6e6::mcat {
    struct MCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MCAT>(arg0, 9, untag(b"SMCAT"), untag(b"NMaelstro Cat"), untag(b"DBorn in the Maelstrom. Built on Sui. Maelstro Cat ($MCAT) is the fearless cat riding the waves of chaos with nine lives, big memes and an even bigger community. No complicated story, just cats, waves, memes and the ride. Welcome to $MCAT."), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeibbflnaryajfgkteb3slfp2erbj2wiqzmtciu5vgeu257l3d72znm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MCAT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MCAT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MCAT>>(0x2::coin::mint<MCAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

