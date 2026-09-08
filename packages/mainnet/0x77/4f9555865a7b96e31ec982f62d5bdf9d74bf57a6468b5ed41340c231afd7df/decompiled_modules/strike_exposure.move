module 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure {
    struct StrikeExposure has store {
        expiry_market_id: 0x2::object::ID,
        tick_size: u64,
        admission_tick_size: u64,
        reference_tick_source_timestamp_ms: u64,
        reference_tick: 0x1::option::Option<u64>,
        config: 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::StrikeExposureConfig,
        inventory_impact_scale: u64,
        next_order_sequence: u64,
        settlement_price: 0x1::option::Option<u64>,
        settled_payout_liability: u64,
        payout: 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::StrikePayoutTree,
    }

    struct MintTerms has drop {
        expiry_market_id: 0x2::object::ID,
        lower_tick: u64,
        higher_tick: u64,
        quantity: u64,
        entry_probability: u64,
        premium: u64,
        inventory_impact_charge: u64,
    }

    struct LiveCloseTerms has drop {
        expiry_market_id: 0x2::object::ID,
        order: 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::Order,
        close_quantity: u64,
        redeem_amount: u64,
        range_probability: u64,
        inventory_impact_rebate: u64,
    }

    public(friend) fun quantity(arg0: &MintTerms) : u64 {
        arg0.quantity
    }

    public(friend) fun activate_valuation_snapshot(arg0: &mut StrikeExposure, arg1: u64) {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::activate_snapshot(&mut arg0.payout, arg1);
    }

    public(friend) fun admission_tick_size(arg0: &StrikeExposure) : u64 {
        arg0.admission_tick_size
    }

    fun admitted_entry_probability(arg0: &StrikeExposure, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing::Pricer, arg2: u64, arg3: u64) : u64 {
        assert_admitted_mint_ticks(arg0, arg2, arg3);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing::range_price(arg1, 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::range_codec::strike_from_tick(arg2, arg0.tick_size), 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::range_codec::strike_from_tick(arg3, arg0.tick_size))
    }

    public(friend) fun allocate_mint_order(arg0: &mut StrikeExposure, arg1: MintTerms) : 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::Order {
        let MintTerms {
            expiry_market_id        : v0,
            lower_tick              : v1,
            higher_tick             : v2,
            quantity                : v3,
            entry_probability       : _,
            premium                 : _,
            inventory_impact_charge : _,
        } = arg1;
        assert!(v0 == arg0.expiry_market_id, 4);
        let v7 = arg0.next_order_sequence;
        arg0.next_order_sequence = v7 + 1;
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::insert_range(&mut arg0.payout, v1, v2, v3);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::new_from_ticks(v1, v2, v3, v7)
    }

    fun assert_admitted_mint_ticks(arg0: &StrikeExposure, arg1: u64, arg2: u64) {
        let v0 = arg0.admission_tick_size / arg0.tick_size;
        let v1 = if (arg1 == 0) {
            true
        } else if (arg1 % v0 == 0) {
            true
        } else {
            0x1::option::contains<u64>(&arg0.reference_tick, &arg1)
        };
        assert!(v1, 1);
        let v2 = if (arg2 == 1073741823) {
            true
        } else if (arg2 % v0 == 0) {
            true
        } else {
            0x1::option::contains<u64>(&arg0.reference_tick, &arg2)
        };
        assert!(v2, 1);
    }

    public(friend) fun backing_buffer_lambda(arg0: &StrikeExposure) : u64 {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::backing_buffer_lambda(&arg0.config)
    }

    public(friend) fun deactivate_valuation_snapshot(arg0: &mut StrikeExposure) {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::deactivate_snapshot(&mut arg0.payout);
    }

    public(friend) fun entry_probability(arg0: &MintTerms) : u64 {
        arg0.entry_probability
    }

    public(friend) fun expiry_fee_max_multiplier(arg0: &StrikeExposure) : u64 {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::expiry_fee_max_multiplier(&arg0.config)
    }

    public(friend) fun expiry_fee_window_ms(arg0: &StrikeExposure) : u64 {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::expiry_fee_window_ms(&arg0.config)
    }

    public(friend) fun frozen_marked_liability(arg0: &StrikeExposure, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing::Pricer, arg2: u64) : u64 {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::walk_linear_frozen(&arg0.payout, arg1, arg0.tick_size, arg2)
    }

    public(friend) fun inventory_impact(arg0: &StrikeExposure, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : u64 {
        if (0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::inventory_impact_max_rate(&arg0.config) == 0 || arg3 == 0) {
            return 0
        };
        let (v0, v1) = payout_liabilities_after_change(arg0, arg1, arg2, arg3, arg4);
        if (arg4) {
            inventory_impact_potential_for_liability(arg0, v1) - inventory_impact_potential_for_liability(arg0, v0)
        } else {
            inventory_impact_potential_for_liability(arg0, v0) - inventory_impact_potential_for_liability(arg0, v1)
        }
    }

    public(friend) fun inventory_impact_charge(arg0: &MintTerms) : u64 {
        arg0.inventory_impact_charge
    }

    public(friend) fun inventory_impact_max_rate(arg0: &StrikeExposure) : u64 {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::inventory_impact_max_rate(&arg0.config)
    }

    public(friend) fun inventory_impact_potential(arg0: &StrikeExposure) : u64 {
        if (is_settled(arg0) || 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::inventory_impact_max_rate(&arg0.config) == 0) {
            return 0
        };
        inventory_impact_potential_for_liability(arg0, payout_liability(arg0))
    }

    fun inventory_impact_potential_for_liability(arg0: &StrikeExposure, arg1: u64) : u64 {
        let v0 = 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::inventory_impact_max_rate(&arg0.config);
        if (v0 == 0 || arg1 == 0) {
            return 0
        };
        let v1 = arg0.inventory_impact_scale;
        let v2 = 0x1::u64::min(arg1, v1);
        if (arg1 <= v1) {
            return 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(v0, 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_div_down(v2, 1000000000, v1)), v2) / 2
        };
        0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(v0, 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_div_down(v2, 1000000000, v1)), v2) / 2 + 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(v0, arg1 - v1)
    }

    public(friend) fun inventory_impact_rebate(arg0: &LiveCloseTerms) : u64 {
        arg0.inventory_impact_rebate
    }

    public(friend) fun inventory_impact_scale(arg0: &StrikeExposure) : u64 {
        arg0.inventory_impact_scale
    }

    public(friend) fun is_settled(arg0: &StrikeExposure) : bool {
        0x1::option::is_some<u64>(&arg0.settlement_price)
    }

    public(friend) fun live_marked_liability(arg0: &StrikeExposure, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing::Pricer) : u64 {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::walk_linear(&arg0.payout, arg1, arg0.tick_size)
    }

    public(friend) fun live_order_value(arg0: &StrikeExposure, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing::Pricer, arg2: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::Order) : u64 {
        0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(order_range_price(arg0, arg1, arg2), 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::quantity(arg2))
    }

    fun live_payout_liability_from_terms(arg0: &StrikeExposure, arg1: u64, arg2: u64) : u64 {
        arg1 + 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::backing_buffer_lambda(&arg0.config), arg2 - arg1)
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::StrikeExposureConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : StrikeExposure {
        assert!(arg5 > 0, 6);
        StrikeExposure{
            expiry_market_id                   : arg0,
            tick_size                          : arg2,
            admission_tick_size                : arg3,
            reference_tick_source_timestamp_ms : arg4,
            reference_tick                     : 0x1::option::none<u64>(),
            config                             : arg1,
            inventory_impact_scale             : arg5,
            next_order_sequence                : 0,
            settlement_price                   : 0x1::option::none<u64>(),
            settled_payout_liability           : 0,
            payout                             : 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::new(arg6),
        }
    }

    fun order_range_price(arg0: &StrikeExposure, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing::Pricer, arg2: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::Order) : u64 {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing::range_price(arg1, 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::range_codec::strike_from_tick(0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::lower_tick(arg2), arg0.tick_size), 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::range_codec::strike_from_tick(0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::higher_tick(arg2), arg0.tick_size))
    }

    fun payout_liabilities_after_change(arg0: &StrikeExposure, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : (u64, u64) {
        let (v0, v1) = 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::payout_reserve_terms(&arg0.payout);
        let (v2, v3) = if (arg4) {
            (0x1::u64::max(v0, 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::range_max_payout(&arg0.payout, arg1, arg2) + arg3), v1 + arg3)
        } else {
            (0x1::u64::max(0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::range_max_payout(&arg0.payout, arg1, arg2) - arg3, 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::complement_max_payout(&arg0.payout, arg1, arg2)), v1 - arg3)
        };
        (live_payout_liability_from_terms(arg0, v0, v1), live_payout_liability_from_terms(arg0, v2, v3))
    }

    public(friend) fun payout_liability(arg0: &StrikeExposure) : u64 {
        if (is_settled(arg0)) {
            arg0.settled_payout_liability
        } else {
            let (v1, v2) = 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::payout_reserve_terms(&arg0.payout);
            live_payout_liability_from_terms(arg0, v1, v2)
        }
    }

    public(friend) fun premium(arg0: &MintTerms) : u64 {
        arg0.premium
    }

    public(friend) fun process_live_close(arg0: &mut StrikeExposure, arg1: LiveCloseTerms) : 0x1::option::Option<0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::Order> {
        let LiveCloseTerms {
            expiry_market_id        : v0,
            order                   : v1,
            close_quantity          : v2,
            redeem_amount           : _,
            range_probability       : _,
            inventory_impact_rebate : _,
        } = arg1;
        let v6 = v1;
        assert!(v0 == arg0.expiry_market_id, 4);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::remove_range(&mut arg0.payout, 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::lower_tick(&v6), 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::higher_tick(&v6), v2);
        let v7 = 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::quantity(&v6) - v2;
        if (v7 == 0) {
            return 0x1::option::none<0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::Order>()
        };
        arg0.next_order_sequence = arg0.next_order_sequence + 1;
        0x1::option::some<0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::Order>(0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::replacement(&v6, v7, arg0.next_order_sequence))
    }

    public(friend) fun process_settled_close(arg0: &mut StrikeExposure, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::Order) : u64 {
        let v0 = settled_order_payout(arg0, arg1);
        arg0.settled_payout_liability = arg0.settled_payout_liability - v0;
        v0
    }

    public(friend) fun quote_live_close(arg0: &StrikeExposure, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing::Pricer, arg2: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::Order, arg3: u64) : LiveCloseTerms {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::assert_valid_quantity(arg3);
        assert!(arg3 <= 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::quantity(arg2), 0);
        let v0 = order_range_price(arg0, arg1, arg2);
        LiveCloseTerms{
            expiry_market_id        : arg0.expiry_market_id,
            order                   : *arg2,
            close_quantity          : arg3,
            redeem_amount           : 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(v0, arg3),
            range_probability       : v0,
            inventory_impact_rebate : inventory_impact(arg0, 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::lower_tick(arg2), 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::higher_tick(arg2), arg3, false),
        }
    }

    public(friend) fun quote_mint_terms(arg0: &StrikeExposure, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing::Pricer, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : MintTerms {
        let v0 = admitted_entry_probability(arg0, arg1, arg2, arg3);
        let v1 = if (arg6) {
            arg5
        } else {
            0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::assert_mint_probability_policy(&arg0.config, v0);
            let v2 = 10000;
            let v3 = 0;
            let v4 = 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::max_quantity_lots();
            while (v3 < v4) {
                let v5 = (v3 + v4 + 1) / 2;
                if (0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(v0, v5 * v2) <= arg4) {
                    v3 = v5;
                    continue
                };
                v4 = v5 - 1;
            };
            v3 * v2
        };
        assert!(v1 >= arg5, 5);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::assert_valid_quantity(v1);
        MintTerms{
            expiry_market_id        : arg0.expiry_market_id,
            lower_tick              : arg2,
            higher_tick             : arg3,
            quantity                : v1,
            entry_probability       : v0,
            premium                 : 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::assert_mint_admission(&arg0.config, v0, v1),
            inventory_impact_charge : inventory_impact(arg0, arg2, arg3, v1, true),
        }
    }

    public(friend) fun range_probability(arg0: &LiveCloseTerms) : u64 {
        arg0.range_probability
    }

    public(friend) fun record_settlement(arg0: &mut StrikeExposure, arg1: u64) {
        if (is_settled(arg0)) {
            return
        };
        arg0.settlement_price = 0x1::option::some<u64>(arg1);
        arg0.settled_payout_liability = 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::settled_payout_liability(&arg0.payout, arg1, arg0.tick_size);
    }

    public(friend) fun redeem_amount(arg0: &LiveCloseTerms) : u64 {
        arg0.redeem_amount
    }

    public(friend) fun reference_tick(arg0: &StrikeExposure) : 0x1::option::Option<u64> {
        arg0.reference_tick
    }

    public(friend) fun reference_tick_source_timestamp_ms(arg0: &StrikeExposure) : u64 {
        arg0.reference_tick_source_timestamp_ms
    }

    public(friend) fun release_valuation_snapshot(arg0: &mut StrikeExposure) {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_payout_tree::release_snapshot(&mut arg0.payout);
    }

    public(friend) fun set_reference_tick(arg0: &mut StrikeExposure, arg1: u64) : bool {
        assert!(arg1 > 0 && arg1 < 1073741823, 2);
        if (0x1::option::is_some<u64>(&arg0.reference_tick)) {
            assert!(*0x1::option::borrow<u64>(&arg0.reference_tick) == arg1, 3);
            return false
        };
        arg0.reference_tick = 0x1::option::some<u64>(arg1);
        true
    }

    public(friend) fun settled_order_payout(arg0: &StrikeExposure, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::Order) : u64 {
        if (0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::range_codec::settlement_in_range(0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::lower_tick(arg1), 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::higher_tick(arg1), settlement_price(arg0), arg0.tick_size)) {
            0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::order::quantity(arg1)
        } else {
            0
        }
    }

    public(friend) fun settlement_price(arg0: &StrikeExposure) : u64 {
        0x1::option::destroy_some<u64>(arg0.settlement_price)
    }

    public(friend) fun tick_size(arg0: &StrikeExposure) : u64 {
        arg0.tick_size
    }

    public(friend) fun trading_fee(arg0: &StrikeExposure, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::trading_fee(&arg0.config, arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4))
    }

    public(friend) fun try_settlement_price(arg0: &StrikeExposure) : 0x1::option::Option<u64> {
        arg0.settlement_price
    }

    // decompiled from Move bytecode v7
}

