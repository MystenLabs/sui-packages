module 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::voting {
    struct VotingTreasury<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        nft_number: u16,
        nft_object_id: 0x2::object::ID,
        stakers: 0x2::table::Table<address, 0x2::balance::Balance<T0>>,
    }

    struct NFTVoted has copy, drop {
        nft_object_id: 0x2::object::ID,
        nft_number: u16,
        voter: address,
        amount: u64,
    }

    struct NFTVoteWithdrawn has copy, drop {
        nft_object_id: 0x2::object::ID,
        nft_number: u16,
        voter: address,
        amount: u64,
    }

    public(friend) fun create_treasury<T0: drop>(arg0: u16, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : VotingTreasury<T0> {
        VotingTreasury<T0>{
            id            : 0x2::object::new(arg2),
            nft_number    : arg0,
            nft_object_id : arg1,
            stakers       : 0x2::table::new<address, 0x2::balance::Balance<T0>>(arg2),
        }
    }

    public fun vote<T0: drop>(arg0: &mut VotingTreasury<T0>, arg1: &0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::OptionsStorage, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::assert_is_zen_coin<T0>();
        0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::assert_is_voting_enabled(arg1);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        let v2 = 0x2::balance::value<T0>(&v1);
        assert!(v2 > 0, 1);
        if (0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.stakers, v0)) {
            0x2::balance::join<T0>(0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.stakers, v0), v1);
        } else {
            0x2::table::add<address, 0x2::balance::Balance<T0>>(&mut arg0.stakers, v0, v1);
        };
        let v3 = NFTVoted{
            nft_object_id : arg0.nft_object_id,
            nft_number    : arg0.nft_number,
            voter         : v0,
            amount        : v2,
        };
        0x2::event::emit<NFTVoted>(v3);
    }

    public fun withdraw_vote<T0: drop>(arg0: &mut VotingTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.stakers, v0), 2);
        let v1 = 0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.stakers, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2), v0);
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::table::remove<address, 0x2::balance::Balance<T0>>(&mut arg0.stakers, v0));
        };
        let v2 = NFTVoteWithdrawn{
            nft_object_id : arg0.nft_object_id,
            nft_number    : arg0.nft_number,
            voter         : v0,
            amount        : arg1,
        };
        0x2::event::emit<NFTVoteWithdrawn>(v2);
    }

    // decompiled from Move bytecode v6
}

