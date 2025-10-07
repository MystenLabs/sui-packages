module 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal {
    struct Proposal<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        created_at: u64,
        state: u8,
        outcome_count: u64,
        dao_id: 0x2::object::ID,
        proposer: address,
        supply_ids: vector<0x2::object::ID>,
        amm_pools: vector<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool>,
        escrow_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        title: 0x1::string::String,
        details: 0x1::string::String,
        metadata: 0x1::string::String,
        outcome_messages: vector<0x1::string::String>,
        twap_prices: vector<u128>,
        last_twap_update: u64,
        review_period_ms: u64,
        trading_period_ms: u64,
        min_asset_liquidity: u64,
        min_stable_liquidity: u64,
        twap_threshold: u64,
        winning_outcome: 0x1::option::Option<u64>,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        proposer: address,
        outcome_count: u64,
        outcome_messages: vector<0x1::string::String>,
        created_at: u64,
        market_state_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        asset_value: u64,
        stable_value: u64,
        asset_type: 0x1::ascii::String,
        stable_type: 0x1::ascii::String,
        review_period_ms: u64,
        trading_period_ms: u64,
        title: 0x1::string::String,
        details: 0x1::string::String,
        metadata: 0x1::string::String,
        initial_outcome_amounts: 0x1::option::Option<vector<u64>>,
        twap_start_delay: u64,
        twap_initial_observation: u128,
        twap_step_max: u64,
        twap_threshold: u64,
        oracle_ids: vector<0x2::object::ID>,
    }

    public fun get_id<T0, T1>(arg0: &Proposal<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun create<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: vector<0x1::string::String>, arg12: u64, arg13: u128, arg14: u64, arg15: 0x1::option::Option<vector<u64>>, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, u8) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::balance::value<T1>(&arg3);
        assert!(v0 >= arg6, 4);
        assert!(v1 >= arg7, 5);
        let (v2, v3) = if (0x1::option::is_some<vector<u64>>(&arg15)) {
            let v4 = 0x1::option::destroy_some<vector<u64>>(arg15);
            assert!(0x1::vector::length<u64>(&v4) == arg1 * 2, 0);
            let v5 = 0x1::vector::empty<u64>();
            let v6 = 0x1::vector::empty<u64>();
            let v7 = 0;
            let v8 = v7;
            let v9 = 0;
            let v10 = v9;
            let v11 = 0;
            while (v11 < arg1) {
                let v12 = *0x1::vector::borrow<u64>(&v4, v11 * 2);
                let v13 = *0x1::vector::borrow<u64>(&v4, v11 * 2 + 1);
                assert!(v12 >= arg6, 1);
                assert!(v13 >= arg7, 1);
                if (v12 > v7) {
                    v8 = v12;
                };
                if (v13 > v9) {
                    v10 = v13;
                };
                0x1::vector::push_back<u64>(&mut v5, v12);
                0x1::vector::push_back<u64>(&mut v6, v13);
                v11 = v11 + 1;
            };
            assert!(v8 == v0, 3);
            assert!(v10 == v1, 3);
            (v5, v6)
        } else {
            let v14 = 0x1::vector::empty<u64>();
            let v15 = 0x1::vector::empty<u64>();
            let v16 = 0;
            while (v16 < arg1) {
                0x1::vector::push_back<u64>(&mut v14, v0);
                0x1::vector::push_back<u64>(&mut v15, v1);
                v16 = v16 + 1;
            };
            (v14, v15)
        };
        let v17 = 0x2::tx_context::sender(arg18);
        let v18 = 0x2::object::new(arg18);
        let v19 = 0x2::object::uid_to_inner(&v18);
        let v20 = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::market_state::new(v19, arg0, arg1, arg11, arg17, arg18);
        let v21 = 0x2::object::id<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::market_state::MarketState>(&v20);
        let v22 = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::new<T0, T1>(v20, arg18);
        let v23 = 0x2::object::id<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>>(&v22);
        assert!(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::get_market_state_id<T0, T1>(&v22) == v21, 2);
        let (v24, v25) = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::liquidity_initialize::create_outcome_markets<T0, T1>(&mut v22, arg1, v2, v3, arg12, arg13, arg14, arg2, arg3, arg17, arg18);
        let v26 = Proposal<T0, T1>{
            id                   : v18,
            created_at           : 0x2::clock::timestamp_ms(arg17),
            state                : 0,
            outcome_count        : arg1,
            dao_id               : arg0,
            proposer             : v17,
            supply_ids           : v24,
            amm_pools            : v25,
            escrow_id            : v23,
            market_state_id      : v21,
            title                : arg8,
            details              : arg9,
            metadata             : arg10,
            outcome_messages     : arg11,
            twap_prices          : 0x1::vector::empty<u128>(),
            last_twap_update     : 0x2::clock::timestamp_ms(arg17),
            review_period_ms     : arg4,
            trading_period_ms    : arg5,
            min_asset_liquidity  : arg6,
            min_stable_liquidity : arg7,
            twap_threshold       : arg16,
            winning_outcome      : 0x1::option::none<u64>(),
        };
        let v27 = &v26.amm_pools;
        let v28 = 0x1::vector::empty<0x2::object::ID>();
        let v29 = 0;
        while (v29 < 0x1::vector::length<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool>(v27)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v28, 0x2::object::uid_to_inner(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::oracle::get_id(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::get_oracle(0x1::vector::borrow<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool>(v27, v29)))));
            v29 = v29 + 1;
        };
        let v30 = ProposalCreated{
            proposal_id              : v19,
            dao_id                   : arg0,
            proposer                 : v17,
            outcome_count            : arg1,
            outcome_messages         : arg11,
            created_at               : v26.created_at,
            market_state_id          : v21,
            escrow_id                : v23,
            asset_value              : v0,
            stable_value             : v1,
            asset_type               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            stable_type              : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            review_period_ms         : arg4,
            trading_period_ms        : arg5,
            title                    : arg8,
            details                  : arg9,
            metadata                 : arg10,
            initial_outcome_amounts  : arg15,
            twap_start_delay         : arg12,
            twap_initial_observation : arg13,
            twap_step_max            : arg14,
            twap_threshold           : arg16,
            oracle_ids               : v28,
        };
        0x2::event::emit<ProposalCreated>(v30);
        0x2::transfer::public_share_object<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>>(v22);
        0x2::transfer::public_share_object<Proposal<T0, T1>>(v26);
        (v19, v21, v26.state)
    }

    public fun created_at<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.created_at
    }

    public fun escrow_id<T0, T1>(arg0: &Proposal<T0, T1>) : 0x2::object::ID {
        arg0.escrow_id
    }

    public fun get_amm_pool_ids<T0, T1>(arg0: &Proposal<T0, T1>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool>(&arg0.amm_pools)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::get_id(0x1::vector::borrow<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool>(&arg0.amm_pools, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_amm_pools<T0, T1>(arg0: &Proposal<T0, T1>) : &vector<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool> {
        &arg0.amm_pools
    }

    public(friend) fun get_amm_pools_mut<T0, T1>(arg0: &mut Proposal<T0, T1>) : &mut vector<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool> {
        &mut arg0.amm_pools
    }

    public fun get_created_at<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.created_at
    }

    public fun get_dao_id<T0, T1>(arg0: &Proposal<T0, T1>) : 0x2::object::ID {
        arg0.dao_id
    }

    public fun get_details<T0, T1>(arg0: &Proposal<T0, T1>) : &0x1::string::String {
        &arg0.details
    }

    public fun get_last_twap_update<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.last_twap_update
    }

    public fun get_metadata<T0, T1>(arg0: &Proposal<T0, T1>) : &0x1::string::String {
        &arg0.metadata
    }

    fun get_pool_mut(arg0: &mut vector<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool>, arg1: u8) : &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool>(arg0, v0);
            if (0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::get_outcome_idx(v1) == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 6
    }

    public(friend) fun get_pool_mut_by_outcome<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u8) : &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool {
        assert!((arg1 as u64) < arg0.outcome_count, 7);
        let v0 = &mut arg0.amm_pools;
        get_pool_mut(v0, arg1)
    }

    public fun get_review_period_ms<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.review_period_ms
    }

    public fun get_state<T0, T1>(arg0: &Proposal<T0, T1>) : u8 {
        arg0.state
    }

    public fun get_trading_period_ms<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.trading_period_ms
    }

    public fun get_twap_prices<T0, T1>(arg0: &Proposal<T0, T1>) : &vector<u128> {
        &arg0.twap_prices
    }

    public fun get_twap_threshold<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.twap_threshold
    }

    public fun get_twaps_for_proposal<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: &0x2::clock::Clock) : vector<u128> {
        let v0 = &mut arg0.amm_pools;
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool>(v0)) {
            0x1::vector::push_back<u128>(&mut v1, 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::get_twap(0x1::vector::borrow_mut<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool>(v0, v2), arg1));
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_winning_outcome<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        assert!(0x1::option::is_some<u64>(&arg0.winning_outcome), 2);
        *0x1::option::borrow<u64>(&arg0.winning_outcome)
    }

    public fun is_finalized<T0, T1>(arg0: &Proposal<T0, T1>) : bool {
        arg0.state == 2
    }

    public fun is_winning_outcome_set<T0, T1>(arg0: &Proposal<T0, T1>) : bool {
        0x1::option::is_some<u64>(&arg0.winning_outcome)
    }

    public fun market_state_id<T0, T1>(arg0: &Proposal<T0, T1>) : 0x2::object::ID {
        arg0.market_state_id
    }

    public fun outcome_count<T0, T1>(arg0: &Proposal<T0, T1>) : u64 {
        arg0.outcome_count
    }

    public fun proposal_id<T0, T1>(arg0: &Proposal<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun proposer<T0, T1>(arg0: &Proposal<T0, T1>) : address {
        arg0.proposer
    }

    public(friend) fun set_last_twap_update<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64) {
        arg0.last_twap_update = arg1;
    }

    public(friend) fun set_state<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u8) {
        arg0.state = arg1;
    }

    public(friend) fun set_twap_prices<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: vector<u128>) {
        arg0.twap_prices = arg1;
    }

    public(friend) fun set_winning_outcome<T0, T1>(arg0: &mut Proposal<T0, T1>, arg1: u64) {
        arg0.winning_outcome = 0x1::option::some<u64>(arg1);
    }

    public fun state<T0, T1>(arg0: &Proposal<T0, T1>) : u8 {
        arg0.state
    }

    // decompiled from Move bytecode v6
}

