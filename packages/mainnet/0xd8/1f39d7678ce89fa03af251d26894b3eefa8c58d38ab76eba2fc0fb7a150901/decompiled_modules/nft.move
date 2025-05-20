module 0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::nft {
    struct NFT1 has drop {
        dummy_field: bool,
    }

    struct NFT2 has drop {
        dummy_field: bool,
    }

    struct NFT3 has drop {
        dummy_field: bool,
    }

    struct Public<phantom T0> has store, key {
        id: 0x2::object::UID,
        mint_number: u64,
        creator: address,
        royalty_percentage: u64,
    }

    struct RoyaltyPaid has copy, drop {
        nft_id: address,
        creator: address,
        amount: u64,
    }

    public fun add_field<T0>(arg0: &0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::cap::AdminCap, arg1: &mut 0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::counter::Counter) {
        assert!(0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::package::version() == 0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::counter::version(arg1), 0);
        0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::counter::add_field<T0>(arg1);
    }

    public fun get_royalty_info<T0>(arg0: &Public<T0>) : (address, u64) {
        (arg0.creator, arg0.royalty_percentage)
    }

    public fun mint_and_transfer_public<T0>(arg0: &0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::cap::AdminCap, arg1: &mut 0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::counter::Counter, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::package::version() == 0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::counter::version(arg1), 0);
        assert!(arg3 <= 10000, 1);
        0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::counter::incr_counter<T0>(arg1);
        let v0 = Public<T0>{
            id                 : 0x2::object::new(arg4),
            mint_number        : 0xd81f39d7678ce89fa03af251d26894b3eefa8c58d38ab76eba2fc0fb7a150901::counter::num_minted<T0>(arg1),
            creator            : 0x2::tx_context::sender(arg4),
            royalty_percentage : arg3,
        };
        0x2::transfer::transfer<Public<T0>>(v0, arg2);
    }

    public entry fun sell_nft<T0>(arg0: &Public<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1) * arg0.royalty_percentage / 10000;
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = RoyaltyPaid{
            nft_id  : 0x2::object::id_to_address(&v1),
            creator : arg0.creator,
            amount  : v0,
        };
        0x2::event::emit<RoyaltyPaid>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0, arg3), arg0.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

