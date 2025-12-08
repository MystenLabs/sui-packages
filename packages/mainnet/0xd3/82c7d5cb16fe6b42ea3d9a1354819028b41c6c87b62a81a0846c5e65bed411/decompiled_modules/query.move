module 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query {
    struct Query<phantom T0> has store, key {
        id: 0x2::object::UID,
        inner: 0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::VersionedObject,
    }

    struct QueryCreated<phantom T0> has copy, drop {
        query_id: 0x2::object::ID,
        creator: address,
        topic: vector<u8>,
        bond_amount: u64,
        timestamp_ms: 0x1::option::Option<u64>,
        schema_version: 0x1::option::Option<u64>,
    }

    struct DataProposed has copy, drop {
        query_id: 0x2::object::ID,
        proposer: address,
        data: vector<u8>,
        bond_amount: u64,
        expires_at_ms: u64,
    }

    struct ProposalDisputed has copy, drop {
        query_id: 0x2::object::ID,
        disputer: address,
        disputed_at_ms: u64,
        bond_amount: u64,
    }

    struct RewardRefunded has copy, drop {
        query_id: 0x2::object::ID,
        amount: u64,
    }

    struct QuerySettled has copy, drop {
        query_id: 0x2::object::ID,
        resolved_data: vector<u8>,
        winner: address,
        total_payout: u64,
    }

    public fun timestamp_ms<T0>(arg0: &mut Query<T0>) : 0x1::option::Option<u64> {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::timestamp_ms<T0>(load_inner<T0>(arg0))
    }

    public fun create<T0, T1: drop>(arg0: T1, arg1: &mut 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::Protocol, arg2: &0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::Resolver, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: vector<0x2::object::ID>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : Query<T0> {
        assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::has_topic_schema(arg1, arg3, arg4), 2);
        assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::is_topic_schema_active(arg1, arg3, arg4), 14);
        let v0 = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::new_standard_schema(*0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::topic_schema(arg1, arg3, arg4), arg4);
        create_with_schema<T0, T1>(arg0, arg1, arg2, v0, arg3, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun add_reward<T0>(arg0: &mut Query<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock) {
        let v0 = load_inner_mut<T0>(arg0);
        assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state<T0>(v0, arg2) == 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state_created(), 4);
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::add_reward<T0>(v0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun bond_amount<T0>(arg0: &mut Query<T0>) : u64 {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::bond_amount<T0>(load_inner<T0>(arg0))
    }

    public fun bond_balance<T0>(arg0: &mut Query<T0>) : u64 {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::bond_balance<T0>(load_inner<T0>(arg0))
    }

    public fun callback_object_ids<T0>(arg0: &mut Query<T0>) : vector<0x2::object::ID> {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::callback_object_ids<T0>(load_inner<T0>(arg0))
    }

    public fun create_with_schema<T0, T1: drop>(arg0: T1, arg1: &mut 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::Protocol, arg2: &0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::Resolver, arg3: 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::Schema, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: vector<0x2::object::ID>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : Query<T0> {
        assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::is_coin_type_supported<T0>(arg1), 3);
        assert!(0x1::vector::length<u8>(&arg5) <= 16384, 8);
        let v0 = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::minimum_bond_amount<T0>(arg1);
        let v1 = 0x1::option::destroy_with_default<u64>(arg7, v0);
        assert!(v1 >= v0, 7);
        if (0x1::option::is_some<u64>(&arg6)) {
            assert!(*0x1::option::borrow<u64>(&arg6) <= 0x2::clock::timestamp_ms(arg9), 5);
        };
        let v2 = 0x2::object::new(arg10);
        let v3 = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::create<T0>(&mut v2, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::id(arg2), arg3, arg4, arg5, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::default_liveness_ms(arg1), arg6, arg8, 0x1::type_name::with_defining_ids<T1>(), v1, arg9);
        let v4 = Query<T0>{
            id    : v2,
            inner : 0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::create<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::QueryInner<T0>>(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::current_query_version(), v3, arg10),
        };
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::increment_num_queries(arg1);
        let v5 = QueryCreated<T0>{
            query_id       : 0x2::object::uid_to_inner(&v4.id),
            creator        : 0x2::tx_context::sender(arg10),
            topic          : arg4,
            bond_amount    : v1,
            timestamp_ms   : arg6,
            schema_version : 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::schema_version<T0>(&v3),
        };
        0x2::event::emit<QueryCreated<T0>>(v5);
        v4
    }

    public fun created_at_ms<T0>(arg0: &mut Query<T0>) : u64 {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::created_at_ms<T0>(load_inner<T0>(arg0))
    }

    public fun creator_witness<T0>(arg0: &mut Query<T0>) : 0x1::type_name::TypeName {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::creator_witness<T0>(load_inner<T0>(arg0))
    }

    public fun dispute_proposal<T0>(arg0: &mut Query<T0>, arg1: &mut 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::Protocol, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::DisputeTicket<T0> {
        let (v0, _, _, _) = dispute_proposal_internal<T0>(arg0, arg1, arg2, arg3, arg4);
        v0
    }

    fun dispute_proposal_internal<T0>(arg0: &mut Query<T0>, arg1: &mut 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::Protocol, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::DisputeTicket<T0>, 0x2::object::ID, address, 0x1::type_name::TypeName) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = load_inner_mut<T0>(arg0);
        assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state<T0>(v1, arg3) == 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state_proposed(), 4);
        let (v2, v3, v4, v5) = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::dispute_proposal<T0>(v1, v0, 0x2::coin::into_balance<T0>(arg2), 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::fee_factor_bps(arg1), 0x2::tx_context::sender(arg4), arg3, arg4);
        let v6 = if (v5 > 0) {
            let v7 = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::refund_address<T0>(v1);
            0x1::option::is_some<address>(&v7)
        } else {
            false
        };
        if (v6) {
            let v8 = RewardRefunded{
                query_id : v0,
                amount   : v5,
            };
            0x2::event::emit<RewardRefunded>(v8);
        };
        let v9 = ProposalDisputed{
            query_id       : v0,
            disputer       : v3,
            disputed_at_ms : 0x2::clock::timestamp_ms(arg3),
            bond_amount    : v4,
        };
        0x2::event::emit<ProposalDisputed>(v9);
        (v2, v0, v3, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::creator_witness<T0>(v1))
    }

    public fun dispute_proposal_with_callback<T0>(arg0: &mut Query<T0>, arg1: &mut 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::Protocol, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::DisputeTicket<T0>, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::ProposalDisputed) {
        let (v0, v1, v2, v3) = dispute_proposal_internal<T0>(arg0, arg1, arg2, arg3, arg4);
        (v0, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::new_proposal_disputed(v1, v2, v3))
    }

    public fun disputed_at_ms<T0>(arg0: &mut Query<T0>) : 0x1::option::Option<u64> {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::disputed_at_ms<T0>(load_inner<T0>(arg0))
    }

    public fun disputer<T0>(arg0: &mut Query<T0>) : 0x1::option::Option<address> {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::disputer<T0>(load_inner<T0>(arg0))
    }

    public fun expires_at_ms<T0>(arg0: &mut Query<T0>) : 0x1::option::Option<u64> {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::expires_at_ms<T0>(load_inner<T0>(arg0))
    }

    public fun id<T0>(arg0: &Query<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_settled<T0>(arg0: &mut Query<T0>) : bool {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::is_settled<T0>(load_inner<T0>(arg0))
    }

    public fun liveness_ms<T0>(arg0: &mut Query<T0>) : u64 {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::liveness_ms<T0>(load_inner<T0>(arg0))
    }

    fun load_inner<T0>(arg0: &mut Query<T0>) : &0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::QueryInner<T0> {
        assert!(0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::version(&arg0.inner) == 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::current_query_version(), 11);
        0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::load_value<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::QueryInner<T0>>(&arg0.inner)
    }

    fun load_inner_mut<T0>(arg0: &mut Query<T0>) : &mut 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::QueryInner<T0> {
        assert!(0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::version(&arg0.inner) == 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::current_query_version(), 11);
        0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::load_value_mut<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::QueryInner<T0>>(&mut arg0.inner)
    }

    public fun metadata<T0>(arg0: &mut Query<T0>) : vector<u8> {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::metadata<T0>(load_inner<T0>(arg0))
    }

    public fun new_custom_schema(arg0: 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::Schema) : 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::Schema {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::new_custom_schema(arg0)
    }

    public fun schema<T0>(arg0: &mut Query<T0>) : &0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::Schema {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::schema<T0>(load_inner<T0>(arg0))
    }

    public fun proposal_data<T0>(arg0: &mut Query<T0>) : 0x1::option::Option<vector<u8>> {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::proposal_data<T0>(load_inner<T0>(arg0))
    }

    public fun propose_data<T0>(arg0: &mut Query<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let (_, _, _, _) = propose_data_internal<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    fun propose_data_internal<T0>(arg0: &mut Query<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::object::ID, address, vector<u8>, 0x1::type_name::TypeName) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = load_inner_mut<T0>(arg0);
        assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state<T0>(v1, arg3) == 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state_created(), 4);
        let v2 = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::timestamp_ms<T0>(v1);
        let v3 = 0x1::option::is_none<u64>(&v2) && arg2 == x"fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe";
        assert!(!v3, 6);
        if (arg2 != x"fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe" && arg2 != x"fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd") {
            assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::validate(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::schema<T0>(v1), &arg2), 13);
        };
        let (v4, v5, v6) = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::propose_data<T0>(v1, 0x2::coin::into_balance<T0>(arg1), arg2, 0x2::tx_context::sender(arg4), arg3);
        let v7 = DataProposed{
            query_id      : v0,
            proposer      : v4,
            data          : arg2,
            bond_amount   : v5,
            expires_at_ms : v6,
        };
        0x2::event::emit<DataProposed>(v7);
        (v0, v4, arg2, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::creator_witness<T0>(v1))
    }

    public fun propose_data_with_callback<T0>(arg0: &mut Query<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::DataProposed {
        let (v0, v1, v2, v3) = propose_data_internal<T0>(arg0, arg1, arg2, arg3, arg4);
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::new_data_proposed(v0, v1, v2, v3)
    }

    public fun proposer<T0>(arg0: &mut Query<T0>) : 0x1::option::Option<address> {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::proposer<T0>(load_inner<T0>(arg0))
    }

    public fun refund_address<T0>(arg0: &mut Query<T0>) : 0x1::option::Option<address> {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::refund_address<T0>(load_inner<T0>(arg0))
    }

    public fun resolved_data<T0>(arg0: &mut Query<T0>) : 0x1::option::Option<vector<u8>> {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::resolved_data<T0>(load_inner<T0>(arg0))
    }

    public fun resolver_id<T0>(arg0: &mut Query<T0>) : 0x2::object::ID {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::resolver_id<T0>(load_inner<T0>(arg0))
    }

    public fun reward_balance<T0>(arg0: &mut Query<T0>) : u64 {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::reward_balance<T0>(load_inner<T0>(arg0))
    }

    public fun set_liveness_ms<T0, T1: drop>(arg0: &mut Query<T0>, arg1: T1, arg2: &mut 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::Protocol, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock) {
        let v0 = load_inner_mut<T0>(arg0);
        assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state<T0>(v0, arg4) == 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state_created(), 4);
        assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::creator_witness<T0>(v0) == 0x1::type_name::with_defining_ids<T1>(), 10);
        let v1 = 0x1::option::destroy_with_default<u64>(arg3, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::default_liveness_ms(arg2));
        assert!(v1 >= 300000, 1);
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::set_liveness_ms<T0>(v0, v1);
    }

    public fun set_refund_address<T0, T1: drop>(arg0: &mut Query<T0>, arg1: T1, arg2: 0x1::option::Option<address>, arg3: &0x2::clock::Clock) {
        let v0 = load_inner_mut<T0>(arg0);
        assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state<T0>(v0, arg3) == 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state_created(), 4);
        assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::creator_witness<T0>(v0) == 0x1::type_name::with_defining_ids<T1>(), 10);
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::set_refund_address<T0>(v0, arg2);
    }

    public fun settle<T0>(arg0: &mut Query<T0>, arg1: 0x1::option::Option<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::Resolution>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, _) = settle_internal<T0>(arg0, arg1, arg2, arg3);
        let v5 = QuerySettled{
            query_id      : v0,
            resolved_data : v3,
            winner        : v1,
            total_payout  : v2,
        };
        0x2::event::emit<QuerySettled>(v5);
    }

    fun settle_internal<T0>(arg0: &mut Query<T0>, arg1: 0x1::option::Option<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::Resolution>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, address, u64, vector<u8>, 0x1::type_name::TypeName) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = load_inner_mut<T0>(arg0);
        let v2 = &arg1;
        if (0x1::option::is_some<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::Resolution>(v2)) {
            let v3 = 0x1::option::borrow<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::Resolution>(v2);
            assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::resolution_query_id(v3) == v0, 12);
            let v4 = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::resolution_data(v3);
            assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::validate(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::schema<T0>(v1), &v4), 13);
        };
        let (v5, v6, v7) = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::settle<T0>(v1, arg1, arg2, arg3);
        (v0, v5, v6, v7, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::creator_witness<T0>(v1))
    }

    public fun settle_with_callback<T0>(arg0: &mut Query<T0>, arg1: 0x1::option::Option<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::Resolution>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::QuerySettled {
        let (v0, v1, v2, v3, v4) = settle_internal<T0>(arg0, arg1, arg2, arg3);
        let v5 = QuerySettled{
            query_id      : v0,
            resolved_data : v3,
            winner        : v1,
            total_payout  : v2,
        };
        0x2::event::emit<QuerySettled>(v5);
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::new_query_settled(v0, v3, v4)
    }

    public fun state<T0>(arg0: &mut Query<T0>, arg1: &0x2::clock::Clock) : 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::State {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state<T0>(load_inner<T0>(arg0), arg1)
    }

    public fun state_created() : 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::State {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state_created()
    }

    public fun state_disputed() : 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::State {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state_disputed()
    }

    public fun state_expired() : 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::State {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state_expired()
    }

    public fun state_proposed() : 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::State {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state_proposed()
    }

    public fun state_resolved() : 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::State {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state_resolved()
    }

    public fun state_settled() : 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::State {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::state_settled()
    }

    public fun topic<T0>(arg0: &mut Query<T0>) : vector<u8> {
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query_inner::topic<T0>(load_inner<T0>(arg0))
    }

    // decompiled from Move bytecode v6
}

