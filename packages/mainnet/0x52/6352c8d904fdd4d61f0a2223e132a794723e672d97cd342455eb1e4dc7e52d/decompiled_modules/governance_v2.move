module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v2 {
    struct GovernanceInfo has key {
        id: 0x2::object::UID,
        governance_manager_cap: 0x1::option::Option<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceManagerCap>,
        governance_coin_type: 0x1::option::Option<0x1::type_name::TypeName>,
        guardians: vector<address>,
        active: bool,
        announce_delay: u64,
        voting_delay: u64,
        max_delay: u64,
        proposal_minimum_staking: u64,
        voting_minimum_staking: u64,
        his_proposal: vector<0x2::object::ID>,
    }

    struct Proposal<T0: drop + store, phantom T1> has key {
        id: 0x2::object::UID,
        creator: address,
        start_vote: u64,
        end_vote: u64,
        expired: u64,
        package_id: 0x1::ascii::String,
        certificate: T0,
        staked_coin: 0x2::balance::Balance<T1>,
        favor_num: u64,
        favor_votes: 0x2::table::Table<address, u64>,
        against_num: u64,
        against_votes: 0x2::table::Table<address, u64>,
        state: u8,
    }

    struct CreateProposal has copy, drop {
        proposal_id: 0x2::object::ID,
    }

    struct ChangeState has copy, drop {
        proposal_id: 0x2::object::ID,
        new_state: u8,
    }

    public fun activate_governance(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut GovernanceInfo, arg2: 0x1::type_name::TypeName, arg3: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceManagerCap) {
        assert!(!arg1.active && 0x1::vector::length<0x2::object::ID>(&arg1.his_proposal) == 0, 0);
        0x1::option::fill<0x1::type_name::TypeName>(&mut arg1.governance_coin_type, arg2);
        0x1::option::fill<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceManagerCap>(&mut arg1.governance_manager_cap, arg3);
        arg1.active = true;
    }

    public fun add_guardians(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut GovernanceInfo, arg2: address) {
        assert!(!0x1::vector::contains<address>(&mut arg1.guardians, &arg2), 4);
        0x1::vector::push_back<address>(&mut arg1.guardians, arg2);
    }

    public entry fun cancel_proposal<T0: drop + store, T1>(arg0: &GovernanceInfo, arg1: &mut Proposal<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::epoch(arg2) < arg1.expired) {
            assert!(arg1.state == 1, 7);
        };
        check_guardians(arg0, 0x2::tx_context::sender(arg2));
        arg1.state = 5;
        let v0 = ChangeState{
            proposal_id : 0x2::object::id<Proposal<T0, T1>>(arg1),
            new_state   : 5,
        };
        0x2::event::emit<ChangeState>(v0);
    }

    public fun check_guardians(arg0: &GovernanceInfo, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.guardians, &arg1), 3);
    }

    public entry fun claim<T0: drop + store, T1>(arg0: &mut Proposal<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 3 || arg0.state == 4 || arg0.state == 5 || 0x2::tx_context::epoch(arg1) >= arg0.expired, 14);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = &mut arg0.favor_votes;
        let v2 = &mut arg0.against_votes;
        if (0x2::table::contains<address, u64>(v1, v0)) {
            let v3 = 0x2::table::remove<address, u64>(v1, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.staked_coin, v3), arg1), v0);
            arg0.favor_num = arg0.favor_num - v3;
        } else {
            assert!(0x2::table::contains<address, u64>(v2, v0), 5);
            let v4 = 0x2::table::remove<address, u64>(v2, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.staked_coin, v4), arg1), v0);
            arg0.against_num = arg0.against_num - v4;
        };
    }

    public fun create_proposal<T0: drop + store, T1>(arg0: &GovernanceInfo, arg1: T0, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 1);
        assert!(arg3 >= arg0.proposal_minimum_staking, 10);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::tx_context::epoch(arg4);
        let v2 = v1 + arg0.announce_delay;
        let v3 = 0x2::table::new<address, u64>(arg4);
        0x2::table::add<address, u64>(&mut v3, v0, arg3);
        let v4 = 0x2::object::new(arg4);
        let v5 = 0x1::type_name::get<T0>();
        let v6 = Proposal<T0, T1>{
            id            : v4,
            creator       : v0,
            start_vote    : v2,
            end_vote      : v2 + arg0.voting_delay,
            expired       : v1 + arg0.max_delay,
            package_id    : 0x1::type_name::get_address(&v5),
            certificate   : arg1,
            staked_coin   : 0x2::coin::into_balance<T1>(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::merge_coins::merge_coin<T1>(arg2, arg3, arg4)),
            favor_num     : arg3,
            favor_votes   : v3,
            against_num   : 0,
            against_votes : 0x2::table::new<address, u64>(arg4),
            state         : 1,
        };
        0x2::transfer::share_object<Proposal<T0, T1>>(v6);
        let v7 = CreateProposal{proposal_id: *0x2::object::uid_as_inner(&v4)};
        0x2::event::emit<CreateProposal>(v7);
    }

    public fun destroy_governance_cap(arg0: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::destroy(arg0);
    }

    public fun ensure_two_thirds(arg0: u64, arg1: u64) : bool {
        let v0 = if (arg0 % 3 == 0) {
            arg0 * 2 / 3
        } else {
            arg0 * 2 / 3 + 1
        };
        arg1 >= v0
    }

    public fun get_proposal_state<T0: drop + store, T1>(arg0: &mut Proposal<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x1::ascii::String {
        if (arg0.state == 3) {
            0x1::ascii::string(b"SUCCESS")
        } else if (arg0.state == 4) {
            0x1::ascii::string(b"FAIL")
        } else if (arg0.state == 5) {
            0x1::ascii::string(b"CANCEL")
        } else if (0x2::tx_context::epoch(arg1) >= arg0.expired) {
            0x1::ascii::string(b"EXPIRED")
        } else if (arg0.state == 1) {
            0x1::ascii::string(b"ANNOUNCEMENT_PENDING")
        } else {
            0x1::ascii::string(b"VOTING_PENDING")
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = GovernanceInfo{
            id                       : 0x2::object::new(arg0),
            governance_manager_cap   : 0x1::option::none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceManagerCap>(),
            governance_coin_type     : 0x1::option::none<0x1::type_name::TypeName>(),
            guardians                : 0x1::vector::empty<address>(),
            active                   : false,
            announce_delay           : 0,
            voting_delay             : 1,
            max_delay                : 30,
            proposal_minimum_staking : 0,
            voting_minimum_staking   : 0,
            his_proposal             : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<GovernanceInfo>(v1);
    }

    public fun remove_guardians(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut GovernanceInfo, arg2: address) {
        check_guardians(arg1, arg2);
        let (_, v1) = 0x1::vector::index_of<address>(&mut arg1.guardians, &arg2);
        0x1::vector::remove<address>(&mut arg1.guardians, v1);
    }

    public fun update_delay(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut GovernanceInfo, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg3 > 0, 2);
        assert!(arg4 > arg3 + arg2, 2);
        arg1.announce_delay = arg2;
        arg1.voting_delay = arg3;
        arg1.max_delay = arg4;
    }

    public fun update_minumum_staking(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut GovernanceInfo, arg2: u64, arg3: u64) {
        arg1.proposal_minimum_staking = arg2;
        arg1.voting_minimum_staking = arg3;
    }

    public fun upgrade(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut GovernanceInfo) : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceManagerCap {
        arg1.active = false;
        0x1::option::extract<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceManagerCap>(&mut arg1.governance_manager_cap)
    }

    public fun vote_proposal<T0: drop + store, T1>(arg0: &GovernanceInfo, arg1: T0, arg2: &mut Proposal<T0, T1>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap> {
        let v0 = 0x2::tx_context::epoch(arg6);
        assert!(v0 >= arg2.start_vote, 6);
        assert!(v0 < arg2.expired, 9);
        if (arg2.state == 1) {
            arg2.state = 2;
            let v1 = ChangeState{
                proposal_id : 0x2::object::id<Proposal<T0, T1>>(arg2),
                new_state   : 2,
            };
            0x2::event::emit<ChangeState>(v1);
        };
        assert!(arg2.state == 2, 8);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = &mut arg2.favor_votes;
        let v4 = &mut arg2.against_votes;
        if (v0 < arg2.end_vote) {
            0x2::balance::join<T1>(&mut arg2.staked_coin, 0x2::coin::into_balance<T1>(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::merge_coins::merge_coin<T1>(arg3, arg4, arg6)));
            if (arg5) {
                arg2.favor_num = arg2.favor_num + arg4;
                let v6 = arg4;
                if (0x2::table::contains<address, u64>(v3, v2)) {
                    v6 = arg4 + 0x2::table::remove<address, u64>(v3, v2);
                };
                if (0x2::table::contains<address, u64>(v4, v2)) {
                    let v7 = 0x2::table::remove<address, u64>(v4, v2);
                    arg2.favor_num = arg2.favor_num + v7;
                    arg2.against_num = arg2.against_num - v7;
                    v6 = v6 + v7;
                };
                0x2::table::add<address, u64>(v3, v2, v6);
            } else {
                arg2.against_num = arg2.against_num + arg4;
                let v8 = arg4;
                if (0x2::table::contains<address, u64>(v4, v2)) {
                    v8 = arg4 + 0x2::table::remove<address, u64>(v4, v2);
                };
                if (0x2::table::contains<address, u64>(v3, v2)) {
                    let v9 = 0x2::table::remove<address, u64>(v3, v2);
                    arg2.against_num = arg2.against_num + v9;
                    arg2.favor_num = arg2.favor_num - v9;
                    v8 = v8 + v9;
                };
                0x2::table::add<address, u64>(v4, v2, v8);
            };
            assert!(arg2.favor_num + arg2.against_num == 0x2::balance::value<T1>(&arg2.staked_coin), 13);
            0x1::option::none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>()
        } else {
            0x2::coin::destroy_zero<T1>(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::merge_coins::merge_coin<T1>(arg3, arg4, arg6));
            let v10 = arg2.favor_num + arg2.against_num;
            if (ensure_two_thirds(v10, arg2.favor_num) && v10 >= arg0.voting_minimum_staking) {
                arg2.state = 3;
                let v11 = ChangeState{
                    proposal_id : 0x2::object::id<Proposal<T0, T1>>(arg2),
                    new_state   : 3,
                };
                0x2::event::emit<ChangeState>(v11);
                0x1::option::some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::create(0x1::option::borrow<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceManagerCap>(&arg0.governance_manager_cap)))
            } else {
                arg2.state = 4;
                let v12 = ChangeState{
                    proposal_id : 0x2::object::id<Proposal<T0, T1>>(arg2),
                    new_state   : 4,
                };
                0x2::event::emit<ChangeState>(v12);
                0x1::option::none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>()
            }
        }
    }

    // decompiled from Move bytecode v6
}

