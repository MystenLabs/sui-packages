module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate {
    struct DynamicRateInfo has store {
        dynamic_rate: u64,
        is_positive: bool,
        cum_positive: u64,
        cum_negative: u64,
        num_calcs: u64,
        last_calc_timestamp: u64,
    }

    struct Config has store {
        base_rate: u64,
        max_value: u64,
        deduction_interval: u64,
        dynamic_calc_interval: u64,
    }

    struct FundingRateInfo has copy, drop, store {
        funding_rate: u64,
        is_positive: bool,
        mark_price: u64,
        timestamp: u64,
    }

    struct FundingRate<phantom T0> has store, key {
        id: 0x2::object::UID,
        config: Config,
        dynamic_rate_info: DynamicRateInfo,
        funding_rate_history: 0x2::linked_table::LinkedTable<u64, FundingRateInfo>,
        last_deduction_timestamp: u64,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : (FundingRate<T0>, 0x2::object::ID) {
        let v0 = Config{
            base_rate             : 0,
            max_value             : 0,
            deduction_interval    : 0,
            dynamic_calc_interval : 0,
        };
        let v1 = DynamicRateInfo{
            dynamic_rate        : 0,
            is_positive         : true,
            cum_positive        : 0,
            cum_negative        : 0,
            num_calcs           : 0,
            last_calc_timestamp : 0,
        };
        let v2 = FundingRate<T0>{
            id                       : 0x2::object::new(arg0),
            config                   : v0,
            dynamic_rate_info        : v1,
            funding_rate_history     : 0x2::linked_table::new<u64, FundingRateInfo>(arg0),
            last_deduction_timestamp : 0,
        };
        (v2, *0x2::object::uid_as_inner(&v2.id))
    }

    public fun base_rate<T0>(arg0: &FundingRate<T0>) : u64 {
        arg0.config.base_rate
    }

    fun calculate_dynamic_rate<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (u64, bool) {
        let (v0, v1) = get_ob_execution_prices<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v2 = if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        };
        let v3 = if (arg1 > v1) {
            arg1 - v1
        } else {
            0
        };
        let (v4, v5) = if (v2 > v3) {
            (((v2 - v3) as u128) * (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::funding_rate_scaling() as u128) / (arg1 as u128), true)
        } else {
            (((v3 - v2) as u128) * (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::funding_rate_scaling() as u128) / (arg1 as u128), false)
        };
        ((v4 as u64), v5)
    }

    fun calculate_funding_rate(arg0: u64, arg1: u64, arg2: bool) : (u64, bool) {
        if (arg2) {
            (arg0 + arg1, true)
        } else if (arg0 > arg1) {
            (arg0 - arg1, true)
        } else {
            (arg1 - arg0, false)
        }
    }

    public fun deduction_interval<T0>(arg0: &FundingRate<T0>) : u64 {
        arg0.config.deduction_interval
    }

    public fun dynamic_calc_interval<T0>(arg0: &FundingRate<T0>) : u64 {
        arg0.config.dynamic_calc_interval
    }

    public fun get_funding_data_since_timestamp<T0>(arg0: u64, arg1: &FundingRate<T0>) : vector<FundingRateInfo> {
        let v0 = 0x1::vector::empty<FundingRateInfo>();
        let v1 = 0;
        let v2 = if (arg0 > 0) {
            *0x2::linked_table::next<u64, FundingRateInfo>(&arg1.funding_rate_history, arg0)
        } else {
            *0x2::linked_table::front<u64, FundingRateInfo>(&arg1.funding_rate_history)
        };
        let v3 = v2;
        while (v1 < 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::funding_rate_data_iteration_limit() && 0x1::option::is_some<u64>(&v3)) {
            let v4 = 0x1::option::extract<u64>(&mut v3);
            0x1::vector::push_back<FundingRateInfo>(&mut v0, *0x2::linked_table::borrow<u64, FundingRateInfo>(&arg1.funding_rate_history, v4));
            v1 = v1 + 1;
            v3 = *0x2::linked_table::next<u64, FundingRateInfo>(&arg1.funding_rate_history, v4);
        };
        v0
    }

    public fun get_funding_info_data(arg0: &FundingRateInfo) : (u64, bool, u64, u64) {
        (arg0.funding_rate, arg0.is_positive, arg0.mark_price, arg0.timestamp)
    }

    public fun get_last_dynamic_rate<T0>(arg0: &FundingRate<T0>) : (u64, bool, u64) {
        (arg0.dynamic_rate_info.dynamic_rate, arg0.dynamic_rate_info.is_positive, arg0.dynamic_rate_info.last_calc_timestamp)
    }

    public fun get_last_funding_rate<T0>(arg0: &FundingRate<T0>) : (u64, bool, u64) {
        let v0 = 0x2::linked_table::back<u64, FundingRateInfo>(&arg0.funding_rate_history);
        if (!0x1::option::is_some<u64>(v0)) {
            return (0, true, 0)
        };
        let v1 = *v0;
        let v2 = 0x2::linked_table::borrow<u64, FundingRateInfo>(&arg0.funding_rate_history, 0x1::option::extract<u64>(&mut v1));
        (v2.funding_rate, v2.is_positive, v2.timestamp)
    }

    fun get_ob_execution_prices<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        if (!0x1::option::is_some<u64>(&v3) || !0x1::option::is_some<u64>(&v2)) {
            return (0, 0)
        };
        let v4 = (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::funding_impact_notional_usdc() as u128) * ((arg2 * 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::pr_price_scaling()) as u128) / (arg1 as u128);
        let v5 = 0x1::option::extract<u64>(&mut v3);
        let v6 = 5 * v5 / 100;
        let v7 = v6 - v6 % arg3;
        let v8 = v5;
        let v9 = v5 - v7;
        let v10 = 0;
        let v11 = 0;
        while (v11 < v4) {
            let (v12, v13) = 0xdee9::clob_v2::get_level2_book_status_bid_side<T0, T1>(arg0, v9, v8, arg4);
            let v14 = v13;
            let v15 = v12;
            if (0x1::vector::length<u64>(&v15) == 0) {
                break
            };
            let v16 = 0;
            while (v16 < 0x1::vector::length<u64>(&v15)) {
                let v17 = (*0x1::vector::borrow<u64>(&v15, v16) as u128);
                let v18 = (*0x1::vector::borrow<u64>(&v14, v16) as u128);
                if (v18 + v11 >= v4) {
                    let v19 = v10 * v11 + v17 * (v4 - v11);
                    v10 = v19 / v4;
                    v11 = v4;
                    break
                };
                let v20 = v10 * v11 + v17 * v18;
                v10 = v20 / (v11 + v18);
                v11 = v11 + v18;
                v16 = v16 + 1;
            };
            v8 = v9 - arg3;
            v9 = v8 - v7;
        };
        let v21 = 0x1::option::extract<u64>(&mut v2);
        let v22 = 5 * v21 / 100;
        let v23 = v22 - v22 % arg3;
        let v24 = v21 + v23;
        let v25 = 0;
        let v26 = 0;
        while (v26 < v4) {
            let (v27, v28) = 0xdee9::clob_v2::get_level2_book_status_ask_side<T0, T1>(arg0, v21, v24, arg4);
            let v29 = v28;
            let v30 = v27;
            if (0x1::vector::length<u64>(&v30) == 0) {
                break
            };
            let v31 = 0;
            while (v31 < 0x1::vector::length<u64>(&v30)) {
                let v32 = (*0x1::vector::borrow<u64>(&v30, v31) as u128);
                let v33 = (*0x1::vector::borrow<u64>(&v29, v31) as u128);
                if (v33 + v26 >= v4) {
                    let v34 = v25 * v26 + v32 * (v4 - v26);
                    v25 = v34 / v4;
                    v26 = v4;
                    break
                };
                let v35 = v25 * v26 + v32 * v33;
                v25 = v35 / (v26 + v33);
                v26 = v26 + v33;
                v31 = v31 + 1;
            };
            let v36 = v24 + arg3;
            v21 = v36;
            v24 = v36 + v23;
        };
        (((v25 * ((0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::pr_price_scaling() / 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::db_price_scaling(arg2)) as u128)) as u64), ((v10 * ((0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::pr_price_scaling() / 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::db_price_scaling(arg2)) as u128)) as u64))
    }

    public fun max_value<T0>(arg0: &FundingRate<T0>) : u64 {
        arg0.config.max_value
    }

    public(friend) fun prune_history<T0>(arg0: &mut FundingRate<T0>, arg1: u64) {
        let v0 = 0x2::linked_table::front<u64, FundingRateInfo>(&arg0.funding_rate_history);
        while (0x1::option::is_some<u64>(v0)) {
            let v1 = *v0;
            let v2 = 0x1::option::extract<u64>(&mut v1);
            if (0x2::linked_table::borrow<u64, FundingRateInfo>(&arg0.funding_rate_history, v2).timestamp >= arg1) {
                break
            };
            let (_, _) = 0x2::linked_table::pop_front<u64, FundingRateInfo>(&mut arg0.funding_rate_history);
            v0 = 0x2::linked_table::next<u64, FundingRateInfo>(&arg0.funding_rate_history, v2);
        };
    }

    public(friend) fun set_config<T0>(arg0: &mut FundingRate<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        arg0.config.base_rate = arg1;
        arg0.config.deduction_interval = arg3;
        arg0.config.dynamic_calc_interval = arg4;
        arg0.config.max_value = arg2;
    }

    public(friend) fun set_dynamic_rate<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: &mut FundingRate<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg1.dynamic_rate_info.last_calc_timestamp == 0 || arg1.dynamic_rate_info.last_calc_timestamp - 0x2::clock::timestamp_ms(arg5) > arg1.config.dynamic_calc_interval, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::invalid_funding_deduction_timestamp());
        let (v0, v1) = calculate_dynamic_rate<T0, T1>(arg0, arg2, arg3, arg4, arg5);
        let v2 = v0;
        if (v0 > arg1.config.max_value) {
            v2 = arg1.config.max_value;
        };
        let v3 = &mut arg1.dynamic_rate_info;
        if (v3.num_calcs == 0) {
            v3.dynamic_rate = v2;
            v3.is_positive = v1;
            v3.num_calcs = 1;
            if (v1) {
                v3.cum_positive = v2;
            } else {
                v3.cum_negative = v2;
            };
        } else {
            v3.num_calcs = v3.num_calcs + 1;
            if (v1) {
                v3.cum_positive = v3.cum_positive + v2;
            } else {
                v3.cum_negative = v3.cum_negative + v2;
            };
            if (v3.cum_positive >= v3.cum_negative) {
                v3.dynamic_rate = (v3.cum_positive - v3.cum_negative) / v3.num_calcs;
                v3.is_positive = true;
            } else {
                v3.dynamic_rate = (v3.cum_negative - v3.cum_positive) / v3.num_calcs;
                v3.is_positive = false;
            };
        };
    }

    public(friend) fun set_funding_rate<T0>(arg0: &mut FundingRate<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) - arg0.last_deduction_timestamp > arg0.config.deduction_interval, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::invalid_funding_deduction_timestamp());
        let v0 = &mut arg0.dynamic_rate_info.dynamic_rate;
        let v1 = &mut arg0.dynamic_rate_info.is_positive;
        let (v2, v3) = calculate_funding_rate(arg0.config.base_rate, *v0, *v1);
        *v0 = 0;
        *v1 = true;
        arg0.dynamic_rate_info.cum_positive = 0;
        arg0.dynamic_rate_info.cum_negative = 0;
        arg0.dynamic_rate_info.num_calcs = 0;
        let v4 = FundingRateInfo{
            funding_rate : v2,
            is_positive  : v3,
            mark_price   : arg1,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::linked_table::push_back<u64, FundingRateInfo>(&mut arg0.funding_rate_history, 0x2::clock::timestamp_ms(arg2), v4);
    }

    // decompiled from Move bytecode v6
}

