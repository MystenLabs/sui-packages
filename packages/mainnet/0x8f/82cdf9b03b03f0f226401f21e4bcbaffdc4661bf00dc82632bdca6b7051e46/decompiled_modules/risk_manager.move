module 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager {
    struct RiskRegistry has store, key {
        id: 0x2::object::UID,
        risk_groups: 0x2::vec_map::VecMap<vector<u8>, RiskGroup>,
        protocol_to_group: 0x2::vec_map::VecMap<vector<u8>, vector<u8>>,
        mcr: 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal,
        premium_state: 0x2::vec_map::VecMap<vector<u8>, PremiumState>,
    }

    struct PremiumState has copy, drop, store {
        target_price_bps: u64,
        bumped_price_bps: u64,
        bumped_price_update_time_sec: u64,
    }

    struct RiskGroup has store {
        total_group_vc: 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal,
        correlations: 0x2::vec_map::VecMap<vector<u8>, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>,
        protocols: 0x2::vec_map::VecMap<vector<u8>, Protocol>,
    }

    struct Protocol has copy, store {
        risk_weight_bps: u64,
        leverage_factor_bps: u64,
        covered_amount: u64,
        total_staked: u64,
    }

    public fun add_group(arg0: &mut RiskRegistry, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: 0x1::string::String, arg4: 0x2::vec_map::VecMap<vector<u8>, u64>) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        let v0 = *0x1::string::as_bytes(&arg3);
        if (0x2::vec_map::contains<vector<u8>, RiskGroup>(&arg0.risk_groups, &v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_group_already_exists();
        };
        let v1 = 0x2::vec_map::empty<vector<u8>, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>();
        let v2 = 0x2::vec_map::keys<vector<u8>, RiskGroup>(&arg0.risk_groups);
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(&v2)) {
            let v4 = *0x1::vector::borrow<vector<u8>>(&v2, v3);
            let v5 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(*0x2::vec_map::get<vector<u8>, u64>(&arg4, &v4));
            0x2::vec_map::insert<vector<u8>, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&mut v1, v4, v5);
            0x2::vec_map::insert<vector<u8>, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&mut 0x2::vec_map::get_mut<vector<u8>, RiskGroup>(&mut arg0.risk_groups, &v4).correlations, v0, v5);
            v3 = v3 + 1;
        };
        let v6 = RiskGroup{
            total_group_vc : 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(0),
            correlations   : v1,
            protocols      : 0x2::vec_map::empty<vector<u8>, Protocol>(),
        };
        0x2::vec_map::insert<vector<u8>, RiskGroup>(&mut arg0.risk_groups, v0, v6);
    }

    public(friend) fun calculate_and_update_mcr(arg0: &mut RiskRegistry) {
        let v0 = 0x2::vec_map::keys<vector<u8>, RiskGroup>(&arg0.risk_groups);
        let v1 = 0x1::vector::length<vector<u8>>(&v0);
        let v2 = 0x1::vector::empty<0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>();
        let v3 = 0x1::vector::empty<0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>();
        let v4 = 0;
        while (v4 < v1) {
            0x1::vector::push_back<0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&mut v2, 0x2::vec_map::get<vector<u8>, RiskGroup>(&arg0.risk_groups, 0x1::vector::borrow<vector<u8>>(&v0, v4)).total_group_vc);
            v4 = v4 + 1;
        };
        let v5 = 0;
        while (v5 < v1) {
            let v6 = *0x1::vector::borrow<vector<u8>>(&v0, v5);
            let v7 = 0x2::vec_map::get<vector<u8>, RiskGroup>(&arg0.risk_groups, &v6);
            let v8 = v5 + 1;
            while (v8 < v1) {
                let v9 = *0x1::vector::borrow<vector<u8>>(&v0, v8);
                0x1::vector::push_back<0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&mut v3, *0x2::vec_map::get<vector<u8>, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&v7.correlations, &v9));
                v8 = v8 + 1;
            };
            v5 = v5 + 1;
        };
        arg0.mcr = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::math::calculate_mcr_pure(v2, v3);
    }

    public fun current_mcr(arg0: &RiskRegistry) : 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal {
        arg0.mcr
    }

    public fun get_protocol_premium_state(arg0: &RiskRegistry, arg1: vector<u8>) : (u64, u64, u64) {
        if (!0x2::vec_map::contains<vector<u8>, vector<u8>>(&arg0.protocol_to_group, &arg1)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_not_found();
        };
        if (!0x2::vec_map::contains<vector<u8>, PremiumState>(&arg0.premium_state, &arg1)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::vec_map::get<vector<u8>, PremiumState>(&arg0.premium_state, &arg1);
        (v0.target_price_bps, v0.bumped_price_bps, v0.bumped_price_update_time_sec)
    }

    public fun get_protocol_status(arg0: &RiskRegistry, arg1: vector<u8>) : (u64, u64, u64, u64) {
        if (!0x2::vec_map::contains<vector<u8>, vector<u8>>(&arg0.protocol_to_group, &arg1)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_not_found();
        };
        let v0 = *0x2::vec_map::get<vector<u8>, vector<u8>>(&arg0.protocol_to_group, &arg1);
        let v1 = 0x2::vec_map::get<vector<u8>, Protocol>(&0x2::vec_map::get<vector<u8>, RiskGroup>(&arg0.risk_groups, &v0).protocols, &arg1);
        (v1.covered_amount, v1.total_staked, v1.risk_weight_bps, v1.leverage_factor_bps)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RiskRegistry{
            id                : 0x2::object::new(arg0),
            risk_groups       : 0x2::vec_map::empty<vector<u8>, RiskGroup>(),
            protocol_to_group : 0x2::vec_map::empty<vector<u8>, vector<u8>>(),
            mcr               : 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(0),
            premium_state     : 0x2::vec_map::empty<vector<u8>, PremiumState>(),
        };
        0x2::transfer::public_share_object<RiskRegistry>(v0);
    }

    public fun register_protocol(arg0: &mut RiskRegistry, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (arg6 == 0) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_leverage_factor_bps();
        };
        let v0 = *0x1::string::as_bytes(&arg4);
        let v1 = *0x1::string::as_bytes(&arg3);
        if (!0x2::vec_map::contains<vector<u8>, RiskGroup>(&arg0.risk_groups, &v1)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_group_not_found();
        };
        0x2::vec_map::insert<vector<u8>, vector<u8>>(&mut arg0.protocol_to_group, v0, v1);
        let v2 = 0x2::vec_map::get_mut<vector<u8>, RiskGroup>(&mut arg0.risk_groups, &v1);
        if (0x2::vec_map::contains<vector<u8>, Protocol>(&v2.protocols, &v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_already_registered();
        };
        let v3 = Protocol{
            risk_weight_bps     : arg5,
            leverage_factor_bps : arg6,
            covered_amount      : 0,
            total_staked        : 0,
        };
        0x2::vec_map::insert<vector<u8>, Protocol>(&mut v2.protocols, v0, v3);
        let v4 = PremiumState{
            target_price_bps             : arg7,
            bumped_price_bps             : arg7,
            bumped_price_update_time_sec : 0,
        };
        0x2::vec_map::insert<vector<u8>, PremiumState>(&mut arg0.premium_state, v0, v4);
    }

    public fun set_correlation(arg0: &mut RiskRegistry, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: u64, arg4: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (arg3 == 0 || arg4 == 0) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_correlation_bps();
        };
        if (arg3 > 10000 || arg4 > 10000) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_correlation_bps();
        };
        let v0 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(arg3);
        let v1 = 0x2::vec_map::keys<vector<u8>, RiskGroup>(&arg0.risk_groups);
        let v2 = 0x1::vector::length<vector<u8>>(&v1);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<vector<u8>>(&v1, v3);
            let v5 = v3 + 1;
            while (v5 < v2) {
                let v6 = *0x1::vector::borrow<vector<u8>>(&v1, v5);
                let v7 = 0x2::vec_map::get_mut<vector<u8>, RiskGroup>(&mut arg0.risk_groups, &v4);
                if (0x2::vec_map::contains<vector<u8>, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&v7.correlations, &v6)) {
                    *0x2::vec_map::get_mut<vector<u8>, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&mut v7.correlations, &v6) = v0;
                } else {
                    0x2::vec_map::insert<vector<u8>, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&mut v7.correlations, v6, v0);
                };
                let v8 = 0x2::vec_map::get_mut<vector<u8>, RiskGroup>(&mut arg0.risk_groups, &v6);
                if (0x2::vec_map::contains<vector<u8>, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&v8.correlations, &v4)) {
                    *0x2::vec_map::get_mut<vector<u8>, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&mut v8.correlations, &v4) = v0;
                } else {
                    0x2::vec_map::insert<vector<u8>, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&mut v8.correlations, v4, v0);
                };
                v5 = v5 + 1;
            };
            v3 = v3 + 1;
        };
    }

    public fun set_protocol_target_price(arg0: &mut RiskRegistry, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: 0x1::string::String, arg4: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        let v0 = *0x1::string::as_bytes(&arg3);
        if (!0x2::vec_map::contains<vector<u8>, vector<u8>>(&arg0.protocol_to_group, &v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_not_found();
        };
        if (!0x2::vec_map::contains<vector<u8>, PremiumState>(&arg0.premium_state, &v0)) {
            let v1 = PremiumState{
                target_price_bps             : arg4,
                bumped_price_bps             : arg4,
                bumped_price_update_time_sec : 0,
            };
            0x2::vec_map::insert<vector<u8>, PremiumState>(&mut arg0.premium_state, v0, v1);
        } else {
            let v2 = 0x2::vec_map::get_mut<vector<u8>, PremiumState>(&mut arg0.premium_state, &v0);
            let v3 = v2.target_price_bps;
            let v4 = v2.bumped_price_bps;
            let v5 = if (v4 >= v3) {
                v4 - v3
            } else {
                0
            };
            v2.target_price_bps = arg4;
            v2.bumped_price_bps = arg4 + v5;
        };
    }

    public fun set_risk_weight(arg0: &mut RiskRegistry, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: 0x1::string::String, arg4: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        let v0 = *0x1::string::as_bytes(&arg3);
        if (!0x2::vec_map::contains<vector<u8>, vector<u8>>(&arg0.protocol_to_group, &v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_not_found();
        };
        let v1 = *0x2::vec_map::get<vector<u8>, vector<u8>>(&arg0.protocol_to_group, &v0);
        let v2 = 0x2::vec_map::get_mut<vector<u8>, RiskGroup>(&mut arg0.risk_groups, &v1);
        let v3 = 0x2::vec_map::get_mut<vector<u8>, Protocol>(&mut v2.protocols, &v0);
        v3.risk_weight_bps = arg4;
        v2.total_group_vc = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::sub(v2.total_group_vc, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(v3.covered_amount), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(v3.risk_weight_bps)));
        v2.total_group_vc = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::add(v2.total_group_vc, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(v3.covered_amount), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(arg4)));
    }

    public(friend) fun sync_stake_update(arg0: &mut RiskRegistry, arg1: vector<u8>, arg2: u64, arg3: bool) {
        if (!0x2::vec_map::contains<vector<u8>, vector<u8>>(&arg0.protocol_to_group, &arg1)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_not_found();
        };
        let v0 = *0x2::vec_map::get<vector<u8>, vector<u8>>(&arg0.protocol_to_group, &arg1);
        let v1 = 0x2::vec_map::get_mut<vector<u8>, Protocol>(&mut 0x2::vec_map::get_mut<vector<u8>, RiskGroup>(&mut arg0.risk_groups, &v0).protocols, &arg1);
        if (arg3) {
            v1.total_staked = v1.total_staked + arg2;
        } else {
            if (v1.total_staked < arg2) {
                0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_amount();
            };
            v1.total_staked = v1.total_staked - arg2;
        };
    }

    public(friend) fun update_coverage(arg0: &mut RiskRegistry, arg1: vector<u8>, arg2: u64, arg3: bool) {
        if (!0x2::vec_map::contains<vector<u8>, vector<u8>>(&arg0.protocol_to_group, &arg1)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_not_found();
        };
        let v0 = *0x2::vec_map::get<vector<u8>, vector<u8>>(&arg0.protocol_to_group, &arg1);
        let v1 = 0x2::vec_map::get_mut<vector<u8>, RiskGroup>(&mut arg0.risk_groups, &v0);
        let v2 = 0x2::vec_map::get_mut<vector<u8>, Protocol>(&mut v1.protocols, &arg1);
        if (arg3) {
            v2.covered_amount = v2.covered_amount + arg2;
            v1.total_group_vc = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::add(v1.total_group_vc, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg2), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(v2.risk_weight_bps)));
        } else {
            if (v2.covered_amount < arg2) {
                0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_amount();
            };
            v2.covered_amount = v2.covered_amount - arg2;
            v1.total_group_vc = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::sub(v1.total_group_vc, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg2), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(v2.risk_weight_bps)));
        };
    }

    public(friend) fun update_protocol_bumped_price(arg0: &mut RiskRegistry, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock) {
        if (!0x2::vec_map::contains<vector<u8>, PremiumState>(&arg0.premium_state, &arg1)) {
            return
        };
        let v0 = 0x2::vec_map::get_mut<vector<u8>, PremiumState>(&mut arg0.premium_state, &arg1);
        v0.bumped_price_bps = arg2;
        v0.bumped_price_update_time_sec = 0x2::clock::timestamp_ms(arg3) / 1000;
    }

    public fun update_protocol_leverage_bps(arg0: &mut RiskRegistry, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: 0x1::string::String, arg4: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (arg4 == 0) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_leverage_factor_bps();
        };
        let v0 = *0x1::string::as_bytes(&arg3);
        if (!0x2::vec_map::contains<vector<u8>, vector<u8>>(&arg0.protocol_to_group, &v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_not_found();
        };
        let v1 = *0x2::vec_map::get<vector<u8>, vector<u8>>(&arg0.protocol_to_group, &v0);
        0x2::vec_map::get_mut<vector<u8>, Protocol>(&mut 0x2::vec_map::get_mut<vector<u8>, RiskGroup>(&mut arg0.risk_groups, &v1).protocols, &v0).leverage_factor_bps = arg4;
    }

    // decompiled from Move bytecode v6
}

