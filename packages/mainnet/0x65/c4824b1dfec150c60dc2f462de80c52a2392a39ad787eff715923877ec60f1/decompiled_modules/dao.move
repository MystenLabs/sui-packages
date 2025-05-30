module 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::dao {
    struct DAO has drop {
        dummy_field: bool,
    }

    struct PreProposalCreated has copy, drop {
        pre_proposal_id: 0x2::object::ID,
        proposer: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct PreProposalRejected has copy, drop {
        rejected_by: address,
        pre_proposal_id: 0x2::object::ID,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: 0x2::object::ID,
        accepted_by: address,
        pre_proposal_id: 0x2::object::ID,
    }

    struct ProposalCompleted has copy, drop {
        proposal_id: 0x2::object::ID,
        completed_proposal_id: 0x2::object::ID,
    }

    public entry fun approve_pre_proposal<T0, T1>(arg0: &0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::dao_admin::DaoAdmin, arg1: &mut 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::config::ProposalConfig, arg2: &mut 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::ProposalRegistry, arg3: 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::remove_pre_proposal(arg2, 0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(&arg3));
        let v0 = 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::new<T0, T1>(arg1, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::destruct_and_new(arg3, arg7), arg4, arg5, arg6, arg7);
        let v1 = 0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::Proposal<T0, T1>>(&v0);
        let v2 = ProposalCreated{
            proposal_id     : v1,
            accepted_by     : 0x2::tx_context::sender(arg7),
            pre_proposal_id : 0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::pre_proposal<T0, T1>(&v0)),
        };
        0x2::event::emit<ProposalCreated>(v2);
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::config::proposal_created(arg1);
        0x2::transfer::public_share_object<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::Proposal<T0, T1>>(v0);
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::add_active_proposal(arg2, v1);
    }

    public entry fun complete<T0, T1>(arg0: &0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::dao_admin::DaoAdmin, arg1: &0x2::clock::Clock, arg2: &mut 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::ProposalRegistry, arg3: 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::Proposal<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::Proposal<T0, T1>>(&arg3);
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::remove_active_proposal(arg2, v0);
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::end_time<T0, T1>(&arg3), 8);
        let v1 = 0;
        let v2 = 0x1::option::none<0x2::object::ID>();
        let v3 = 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::vote_types(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::pre_proposal<T0, T1>(&arg3));
        let v4 = 0x2::linked_table::back<0x2::object::ID, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote_type::VoteType>(v3);
        while (0x1::option::is_some<0x2::object::ID>(v4)) {
            let v5 = 0x2::linked_table::borrow<0x2::object::ID, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote_type::VoteType>(v3, *0x1::option::borrow<0x2::object::ID>(v4));
            if (0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote_type::total_vote_value(v5) > v1) {
                v1 = 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote_type::total_vote_value(v5);
                v2 = 0x1::option::some<0x2::object::ID>(*0x1::option::borrow<0x2::object::ID>(v4));
            };
            let v6 = *0x1::option::borrow<0x2::object::ID>(v4);
            v4 = 0x2::linked_table::prev<0x2::object::ID, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote_type::VoteType>(v3, v6);
        };
        assert!(0x1::option::is_some<0x2::object::ID>(&v2), 5);
        if (0x1::option::is_some<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::reward_pool::RewardPool<T0>>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::reward_pool<T0, T1>(&arg3))) {
            let v7 = &mut arg3;
            share_incentive_pool_rewards<T0, T1>(v7, arg4);
        };
        let (v8, v9, v10, v11, v12, v13) = 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::destroy<T0, T1>(arg3);
        let v14 = v9;
        let v15 = 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::completed_proposal::new(v8, v14, 0x2::clock::timestamp_ms(arg1), 0x2::linked_table::remove<0x2::object::ID, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote_type::VoteType>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::mut_vote_types(&mut v14), 0x1::option::extract<0x2::object::ID>(&mut v2)), v10, v13, arg4);
        let v16 = 0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::completed_proposal::CompletedProposal>(&v15);
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::add_completed_proposal(arg2, v16);
        let v17 = ProposalCompleted{
            proposal_id           : v0,
            completed_proposal_id : v16,
        };
        0x2::event::emit<ProposalCompleted>(v17);
        0x2::transfer::public_share_object<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::completed_proposal::CompletedProposal>(v15);
        0x2::linked_table::destroy_empty<address, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote::Vote<T1>>(v12);
        0x1::option::destroy_none<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::reward_pool::RewardPool<T0>>(v11);
    }

    public entry fun create_pre_proposal<T0>(arg0: &0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::config::ProposalConfig, arg1: &mut 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::ProposalRegistry, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::config::fee(arg0), 6);
        assert!(0x2::coin::value<T0>(&arg2) >= 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::config::min_in_to_create_proposal(arg0), 7);
        assert!(0x1::vector::length<0x1::string::String>(&arg5) >= 2, 12);
        assert!(0x1::type_name::get<T0>() == 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::config::payment_type(arg0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::config::fee(arg0), arg6), 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::config::receiver(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
        let v0 = 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::new(arg3, arg4, arg5, arg6);
        let v1 = PreProposalCreated{
            pre_proposal_id : 0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(&v0),
            proposer        : 0x2::tx_context::sender(arg6),
            name            : 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::name(&v0),
            description     : 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::description(&v0),
        };
        0x2::event::emit<PreProposalCreated>(v1);
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::add_pre_proposal(arg1, 0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(&v0));
        0x2::transfer::public_share_object<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(v0);
    }

    public entry fun create_proposal<T0, T1>(arg0: &0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::dao_admin::DaoAdmin, arg1: &mut 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::config::ProposalConfig, arg2: &mut 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::ProposalRegistry, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::new(arg3, arg4, arg5, arg9);
        let v1 = PreProposalCreated{
            pre_proposal_id : 0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(&v0),
            proposer        : 0x2::tx_context::sender(arg9),
            name            : 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::name(&v0),
            description     : 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::description(&v0),
        };
        0x2::event::emit<PreProposalCreated>(v1);
        let v2 = 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::new<T0, T1>(arg1, v0, arg6, arg7, arg8, arg9);
        let v3 = 0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::Proposal<T0, T1>>(&v2);
        let v4 = ProposalCreated{
            proposal_id     : v3,
            accepted_by     : 0x2::tx_context::sender(arg9),
            pre_proposal_id : 0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::pre_proposal<T0, T1>(&v2)),
        };
        0x2::event::emit<ProposalCreated>(v4);
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::config::proposal_created(arg1);
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::add_active_proposal(arg2, v3);
        0x2::transfer::public_share_object<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::Proposal<T0, T1>>(v2);
    }

    public entry fun extend_proposal<T0, T1>(arg0: &0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::dao_admin::DaoAdmin, arg1: &mut 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::Proposal<T0, T1>, arg2: u64) {
        assert!(arg2 > 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::end_time<T0, T1>(arg1), 10);
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::extend_time<T0, T1>(arg1, arg2);
    }

    fun init(arg0: DAO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DAO>(arg0, arg1);
        0x2::transfer::public_share_object<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::ProposalRegistry>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::new(arg1));
        let v1 = 0x2::tx_context::sender(arg1);
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::dao_admin::new(v1, arg1);
        0x2::transfer::public_transfer<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::dao_admin::DaoAdmin>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::dao_admin::new_dao_admin(arg1), v1);
        let v2 = 0x2::display::new<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(&v0, arg1);
        0x2::display::add<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Sui Generis Pre-Proposal | {name}"));
        0x2::display::add<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://dao.suigeneris.auction/proposal?id={id}"));
        0x2::display::update_version<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(&mut v2);
        0x2::transfer::public_share_object<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::display_wrapper::DisplayWrapper<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::display_wrapper::new<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(v2, arg1));
        let v3 = 0x2::display::new<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::completed_proposal::CompletedProposal>(&v0, arg1);
        0x2::display::add<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::completed_proposal::CompletedProposal>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Sui Generis Completed Proposal | {name}"));
        0x2::display::add<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::completed_proposal::CompletedProposal>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::completed_proposal::CompletedProposal>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://dao.suigeneris.auction/proposal?id={id}"));
        0x2::display::add<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::completed_proposal::CompletedProposal>(&mut v3, 0x1::string::utf8(b"index"), 0x1::string::utf8(b"{number}"));
        0x2::transfer::public_share_object<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::display_wrapper::DisplayWrapper<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::completed_proposal::CompletedProposal>>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::display_wrapper::new<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::completed_proposal::CompletedProposal>(v3, arg1));
        0x2::transfer::public_share_object<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::config::ProposalConfig>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::config::new<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>(0, @0x222, 0, v0, arg1));
    }

    public entry fun reject_pre_proposal(arg0: &0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::dao_admin::DaoAdmin, arg1: &mut 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::ProposalRegistry, arg2: 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal, arg3: &mut 0x2::tx_context::TxContext) {
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal_registry::remove_pre_proposal(arg1, 0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(&arg2));
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::destruct(arg2);
        let v0 = PreProposalRejected{
            rejected_by     : 0x2::tx_context::sender(arg3),
            pre_proposal_id : 0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::PreProposal>(&arg2),
        };
        0x2::event::emit<PreProposalRejected>(v0);
    }

    fun share_incentive_pool_rewards<T0, T1>(arg0: &mut 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::Proposal<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::extract<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::reward_pool::RewardPool<T0>>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::mut_reward_pool<T0, T1>(arg0));
        let v1 = 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::reward_pool::destroy<T0>(v0, arg1);
        while (0x2::linked_table::length<address, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote::Vote<T1>>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::votes<T0, T1>(arg0)) > 0) {
            let (v2, v3) = 0x2::linked_table::pop_front<address, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote::Vote<T1>>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::mut_votes<T0, T1>(arg0));
            let (v4, _, _) = 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote::destroy<T1>(v3);
            let v7 = v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, (((0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::reward_pool::value<T0>(&v0) as u128) * (0x2::balance::value<T1>(&v7) as u128) / (0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::total_vote_value<T0, T1>(arg0) as u128)) as u64), arg1), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg1), v2);
        };
        assert!(0x2::coin::value<T0>(&v1) == 0, 9);
        0x2::coin::destroy_zero<T0>(v1);
    }

    public fun vote<T0, T1>(arg0: &mut 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::Proposal<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::start_time<T0, T1>(arg0), 3);
        assert!(0x2::clock::timestamp_ms(arg1) <= 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::end_time<T0, T1>(arg0), 2);
        assert!(0x2::linked_table::contains<0x2::object::ID, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote_type::VoteType>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::vote_types(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::pre_proposal<T0, T1>(arg0)), arg2), 11);
        if (0x2::linked_table::contains<address, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote::Vote<T1>>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::votes<T0, T1>(arg0), 0x2::tx_context::sender(arg4))) {
            let v1 = 0x2::linked_table::borrow_mut<address, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote::Vote<T1>>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::mut_votes<T0, T1>(arg0), 0x2::tx_context::sender(arg4));
            assert!(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote::vote_type_id<T1>(v1) == arg2, 4);
            0x2::balance::join<T1>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote::mut_balance<T1>(v1), 0x2::coin::into_balance<T1>(arg3));
        } else {
            0x2::linked_table::push_back<address, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote::Vote<T1>>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::mut_votes<T0, T1>(arg0), 0x2::tx_context::sender(arg4), 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote::new<T1>(0x2::coin::into_balance<T1>(arg3), 0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::Proposal<T0, T1>>(arg0), arg2, arg4));
        };
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::add_vote_value<T0, T1>(arg0, v0);
        0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote_type::add_vote_value(0x2::linked_table::borrow_mut<0x2::object::ID, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote_type::VoteType>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::pre_proposal::mut_vote_types(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::mut_pre_proposal<T0, T1>(arg0)), arg2), v0);
        0x2::object::id<0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote::Vote<T1>>(0x2::linked_table::borrow<address, 0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::vote::Vote<T1>>(0x65c4824b1dfec150c60dc2f462de80c52a2392a39ad787eff715923877ec60f1::proposal::votes<T0, T1>(arg0), 0x2::tx_context::sender(arg4)))
    }

    // decompiled from Move bytecode v6
}

