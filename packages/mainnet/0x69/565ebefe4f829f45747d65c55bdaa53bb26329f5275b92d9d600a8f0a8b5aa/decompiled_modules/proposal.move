module 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::proposal {
    struct Proposal<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        number: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        accepted_by: address,
        pre_proposal: 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::pre_proposal::PreProposal,
        reward_pool: 0x1::option::Option<0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::reward_pool::RewardPool<T0>>,
        start_time: u64,
        end_time: u64,
        total_vote_value: u64,
        votes: 0x2::linked_table::LinkedTable<address, 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::vote::Vote<T1>>,
        reward_coin_type: 0x1::type_name::TypeName,
        vote_coin_type: 0x1::type_name::TypeName,
    }

    public(friend) fun new<T0, T1>(arg0: &0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::config::ProposalConfig, arg1: 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::pre_proposal::PreProposal, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Proposal<T0, T1> {
        let v0 = if (0x2::coin::value<T0>(&arg2) > 0) {
            0x1::option::some<0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::reward_pool::RewardPool<T0>>(0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::reward_pool::new<T0>(arg2, arg5))
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
            0x1::option::none<0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::reward_pool::RewardPool<T0>>()
        };
        let v1 = Proposal<T0, T1>{
            id               : 0x2::object::new(arg5),
            number           : 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::config::proposal_index(arg0),
            name             : 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::pre_proposal::name(&arg1),
            description      : 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::pre_proposal::description(&arg1),
            accepted_by      : 0x2::tx_context::sender(arg5),
            pre_proposal     : arg1,
            reward_pool      : v0,
            start_time       : arg3,
            end_time         : arg4,
            total_vote_value : 0,
            votes            : 0x2::linked_table::new<address, 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::vote::Vote<T1>>(arg5),
            reward_coin_type : 0x1::type_name::get<T0>(),
            vote_coin_type   : 0x1::type_name::get<T1>(),
        };
        let v2 = 0x2::display::new<Proposal<T0, T1>>(0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::config::publisher(arg0), arg5);
        0x2::display::add<Proposal<T0, T1>>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Sui Generis Proposal | {name}"));
        0x2::display::add<Proposal<T0, T1>>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Proposal<T0, T1>>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://dao.suigeneris.auction/proposal?id={id}"));
        0x2::display::add<Proposal<T0, T1>>(&mut v2, 0x1::string::utf8(b"index"), 0x1::string::utf8(b"{number}"));
        0x2::display::update_version<Proposal<T0, T1>>(&mut v2);
        0x2::transfer::public_share_object<0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::display_wrapper::DisplayWrapper<Proposal<T0, T1>>>(0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::display_wrapper::new<Proposal<T0, T1>>(v2, arg5));
        v1
    }

    public fun pre_proposal<T0, T1>(arg0: &Proposal<T0, T1>) : &0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::pre_proposal::PreProposal {
        &arg0.pre_proposal
    }

    public fun vec_vote_types<T0, T1>(arg0: &Proposal<T0, T1>) : vector<0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::vote_type::VoteTypeClone> {
        0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::pre_proposal::vec_vote_types(pre_proposal<T0, T1>(arg0))
    }

    public fun accepted_by<T0, T1>(arg0: &Proposal<T0, T1>) : address {
        arg0.accepted_by
    }

    public(friend) fun add_vote_value<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64) {
        arg0.total_vote_value = arg0.total_vote_value + arg1;
    }

    public(friend) fun destroy<T0, T1>(arg0: Proposal<T0, T1>) : (u64, 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::pre_proposal::PreProposal, address, 0x1::option::Option<0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::reward_pool::RewardPool<T0>>, 0x2::linked_table::LinkedTable<address, 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::vote::Vote<T1>>, u64, u64) {
        let Proposal {
            id               : v0,
            number           : v1,
            name             : _,
            description      : _,
            accepted_by      : v4,
            pre_proposal     : v5,
            reward_pool      : v6,
            start_time       : v7,
            end_time         : _,
            total_vote_value : v9,
            votes            : v10,
            reward_coin_type : _,
            vote_coin_type   : _,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v5, v4, v6, v10, v9, v7)
    }

    public fun reward_pool<T0, T1>(arg0: &Proposal<T0, T1>) : &0x1::option::Option<0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::reward_pool::RewardPool<T0>> {
        &arg0.reward_pool
    }

    public fun end_time<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.end_time
    }

    public(friend) fun extend_time<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64) {
        arg0.end_time = arg1;
    }

    public(friend) fun mut_pre_proposal<T0, T1>(arg0: &mut Proposal<T0, T1>) : &mut 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::pre_proposal::PreProposal {
        &mut arg0.pre_proposal
    }

    public(friend) fun mut_reward_pool<T0, T1>(arg0: &mut Proposal<T0, T1>) : &mut 0x1::option::Option<0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::reward_pool::RewardPool<T0>> {
        &mut arg0.reward_pool
    }

    public(friend) fun mut_votes<T0, T1>(arg0: &mut Proposal<T0, T1>) : &mut 0x2::linked_table::LinkedTable<address, 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::vote::Vote<T1>> {
        &mut arg0.votes
    }

    public fun reward_coin_type<T0, T1>(arg0: &Proposal<T0, T1>) : 0x1::type_name::TypeName {
        arg0.reward_coin_type
    }

    public fun start_time<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.start_time
    }

    public fun total_vote_value<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.total_vote_value
    }

    public fun vec_vote_ids<T0, T1>(arg0: &Proposal<T0, T1>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x2::linked_table::back<address, 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::vote::Vote<T1>>(&arg0.votes);
        while (0x1::option::is_some<address>(v1)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::vote::Vote<T1>>(0x2::linked_table::borrow<address, 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::vote::Vote<T1>>(&arg0.votes, *0x1::option::borrow<address>(v1))));
            let v2 = *0x1::option::borrow<address>(v1);
            v1 = 0x2::linked_table::prev<address, 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::vote::Vote<T1>>(&arg0.votes, v2);
        };
        v0
    }

    public fun vote_coin_type<T0, T1>(arg0: &Proposal<T0, T1>) : 0x1::type_name::TypeName {
        arg0.vote_coin_type
    }

    public fun votes<T0, T1>(arg0: &Proposal<T0, T1>) : &0x2::linked_table::LinkedTable<address, 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::vote::Vote<T1>> {
        &arg0.votes
    }

    // decompiled from Move bytecode v6
}

