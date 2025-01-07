module 0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::dao {
    struct Dao<phantom T0> has store, key {
        id: 0x2::object::UID,
        voting_delay: u64,
        voting_period: u64,
        voting_quorum_rate: u64,
        min_action_delay: u64,
        min_quorum_votes: u64,
        treasury: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        admin_id: 0x2::object::ID,
    }

    struct Proposal<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        proposer: address,
        start_time: u64,
        end_time: u64,
        for_votes: u64,
        against_votes: u64,
        eta: u64,
        action_delay: u64,
        quorum_votes: u64,
        voting_quorum_rate: u64,
        hash: 0x1::string::String,
        authorized_witness: 0x1::option::Option<0x1::type_name::TypeName>,
        capability_id: 0x1::option::Option<0x2::object::ID>,
        coin_type: 0x1::type_name::TypeName,
    }

    struct CapabilityRequest {
        capability_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
    }

    struct Vote<phantom T0: drop, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T1>,
        proposal_id: 0x2::object::ID,
        end_time: u64,
        agree: bool,
    }

    struct CreateDao<phantom T0, phantom T1> has copy, drop {
        dao_id: 0x2::object::ID,
        admin_id: 0x2::object::ID,
        creator: address,
        voting_delay: u64,
        voting_period: u64,
        voting_quorum_rate: u64,
        min_action_delay: u64,
        min_quorum_votes: u64,
    }

    struct UpdateDao<phantom T0> has copy, drop {
        dao_id: 0x2::object::ID,
        voting_delay: u64,
        voting_period: u64,
        voting_quorum_rate: u64,
        min_action_delay: u64,
        min_quorum_votes: u64,
    }

    struct NewProposal<phantom T0> has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
    }

    struct CastVote<phantom T0, phantom T1> has copy, drop {
        voter: address,
        proposal_id: 0x2::object::ID,
        agree: bool,
        end_time: u64,
        value: u64,
    }

    struct ChangeVote<phantom T0, phantom T1> has copy, drop {
        voter: address,
        proposal_id: 0x2::object::ID,
        vote_id: 0x2::object::ID,
        agree: bool,
        end_time: u64,
        value: u64,
    }

    struct RevokeVote<phantom T0, phantom T1> has copy, drop {
        voter: address,
        proposal_id: 0x2::object::ID,
        agree: bool,
        value: u64,
    }

    struct UnstakeVote<phantom T0, phantom T1> has copy, drop {
        voter: address,
        proposal_id: 0x2::object::ID,
        agree: bool,
        value: u64,
    }

    public fun balance<T0: drop, T1>(arg0: &Vote<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance)
    }

    public fun new<T0: drop, T1: drop>(arg0: T0, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (Dao<T0>, 0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::dao_treasury::DaoTreasury<T0>) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        new_impl<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun action_delay<T0: drop>(arg0: &Proposal<T0>) : u64 {
        arg0.action_delay
    }

    public fun admin<T0>(arg0: &Dao<T0>) : 0x2::object::ID {
        arg0.admin_id
    }

    public fun against_votes<T0: drop>(arg0: &Proposal<T0>) : u64 {
        arg0.against_votes
    }

    public fun agree<T0: drop, T1>(arg0: &Vote<T0, T1>) : bool {
        arg0.agree
    }

    public fun authorized_witness<T0: drop>(arg0: &Proposal<T0>) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.authorized_witness
    }

    public fun capability_id<T0: drop>(arg0: &Proposal<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.capability_id
    }

    public fun cast_vote<T0: drop, T1>(arg0: &mut Proposal<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : Vote<T0, T1> {
        assert!(proposal_state_impl<T0>(arg0, 0x2::clock::timestamp_ms(arg1)) == 2, 4);
        assert!(arg0.coin_type == 0x1::type_name::get<T1>(), 12);
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 != 0, 5);
        if (arg3) {
            arg0.for_votes = arg0.for_votes + v0;
        } else {
            arg0.against_votes = arg0.against_votes + v0;
        };
        let v1 = 0x2::object::id<Proposal<T0>>(arg0);
        let v2 = CastVote<T0, T1>{
            voter       : 0x2::tx_context::sender(arg4),
            proposal_id : v1,
            agree       : arg3,
            end_time    : arg0.end_time,
            value       : v0,
        };
        0x2::event::emit<CastVote<T0, T1>>(v2);
        Vote<T0, T1>{
            id          : 0x2::object::new(arg4),
            balance     : 0x2::coin::into_balance<T1>(arg2),
            proposal_id : v1,
            end_time    : arg0.end_time,
            agree       : arg3,
        }
    }

    public fun change_vote<T0: drop, T1>(arg0: &mut Proposal<T0>, arg1: &mut Vote<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(proposal_state_impl<T0>(arg0, 0x2::clock::timestamp_ms(arg2)) == 2, 4);
        let v0 = 0x2::object::id<Proposal<T0>>(arg0);
        assert!(v0 == arg1.proposal_id, 7);
        let v1 = 0x2::balance::value<T1>(&arg1.balance);
        arg1.agree = !arg1.agree;
        if (arg1.agree) {
            arg0.against_votes = arg0.against_votes - v1;
            arg0.for_votes = arg0.for_votes + v1;
        } else {
            arg0.for_votes = arg0.for_votes - v1;
            arg0.against_votes = arg0.against_votes + v1;
        };
        let v2 = ChangeVote<T0, T1>{
            voter       : 0x2::tx_context::sender(arg3),
            proposal_id : v0,
            vote_id     : 0x2::object::id<Vote<T0, T1>>(arg1),
            agree       : arg1.agree,
            end_time    : arg0.end_time,
            value       : v1,
        };
        0x2::event::emit<ChangeVote<T0, T1>>(v2);
    }

    public fun coin_type<T0: drop>(arg0: &Proposal<T0>) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun dao_coin_type<T0>(arg0: &Dao<T0>) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun dao_voting_quorum_rate<T0>(arg0: &Dao<T0>) : u64 {
        arg0.voting_quorum_rate
    }

    fun destroy_vote<T0: drop, T1>(arg0: Vote<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let Vote {
            id          : v0,
            balance     : v1,
            proposal_id : _,
            end_time    : _,
            agree       : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::coin::from_balance<T1>(v1, arg1)
    }

    public fun end_time<T0: drop>(arg0: &Proposal<T0>) : u64 {
        arg0.end_time
    }

    public fun eta<T0: drop>(arg0: &Proposal<T0>) : u64 {
        arg0.eta
    }

    public fun execute<T0: drop, T1: drop, T2: store + key>(arg0: &mut Dao<T0>, arg1: &mut Proposal<T0>, arg2: T1, arg3: 0x2::transfer::Receiving<T2>, arg4: &0x2::clock::Clock) : (T2, CapabilityRequest) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(proposal_state_impl<T0>(arg1, v0) == 6, 8);
        assert!(v0 >= arg1.end_time + arg1.action_delay, 9);
        assert!(0x1::type_name::get<T1>() == 0x1::option::extract<0x1::type_name::TypeName>(&mut arg1.authorized_witness), 13);
        let v1 = 0x1::option::extract<0x2::object::ID>(&mut arg1.capability_id);
        let v2 = 0x2::transfer::public_receive<T2>(&mut arg0.id, arg3);
        assert!(0x2::object::id<T2>(&v2) == v1, 14);
        let v3 = CapabilityRequest{
            capability_id : v1,
            dao_id        : 0x2::object::id<Dao<T0>>(arg0),
        };
        (v2, v3)
    }

    public fun for_votes<T0: drop>(arg0: &Proposal<T0>) : u64 {
        arg0.for_votes
    }

    public fun hash<T0: drop>(arg0: &Proposal<T0>) : 0x1::string::String {
        arg0.hash
    }

    public fun min_action_delay<T0>(arg0: &Dao<T0>) : u64 {
        arg0.min_action_delay
    }

    public fun min_quorum_votes<T0>(arg0: &Dao<T0>) : u64 {
        arg0.min_quorum_votes
    }

    fun new_impl<T0: drop, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (Dao<T0>, 0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::dao_treasury::DaoTreasury<T0>) {
        assert!(1000000000 >= arg2 && arg2 != 0, 1);
        let v0 = 0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::dao_admin::new<T0>(arg5);
        let v1 = 0x2::object::id<0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::dao_admin::DaoAdmin<T0>>(&v0);
        let v2 = 0x2::object::new(arg5);
        let v3 = 0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::dao_treasury::new<T0>(0x2::object::uid_to_inner(&v2), arg5);
        let v4 = Dao<T0>{
            id                 : v2,
            voting_delay       : arg0,
            voting_period      : arg1,
            voting_quorum_rate : arg2,
            min_action_delay   : arg3,
            min_quorum_votes   : arg4,
            treasury           : 0x2::object::id<0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::dao_treasury::DaoTreasury<T0>>(&v3),
            coin_type          : 0x1::type_name::get<T1>(),
            admin_id           : v1,
        };
        let v5 = CreateDao<T0, T1>{
            dao_id             : 0x2::object::id<Dao<T0>>(&v4),
            admin_id           : v1,
            creator            : 0x2::tx_context::sender(arg5),
            voting_delay       : arg0,
            voting_period      : arg1,
            voting_quorum_rate : arg2,
            min_action_delay   : arg3,
            min_quorum_votes   : arg4,
        };
        0x2::event::emit<CreateDao<T0, T1>>(v5);
        0x2::transfer::public_transfer<0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::dao_admin::DaoAdmin<T0>>(v0, 0x2::object::uid_to_address(&v4.id));
        (v4, v3)
    }

    public fun proposal_id<T0: drop, T1>(arg0: &Vote<T0, T1>) : 0x2::object::ID {
        arg0.proposal_id
    }

    fun proposal_state_impl<T0: drop>(arg0: &Proposal<T0>, arg1: u64) : u8 {
        if (arg1 < arg0.start_time) {
            1
        } else if (arg1 <= arg0.end_time) {
            2
        } else if (arg0.for_votes + arg0.against_votes == 0 || arg0.for_votes <= arg0.against_votes || arg0.for_votes + arg0.against_votes < arg0.quorum_votes || arg0.voting_quorum_rate > 0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::fixed_point_roll::div_down(arg0.for_votes, arg0.for_votes + arg0.against_votes)) {
            3
        } else if (arg0.eta == 0) {
            4
        } else if (arg1 < arg0.eta) {
            5
        } else if (0x1::option::is_some<0x2::object::ID>(&arg0.capability_id)) {
            6
        } else {
            7
        }
    }

    public fun propose<T0: drop>(arg0: &mut Dao<T0>, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<0x1::type_name::TypeName>, arg3: 0x1::option::Option<0x2::object::ID>, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : Proposal<T0> {
        assert!(arg4 >= arg0.min_action_delay, 2);
        assert!(arg5 >= arg0.min_quorum_votes, 3);
        assert!(0x1::string::length(&arg6) != 0, 10);
        let v0 = 0x2::clock::timestamp_ms(arg1) + arg0.voting_delay;
        let v1 = Proposal<T0>{
            id                 : 0x2::object::new(arg7),
            proposer           : 0x2::tx_context::sender(arg7),
            start_time         : v0,
            end_time           : v0 + arg0.voting_period,
            for_votes          : 0,
            against_votes      : 0,
            eta                : 0,
            action_delay       : arg4,
            quorum_votes       : arg5,
            voting_quorum_rate : arg0.voting_quorum_rate,
            hash               : arg6,
            authorized_witness : arg2,
            capability_id      : arg3,
            coin_type          : arg0.coin_type,
        };
        let v2 = NewProposal<T0>{
            proposal_id : 0x2::object::id<Proposal<T0>>(&v1),
            proposer    : v1.proposer,
        };
        0x2::event::emit<NewProposal<T0>>(v2);
        v1
    }

    public fun proposer<T0: drop>(arg0: &Proposal<T0>) : address {
        arg0.proposer
    }

    public fun queue<T0: drop>(arg0: &mut Proposal<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(proposal_state_impl<T0>(arg0, v0) == 4, 11);
        arg0.eta = v0 + arg0.action_delay;
    }

    public fun quorum_votes<T0: drop>(arg0: &Proposal<T0>) : u64 {
        arg0.quorum_votes
    }

    public fun return_capability<T0: drop, T1: store + key>(arg0: &Dao<T0>, arg1: T1, arg2: CapabilityRequest) {
        let CapabilityRequest {
            capability_id : v0,
            dao_id        : v1,
        } = arg2;
        assert!(v1 == 0x2::object::id<Dao<T0>>(arg0), 16);
        assert!(v0 == 0x2::object::id<T1>(&arg1), 15);
        0x2::transfer::public_transfer<T1>(arg1, 0x2::object::uid_to_address(&arg0.id));
    }

    public fun revoke_vote<T0: drop, T1>(arg0: &mut Proposal<T0>, arg1: Vote<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(proposal_state_impl<T0>(arg0, 0x2::clock::timestamp_ms(arg2)) == 2, 4);
        let v0 = 0x2::object::id<Proposal<T0>>(arg0);
        assert!(v0 == arg1.proposal_id, 7);
        let v1 = 0x2::balance::value<T1>(&arg1.balance);
        if (arg1.agree) {
            arg0.for_votes = arg0.for_votes - v1;
        } else {
            arg0.against_votes = arg0.against_votes - v1;
        };
        let v2 = RevokeVote<T0, T1>{
            voter       : 0x2::tx_context::sender(arg3),
            proposal_id : v0,
            agree       : arg1.agree,
            value       : v1,
        };
        0x2::event::emit<RevokeVote<T0, T1>>(v2);
        destroy_vote<T0, T1>(arg1, arg3)
    }

    public fun start_time<T0: drop>(arg0: &Proposal<T0>) : u64 {
        arg0.start_time
    }

    public fun state<T0: drop>(arg0: &Proposal<T0>, arg1: &0x2::clock::Clock) : u8 {
        proposal_state_impl<T0>(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun treasury<T0>(arg0: &Dao<T0>) : 0x2::object::ID {
        arg0.treasury
    }

    public fun unstake_vote<T0: drop, T1>(arg0: &Proposal<T0>, arg1: Vote<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(proposal_state_impl<T0>(arg0, 0x2::clock::timestamp_ms(arg2)) > 2, 6);
        let v0 = 0x2::object::id<Proposal<T0>>(arg0);
        assert!(v0 == arg1.proposal_id, 7);
        let v1 = UnstakeVote<T0, T1>{
            voter       : 0x2::tx_context::sender(arg3),
            proposal_id : v0,
            agree       : arg1.agree,
            value       : 0x2::balance::value<T1>(&arg1.balance),
        };
        0x2::event::emit<UnstakeVote<T0, T1>>(v1);
        destroy_vote<T0, T1>(arg1, arg3)
    }

    public fun update_dao_config<T0: drop>(arg0: &mut Dao<T0>, arg1: &0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::dao_admin::DaoAdmin<T0>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>) {
        arg0.voting_delay = 0x1::option::destroy_with_default<u64>(arg2, arg0.voting_delay);
        arg0.voting_period = 0x1::option::destroy_with_default<u64>(arg3, arg0.voting_period);
        arg0.voting_quorum_rate = 0x1::option::destroy_with_default<u64>(arg4, arg0.voting_quorum_rate);
        arg0.min_action_delay = 0x1::option::destroy_with_default<u64>(arg5, arg0.min_action_delay);
        arg0.min_quorum_votes = 0x1::option::destroy_with_default<u64>(arg6, arg0.min_quorum_votes);
        assert!(1000000000 >= arg0.voting_quorum_rate && arg0.voting_quorum_rate != 0, 1);
        let v0 = UpdateDao<T0>{
            dao_id             : 0x2::object::id<Dao<T0>>(arg0),
            voting_delay       : arg0.voting_delay,
            voting_period      : arg0.voting_period,
            voting_quorum_rate : arg0.voting_quorum_rate,
            min_action_delay   : arg0.min_action_delay,
            min_quorum_votes   : arg0.min_quorum_votes,
        };
        0x2::event::emit<UpdateDao<T0>>(v0);
    }

    public fun vote_end_time<T0: drop, T1>(arg0: &Vote<T0, T1>) : u64 {
        arg0.end_time
    }

    public fun voting_delay<T0>(arg0: &Dao<T0>) : u64 {
        arg0.voting_delay
    }

    public fun voting_period<T0>(arg0: &Dao<T0>) : u64 {
        arg0.voting_period
    }

    public fun voting_quorum_rate<T0: drop>(arg0: &Proposal<T0>) : u64 {
        arg0.voting_quorum_rate
    }

    // decompiled from Move bytecode v6
}

