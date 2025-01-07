module 0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::proposal {
    struct Proposal<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        number: u64,
        accepted_by: address,
        pre_proposal: 0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::pre_proposal::PreProposal,
        reward_pool: 0x1::option::Option<0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::reward_pool::RewardPool<T0>>,
        start_time: u64,
        end_time: u64,
        total_vote_value: u64,
        votes: 0x2::linked_table::LinkedTable<address, 0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::vote::Vote<T1>>,
        reward_coin_type: 0x1::type_name::TypeName,
        vote_coin_type: 0x1::type_name::TypeName,
    }

    public(friend) fun new<T0, T1>(arg0: &0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::config::ProposalConfig, arg1: 0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::pre_proposal::PreProposal, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Proposal<T0, T1> {
        let v0 = if (0x2::coin::value<T0>(&arg2) > 0) {
            0x1::option::some<0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::reward_pool::RewardPool<T0>>(0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::reward_pool::new<T0>(arg2, arg5))
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
            0x1::option::none<0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::reward_pool::RewardPool<T0>>()
        };
        let v1 = Proposal<T0, T1>{
            id               : 0x2::object::new(arg5),
            number           : 0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::config::proposal_index(arg0),
            accepted_by      : 0x2::tx_context::sender(arg5),
            pre_proposal     : arg1,
            reward_pool      : v0,
            start_time       : arg3,
            end_time         : arg4,
            total_vote_value : 0,
            votes            : 0x2::linked_table::new<address, 0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::vote::Vote<T1>>(arg5),
            reward_coin_type : 0x1::type_name::get<T0>(),
            vote_coin_type   : 0x1::type_name::get<T1>(),
        };
        let v2 = 0x2::display::new<Proposal<T0, T1>>(0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::config::publisher(arg0), arg5);
        0x2::display::add<Proposal<T0, T1>>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Sui Generis Proposal: {name}"));
        0x2::display::add<Proposal<T0, T1>>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://dao.suigeneris.auction/proposal?id={id}"));
        0x2::display::add<Proposal<T0, T1>>(&mut v2, 0x1::string::utf8(b"index"), 0x1::string::utf8(b"{number}"));
        0x2::display::update_version<Proposal<T0, T1>>(&mut v2);
        0x2::transfer::public_share_object<0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::display_wrapper::DisplayWrapper<Proposal<T0, T1>>>(0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::display_wrapper::new<Proposal<T0, T1>>(v2, arg5));
        v1
    }

    public fun pre_proposal<T0, T1>(arg0: &Proposal<T0, T1>) : &0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::pre_proposal::PreProposal {
        &arg0.pre_proposal
    }

    public fun accepted_by<T0, T1>(arg0: &Proposal<T0, T1>) : address {
        arg0.accepted_by
    }

    public(friend) fun add_vote_value<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64) {
        arg0.total_vote_value = arg0.total_vote_value + arg1;
    }

    public(friend) fun destroy<T0, T1>(arg0: Proposal<T0, T1>) : (u64, 0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::pre_proposal::PreProposal, address, 0x1::option::Option<0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::reward_pool::RewardPool<T0>>, 0x2::linked_table::LinkedTable<address, 0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::vote::Vote<T1>>, u64) {
        let Proposal {
            id               : v0,
            number           : v1,
            accepted_by      : v2,
            pre_proposal     : v3,
            reward_pool      : v4,
            start_time       : _,
            end_time         : _,
            total_vote_value : v7,
            votes            : v8,
            reward_coin_type : _,
            vote_coin_type   : _,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v3, v2, v4, v8, v7)
    }

    public fun reward_pool<T0, T1>(arg0: &Proposal<T0, T1>) : &0x1::option::Option<0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::reward_pool::RewardPool<T0>> {
        &arg0.reward_pool
    }

    public fun end_time<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.end_time
    }

    public(friend) fun extend_time<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64) {
        arg0.end_time = arg1;
    }

    public(friend) fun mut_pre_proposal<T0, T1>(arg0: &mut Proposal<T0, T1>) : &mut 0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::pre_proposal::PreProposal {
        &mut arg0.pre_proposal
    }

    public(friend) fun mut_reward_pool<T0, T1>(arg0: &mut Proposal<T0, T1>) : &mut 0x1::option::Option<0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::reward_pool::RewardPool<T0>> {
        &mut arg0.reward_pool
    }

    public(friend) fun mut_votes<T0, T1>(arg0: &mut Proposal<T0, T1>) : &mut 0x2::linked_table::LinkedTable<address, 0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::vote::Vote<T1>> {
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

    public fun vote_coin_type<T0, T1>(arg0: &Proposal<T0, T1>) : 0x1::type_name::TypeName {
        arg0.vote_coin_type
    }

    public fun votes<T0, T1>(arg0: &Proposal<T0, T1>) : &0x2::linked_table::LinkedTable<address, 0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::vote::Vote<T1>> {
        &arg0.votes
    }

    // decompiled from Move bytecode v6
}

