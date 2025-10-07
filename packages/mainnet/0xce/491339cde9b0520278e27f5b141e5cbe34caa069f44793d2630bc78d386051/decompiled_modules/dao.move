module 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::dao {
    struct DAO has store, key {
        id: 0x2::object::UID,
        asset_type: 0x1::ascii::String,
        stable_type: 0x1::ascii::String,
        min_asset_amount: u64,
        min_stable_amount: u64,
        proposals: 0x2::table::Table<0x2::object::ID, ProposalInfo>,
        active_proposal_count: u64,
        total_proposals: u64,
        creation_time: u64,
        amm_twap_start_delay: u64,
        amm_twap_step_max: u64,
        amm_twap_initial_observation: u128,
        twap_threshold: u64,
        dao_name: 0x1::ascii::String,
        icon_url: 0x2::url::Url,
        asset_decimals: u8,
        stable_decimals: u8,
        asset_name: 0x1::string::String,
        stable_name: 0x1::string::String,
        asset_icon_url: 0x1::ascii::String,
        stable_icon_url: 0x1::ascii::String,
        asset_symbol: 0x1::ascii::String,
        stable_symbol: 0x1::ascii::String,
        review_period_ms: u64,
        trading_period_ms: u64,
        attestation_url: 0x1::string::String,
        verification_pending: bool,
        verified: bool,
        proposal_creation_enabled: bool,
        description: 0x1::string::String,
    }

    struct ProposalInfo has store {
        proposer: address,
        created_at: u64,
        state: u8,
        outcome_count: u64,
        description: 0x1::string::String,
        result: 0x1::option::Option<0x1::string::String>,
        execution_time: 0x1::option::Option<u64>,
        executed: bool,
        market_state_id: 0x2::object::ID,
    }

    struct DAOCreated has copy, drop {
        dao_id: 0x2::object::ID,
        min_asset_amount: u64,
        min_stable_amount: u64,
        timestamp: u64,
        asset_type: 0x1::ascii::String,
        stable_type: 0x1::ascii::String,
        dao_name: 0x1::ascii::String,
        icon_url: 0x2::url::Url,
        asset_decimals: u8,
        stable_decimals: u8,
        asset_name: 0x1::string::String,
        stable_name: 0x1::string::String,
        asset_icon_url: 0x1::ascii::String,
        stable_icon_url: 0x1::ascii::String,
        asset_symbol: 0x1::ascii::String,
        stable_symbol: 0x1::ascii::String,
        review_period_ms: u64,
        trading_period_ms: u64,
        amm_twap_start_delay: u64,
        amm_twap_step_max: u64,
        amm_twap_initial_observation: u128,
        twap_threshold: u64,
        description: 0x1::string::String,
    }

    struct ResultSigned has copy, drop {
        dao_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        outcome: 0x1::string::String,
        winning_outcome: u64,
        timestamp: u64,
    }

    public fun are_proposals_enabled(arg0: &DAO) : bool {
        arg0.proposal_creation_enabled
    }

    public(friend) fun create<T0, T1>(arg0: u64, arg1: u64, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: u64, arg15: u64, arg16: u128, arg17: u64, arg18: 0x1::string::String, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 1000 && arg1 > 1000, 5);
        0x2::coin::destroy_zero<T0>(0x2::coin::zero<T0>(arg20));
        0x2::coin::destroy_zero<T1>(0x2::coin::zero<T1>(arg20));
        let v0 = if (0x1::ascii::is_empty(&arg3)) {
            0x2::url::new_unsafe(arg10)
        } else {
            0x2::url::new_unsafe(arg3)
        };
        let v1 = 0x2::clock::timestamp_ms(arg19);
        assert!(arg7 >= arg6 && arg7 - arg6 <= 9 || arg6 - arg7 <= 9, 13);
        assert!(arg7 <= 21, 10);
        assert!(arg6 <= 21, 10);
        assert!(arg14 % 60000 == 0, 20);
        assert!(0x1::string::length(&arg18) <= 1024, 21);
        let v2 = DAO{
            id                           : 0x2::object::new(arg20),
            asset_type                   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            stable_type                  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            min_asset_amount             : arg0,
            min_stable_amount            : arg1,
            proposals                    : 0x2::table::new<0x2::object::ID, ProposalInfo>(arg20),
            active_proposal_count        : 0,
            total_proposals              : 0,
            creation_time                : v1,
            amm_twap_start_delay         : arg14,
            amm_twap_step_max            : arg15,
            amm_twap_initial_observation : arg16,
            twap_threshold               : arg17,
            dao_name                     : arg2,
            icon_url                     : v0,
            asset_decimals               : arg6,
            stable_decimals              : arg7,
            asset_name                   : arg8,
            stable_name                  : arg9,
            asset_icon_url               : arg10,
            stable_icon_url              : arg11,
            asset_symbol                 : arg12,
            stable_symbol                : arg13,
            review_period_ms             : arg4,
            trading_period_ms            : arg5,
            attestation_url              : 0x1::string::utf8(b""),
            verification_pending         : false,
            verified                     : false,
            proposal_creation_enabled    : true,
            description                  : arg18,
        };
        let v3 = DAOCreated{
            dao_id                       : 0x2::object::uid_to_inner(&v2.id),
            min_asset_amount             : arg0,
            min_stable_amount            : arg1,
            timestamp                    : v1,
            asset_type                   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            stable_type                  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            dao_name                     : arg2,
            icon_url                     : v0,
            asset_decimals               : arg6,
            stable_decimals              : arg7,
            asset_name                   : arg8,
            stable_name                  : arg9,
            asset_icon_url               : arg10,
            stable_icon_url              : arg11,
            asset_symbol                 : arg12,
            stable_symbol                : arg13,
            review_period_ms             : arg4,
            trading_period_ms            : arg5,
            amm_twap_start_delay         : arg14,
            amm_twap_step_max            : arg15,
            amm_twap_initial_observation : arg16,
            twap_threshold               : arg17,
            description                  : arg18,
        };
        0x2::event::emit<DAOCreated>(v3);
        0x2::transfer::public_share_object<DAO>(v2);
    }

    public entry fun create_proposal<T0, T1>(arg0: &mut DAO, arg1: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::fee::FeeManager, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<0x1::string::String>, arg10: 0x1::option::Option<vector<u64>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.proposal_creation_enabled, 11);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::fee::deposit_proposal_creation_payment(arg1, arg2, arg11, arg12);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(&v0 == &arg0.asset_type, 8);
        assert!(&v1 == &arg0.stable_type, 9);
        assert!(arg3 >= 2 && arg3 <= 3, 3);
        assert!(0x2::coin::value<T0>(&arg4) >= arg0.min_asset_amount, 0);
        assert!(0x2::coin::value<T1>(&arg5) >= arg0.min_stable_amount, 0);
        assert!(0x1::vector::length<0x1::string::String>(&arg9) == arg3, 7);
        let v2 = 0x1::string::utf8(b"Reject");
        assert!(0x1::vector::borrow<0x1::string::String>(&arg9, 0) == &v2, 7);
        if (arg3 == 2) {
            let v3 = 0x1::string::utf8(b"Accept");
            assert!(0x1::vector::borrow<0x1::string::String>(&arg9, 1) == &v3, 7);
        };
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::vectors::check_valid_outcomes(arg9, 1024), 12);
        assert!(0x1::string::length(&arg6) <= 512, 17);
        assert!(0x1::string::length(&arg8) <= 1024, 14);
        assert!(0x1::string::length(&arg7) <= 16384, 15);
        assert!(0x1::string::length(&arg6) > 0, 16);
        assert!(0x1::string::length(&arg7) > 0, 18);
        assert!(arg3 > 1, 19);
        let (v4, v5, v6) = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::proposal::create<T0, T1>(0x2::object::uid_to_inner(&arg0.id), arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg0.review_period_ms, arg0.trading_period_ms, arg0.min_asset_amount, arg0.min_stable_amount, arg6, arg7, arg8, arg9, arg0.amm_twap_start_delay, arg0.amm_twap_initial_observation, arg0.amm_twap_step_max, arg10, arg0.twap_threshold, arg11, arg12);
        let v7 = ProposalInfo{
            proposer        : 0x2::tx_context::sender(arg12),
            created_at      : 0x2::clock::timestamp_ms(arg11),
            state           : v6,
            outcome_count   : arg3,
            description     : arg6,
            result          : 0x1::option::none<0x1::string::String>(),
            execution_time  : 0x1::option::none<u64>(),
            executed        : false,
            market_state_id : v5,
        };
        assert!(!0x2::table::contains<0x2::object::ID, ProposalInfo>(&arg0.proposals, v4), 1);
        0x2::table::add<0x2::object::ID, ProposalInfo>(&mut arg0.proposals, v4, v7);
        arg0.active_proposal_count = arg0.active_proposal_count + 1;
        arg0.total_proposals = arg0.total_proposals + 1;
    }

    public(friend) fun disable_proposals(arg0: &mut DAO) {
        arg0.proposal_creation_enabled = false;
    }

    public fun get_amm_config(arg0: &DAO) : (u64, u64, u128) {
        (arg0.amm_twap_start_delay, arg0.amm_twap_step_max, arg0.amm_twap_initial_observation)
    }

    public fun get_asset_type(arg0: &DAO) : &0x1::ascii::String {
        &arg0.asset_type
    }

    public fun get_attestation_url(arg0: &DAO) : &0x1::string::String {
        &arg0.attestation_url
    }

    public fun get_created_at(arg0: &ProposalInfo) : u64 {
        arg0.created_at
    }

    public fun get_description(arg0: &ProposalInfo) : &0x1::string::String {
        &arg0.description
    }

    public fun get_execution_time(arg0: &ProposalInfo) : 0x1::option::Option<u64> {
        arg0.execution_time
    }

    public fun get_min_amounts(arg0: &DAO) : (u64, u64) {
        (arg0.min_asset_amount, arg0.min_stable_amount)
    }

    public fun get_name(arg0: &DAO) : &0x1::ascii::String {
        &arg0.dao_name
    }

    public fun get_proposal_info(arg0: &DAO, arg1: 0x2::object::ID) : &ProposalInfo {
        assert!(0x2::table::contains<0x2::object::ID, ProposalInfo>(&arg0.proposals, arg1), 4);
        0x2::table::borrow<0x2::object::ID, ProposalInfo>(&arg0.proposals, arg1)
    }

    public fun get_proposer(arg0: &ProposalInfo) : address {
        arg0.proposer
    }

    public fun get_result(arg0: &ProposalInfo) : &0x1::option::Option<0x1::string::String> {
        &arg0.result
    }

    public fun get_stable_type(arg0: &DAO) : &0x1::ascii::String {
        &arg0.stable_type
    }

    public fun get_stats(arg0: &DAO) : (u64, u64, u64) {
        (arg0.active_proposal_count, arg0.total_proposals, arg0.creation_time)
    }

    public fun get_types(arg0: &DAO) : (&0x1::ascii::String, &0x1::ascii::String) {
        (&arg0.asset_type, &arg0.stable_type)
    }

    public fun is_executed(arg0: &ProposalInfo) : bool {
        arg0.executed
    }

    public fun is_verification_pending(arg0: &DAO) : bool {
        arg0.verification_pending
    }

    public fun is_verified(arg0: &DAO) : bool {
        arg0.verified
    }

    public(friend) fun set_pending_verification(arg0: &mut DAO, arg1: 0x1::string::String) {
        arg0.attestation_url = arg1;
        arg0.verification_pending = true;
    }

    public(friend) fun set_verification(arg0: &mut DAO, arg1: 0x1::string::String, arg2: bool) {
        if (arg2) {
            arg0.attestation_url = arg1;
        } else {
            arg0.attestation_url = 0x1::string::utf8(b"");
        };
        arg0.verification_pending = false;
        arg0.verified = arg2;
    }

    public(friend) fun sign_result(arg0: &mut DAO, arg1: 0x2::object::ID, arg2: &0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, ProposalInfo>(&arg0.proposals, arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, ProposalInfo>(&mut arg0.proposals, arg1);
        assert!(!v0.executed, 6);
        assert!(0x2::object::id<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState>(arg2) == v0.market_state_id, 2);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(arg2) == arg1, 2);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::dao_id(arg2) == 0x2::object::uid_to_inner(&arg0.id), 2);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_market_finalized(arg2);
        let v1 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::get_winning_outcome(arg2);
        let v2 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::get_outcome_message(arg2, v1);
        0x1::option::fill<0x1::string::String>(&mut v0.result, v2);
        v0.executed = true;
        v0.execution_time = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg3));
        if (arg0.active_proposal_count > 0) {
            arg0.active_proposal_count = arg0.active_proposal_count - 1;
        };
        let v3 = ResultSigned{
            dao_id          : 0x2::object::uid_to_inner(&arg0.id),
            proposal_id     : arg1,
            outcome         : v2,
            winning_outcome : v1,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ResultSigned>(v3);
    }

    public entry fun sign_result_entry<T0, T1>(arg0: &mut DAO, arg1: 0x2::object::ID, arg2: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::TokenEscrow<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::get_market_state_id<T0, T1>(arg2) == get_proposal_info(arg0, arg1).market_state_id, 2);
        sign_result(arg0, arg1, 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::get_market_state_mut<T0, T1>(arg2), arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

