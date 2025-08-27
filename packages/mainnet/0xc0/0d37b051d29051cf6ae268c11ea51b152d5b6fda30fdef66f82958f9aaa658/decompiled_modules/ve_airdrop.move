module 0xc00d37b051d29051cf6ae268c11ea51b152d5b6fda30fdef66f82958f9aaa658::ve_airdrop {
    struct EventVeAirdropCreated has copy, drop, store {
        airdrop_id: 0x2::object::ID,
        amount: u64,
        root: vector<u8>,
        start: u64,
    }

    struct EventVeAirdropClaimed has copy, drop, store {
        airdrop_id: 0x2::object::ID,
        amount: u64,
        user: address,
    }

    struct VeAirdrop<phantom T0> has store, key {
        id: 0x2::object::UID,
        airdrop: 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::airdrop::Airdrop<T0>,
    }

    public fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : VeAirdrop<T0> {
        let v0 = 0x2::object::new(arg4);
        let v1 = EventVeAirdropCreated{
            airdrop_id : 0x2::object::uid_to_inner(&v0),
            amount     : 0x2::coin::value<T0>(&arg0),
            root       : arg1,
            start      : arg2,
        };
        0x2::event::emit<EventVeAirdropCreated>(v1);
        VeAirdrop<T0>{
            id      : v0,
            airdrop : 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::airdrop::new<T0>(arg0, arg1, arg2, arg3, arg4),
        }
    }

    public fun balance<T0>(arg0: &VeAirdrop<T0>) : u64 {
        0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::airdrop::balance<T0>(&arg0.airdrop)
    }

    public fun borrow_map<T0>(arg0: &VeAirdrop<T0>) : &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::bitmap::Bitmap {
        0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::airdrop::borrow_map<T0>(&arg0.airdrop)
    }

    public fun get_airdrop<T0>(arg0: &mut VeAirdrop<T0>, arg1: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg2: vector<vector<u8>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = EventVeAirdropClaimed{
            airdrop_id : 0x2::object::id<VeAirdrop<T0>>(arg0),
            amount     : arg3,
            user       : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<EventVeAirdropClaimed>(v0);
        0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::create_lock<T0>(arg1, 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::airdrop::get_airdrop<T0>(&mut arg0.airdrop, arg2, arg4, arg3, arg5), 1456, true, arg4, arg5);
    }

    public fun has_account_claimed<T0>(arg0: &VeAirdrop<T0>, arg1: vector<vector<u8>>, arg2: u64, arg3: address) : bool {
        0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::airdrop::has_account_claimed<T0>(&arg0.airdrop, arg1, arg2, arg3)
    }

    public fun root<T0>(arg0: &VeAirdrop<T0>) : vector<u8> {
        0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::airdrop::root<T0>(&arg0.airdrop)
    }

    public fun start<T0>(arg0: &VeAirdrop<T0>) : u64 {
        0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::airdrop::start<T0>(&arg0.airdrop)
    }

    // decompiled from Move bytecode v6
}

