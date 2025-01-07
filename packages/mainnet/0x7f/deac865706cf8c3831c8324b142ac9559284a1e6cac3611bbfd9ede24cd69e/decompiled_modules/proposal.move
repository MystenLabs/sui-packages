module 0x7fdeac865706cf8c3831c8324b142ac9559284a1e6cac3611bbfd9ede24cd69e::proposal {
    struct ProposalDesc has store {
        description: 0x1::ascii::String,
        vote_porposal: vector<address>,
    }

    struct EscrowReward has key {
        id: 0x2::object::UID,
        reward: 0x2::balance::Balance<0x2::sui::SUI>,
        creator: address,
    }

    struct Certificate has drop, store {
        dummy_field: bool,
    }

    public entry fun add_description_for_proposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg1: &EscrowReward, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"79d7106ea18373fc7542b0849d5ebefc3a9daf8b664a4f82d9b35bbd0c22042d"));
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"e5a189b1858b207f2cf8c05a09d75bae4271c7a9a8f84a8c199c6896dc7c37e6"));
        let v1 = 0x2::object::id<EscrowReward>(arg1);
        0x1::vector::push_back<address>(&mut v0, 0x2::object::id_to_address(&v1));
        let v2 = 0x2::object::id<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>>(arg0);
        0x1::vector::push_back<address>(&mut v0, 0x2::object::id_to_address(&v2));
        let v3 = ProposalDesc{
            description   : 0x1::ascii::string(b"Add sui reward pool from 2024-08-12 to 2024-08-26"),
            vote_porposal : v0,
        };
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::add_description_for_proposal<Certificate, ProposalDesc>(arg0, v3, arg2);
    }

    public fun all_reward() : u64 {
        320000000000 + 659000000000
    }

    public entry fun create_proposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut EscrowReward, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= all_reward(), 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.reward, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = Certificate{dummy_field: false};
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::create_proposal_with_history<Certificate>(arg0, v0, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EscrowReward{
            id      : 0x2::object::new(arg0),
            reward  : 0x2::balance::zero<0x2::sui::SUI>(),
            creator : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<EscrowReward>(v0);
    }

    public entry fun vote_porposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut EscrowReward, arg3: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::vote_proposal<Certificate>(arg0, v0, arg3, true, arg4);
        if (0x1::option::is_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&v1)) {
            assert!(0x2::tx_context::sender(arg4) == 0x2::address::from_bytes(x"65859958bd62e30aa0571f9712962f59098d1eb29f73b091d9d71317d8e67497"), 5);
            let v2 = 0x1::option::extract<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&mut v1);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::create_reward_pool<0x2::sui::SUI>(&v2, arg1, 1731895200, 1733104800, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.reward, 320000000000), arg4), 8, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type(), arg4);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::create_reward_pool<0x2::sui::SUI>(&v2, arg1, 1731895200, 1733104800, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.reward, 659000000000), arg4), 3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type(), arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.reward), arg4), arg2.creator);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::destroy_governance_cap(v2);
        };
        0x1::option::destroy_none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(v1);
    }

    public fun vote_porposal_final(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut EscrowReward, arg3: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::RewardPool<0x2::sui::SUI>, arg4: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::RewardPool<0x2::sui::SUI>, arg5: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::RewardPool<0x2::sui::SUI>, arg6: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::vote_proposal<Certificate>(arg0, v0, arg6, true, arg7);
        if (0x1::option::is_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&v1)) {
            assert!(0x2::tx_context::sender(arg7) == 0x2::address::from_bytes(x"65859958bd62e30aa0571f9712962f59098d1eb29f73b091d9d71317d8e67497"), 5);
            let v2 = 0x1::option::extract<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&mut v1);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::create_reward_pool<0x2::sui::SUI>(&v2, arg1, 1731895200, 1733104800, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.reward, 320000000000), arg7), 8, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type(), arg7);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::create_reward_pool<0x2::sui::SUI>(&v2, arg1, 1731895200, 1733104800, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.reward, 659000000000), arg7), 3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type(), arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.reward), arg7), arg2.creator);
            let v3 = 0x2::object::id<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::RewardPool<0x2::sui::SUI>>(arg3);
            assert!(0x2::object::id_to_address(&v3) == 0x2::address::from_bytes(x"385c02cbbc2bcc78d9192d6401745a9c2fddf21d05ac0dded65255f392579d32"), 1);
            let v4 = 0x2::object::id<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::RewardPool<0x2::sui::SUI>>(arg4);
            assert!(0x2::object::id_to_address(&v4) == 0x2::address::from_bytes(x"6467d6810fba39159405119ef0ccd2faab34c9704156ed95c561936e39ed385d"), 1);
            let v5 = 0x2::object::id<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::RewardPool<0x2::sui::SUI>>(arg5);
            assert!(0x2::object::id_to_address(&v5) == 0x2::address::from_bytes(x"d349498c24f4a7c2526f51be547cdf80ce274ed2ed9ca69d38c91ba6266aea66"), 1);
            let v6 = 0x2::address::from_bytes(x"2c2582723e8d738261d2313613f2f1aa4888ae58ce6c71e24583eb8ca5b9437a");
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::remove_reward_pool<0x2::sui::SUI>(&v2, arg1, arg3, 8, arg7), v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::remove_reward_pool<0x2::sui::SUI>(&v2, arg1, arg4, 3, arg7), v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::remove_reward_pool<0x2::sui::SUI>(&v2, arg1, arg5, 3, arg7), v6);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::destroy_governance_cap(v2);
        };
        0x1::option::destroy_none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(v1);
    }

    // decompiled from Move bytecode v6
}

