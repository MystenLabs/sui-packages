module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure {
    struct StrikeExposure has store {
        expiry_market_id: 0x2::object::ID,
        tick_size: u64,
        admission_tick_size: u64,
        reference_tick_source_timestamp_ms: u64,
        reference_tick: 0x1::option::Option<u64>,
        config: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::StrikeExposureConfig,
        inventory_impact_scale: u64,
        next_order_sequence: u64,
        settlement_price: 0x1::option::Option<u64>,
        settled_payout_liability: u64,
        payout: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::StrikePayoutTree,
    }

    struct MintRange has drop {
        expiry_market_id: 0x2::object::ID,
        lower_tick: u64,
        higher_tick: u64,
        price: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice,
        max_payout: u64,
        total_payout: u64,
        range_max_payout: u64,
    }

    struct MintTerms has drop {
        expiry_market_id: 0x2::object::ID,
        lower_tick: u64,
        higher_tick: u64,
        quantity: u64,
        price: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice,
        premium: u64,
        inventory_impact_charge: u64,
    }

    struct LiveCloseTerms has drop {
        expiry_market_id: 0x2::object::ID,
        order: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order,
        close_quantity: u64,
        redeem_amount: u64,
        price: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice,
        inventory_impact_rebate: u64,
    }

    public(friend) fun quantity(arg0: &MintTerms) : u64 {
        arg0.quantity
    }

    public(friend) fun admission_tick_size(arg0: &StrikeExposure) : u64 {
        arg0.admission_tick_size
    }

    public(friend) fun allocate(arg0: &mut StrikeExposure, arg1: MintTerms) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order {
        let MintTerms {
            expiry_market_id        : v0,
            lower_tick              : v1,
            higher_tick             : v2,
            quantity                : v3,
            price                   : _,
            premium                 : _,
            inventory_impact_charge : _,
        } = arg1;
        assert!(v0 == arg0.expiry_market_id, 4);
        let v7 = arg0.next_order_sequence;
        arg0.next_order_sequence = v7 + 1;
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::insert_exist(&mut arg0.payout, v1, v2, v3);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::from_ticks(v1, v2, v3, v7)
    }

    public(friend) fun apply_close(arg0: &mut StrikeExposure, arg1: LiveCloseTerms, arg2: &0x2::vec_map::VecMap<u64, u64>) : 0x1::option::Option<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order> {
        let LiveCloseTerms {
            expiry_market_id        : v0,
            order                   : v1,
            close_quantity          : v2,
            redeem_amount           : _,
            price                   : _,
            inventory_impact_rebate : _,
        } = arg1;
        let v6 = v1;
        assert!(v0 == arg0.expiry_market_id, 4);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::remove_range(&mut arg0.payout, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::lower_tick(&v6), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::higher_tick(&v6), v2, arg2);
        let v7 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::quantity(&v6) - v2;
        if (v7 == 0) {
            return 0x1::option::none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order>()
        };
        arg0.next_order_sequence = arg0.next_order_sequence + 1;
        0x1::option::some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order>(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::replacement(&v6, v7, arg0.next_order_sequence))
    }

    public(friend) fun backing_buffer_lambda(arg0: &StrikeExposure) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::backing_buffer_lambda(&arg0.config)
    }

    public(friend) fun close_impact(arg0: &StrikeExposure, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::inventory_impact_max_rate(&arg0.config) == 0 || arg3 == 0) {
            return 0
        };
        let (v0, v1) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::rsv_terms(&arg0.payout);
        pot_for_liab(arg0, liab_of(arg0, v0, v1)) - pot_for_liab(arg0, liab_of(arg0, 0x1::u64::max(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::range_max(&arg0.payout, arg1, arg2) - arg3, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::outside_max(&arg0.payout, arg1, arg2)), v1 - arg3))
    }

    public(friend) fun close_price(arg0: &LiveCloseTerms) : &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice {
        &arg0.price
    }

    public(friend) fun close_prob(arg0: &LiveCloseTerms) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::probability(&arg0.price)
    }

    public(friend) fun drop_snap(arg0: &mut StrikeExposure, arg1: &0x2::vec_map::VecMap<u64, u64>) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::snap_done(&mut arg0.payout, arg1);
    }

    public(friend) fun ensure_nodes(arg0: &mut StrikeExposure, arg1: u64, arg2: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::ensure_node(&mut arg0.payout, arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::ensure_node(&mut arg0.payout, arg2);
    }

    public(friend) fun expiry_fee_max_multiplier(arg0: &StrikeExposure) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::expiry_fee_max_multiplier(&arg0.config)
    }

    public(friend) fun expiry_fee_window_ms(arg0: &StrikeExposure) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::expiry_fee_window_ms(&arg0.config)
    }

    public(friend) fun fee_at(arg0: &StrikeExposure, arg1: u64, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice, arg3: u64, arg4: u64) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::trading_fee(&arg0.config, arg1, arg2, arg3, arg4)
    }

    public(friend) fun frozen_liab(arg0: &StrikeExposure, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg2: u64) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::walk_frozen(&arg0.payout, arg1, arg0.tick_size, arg2)
    }

    public(friend) fun impact_pot(arg0: &StrikeExposure) : u64 {
        if (is_settled(arg0) || 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::inventory_impact_max_rate(&arg0.config) == 0) {
            return 0
        };
        pot_for_liab(arg0, payout_liability(arg0))
    }

    public(friend) fun inventory_impact_charge(arg0: &MintTerms) : u64 {
        arg0.inventory_impact_charge
    }

    public(friend) fun inventory_impact_max_rate(arg0: &StrikeExposure) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::inventory_impact_max_rate(&arg0.config)
    }

    public(friend) fun inventory_impact_scale(arg0: &StrikeExposure) : u64 {
        arg0.inventory_impact_scale
    }

    fun is_admitted(arg0: &StrikeExposure, arg1: u64, arg2: u64) : bool {
        let v0 = arg0.admission_tick_size / arg0.tick_size;
        let v1 = if (arg1 == 0) {
            true
        } else if (arg1 % v0 == 0) {
            true
        } else {
            0x1::option::contains<u64>(&arg0.reference_tick, &arg1)
        };
        let v2 = if (arg2 == 1073741823) {
            true
        } else if (arg2 % v0 == 0) {
            true
        } else {
            0x1::option::contains<u64>(&arg0.reference_tick, &arg2)
        };
        v1 && v2
    }

    public(friend) fun is_settled(arg0: &StrikeExposure) : bool {
        0x1::option::is_some<u64>(&arg0.settlement_price)
    }

    public(friend) fun liab_closed(arg0: &StrikeExposure, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let (_, v1) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::rsv_terms(&arg0.payout);
        liab_of(arg0, 0x1::u64::max(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::range_max(&arg0.payout, arg1, arg2) - arg3, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::outside_max(&arg0.payout, arg1, arg2)), v1 - arg3)
    }

    public(friend) fun liab_minted(arg0: &StrikeExposure, arg1: &MintRange, arg2: u64) : u64 {
        liab_of(arg0, 0x1::u64::max(arg1.max_payout, arg1.range_max_payout + arg2), arg1.total_payout + arg2)
    }

    fun liab_of(arg0: &StrikeExposure, arg1: u64, arg2: u64) : u64 {
        arg1 + 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::backing_buffer_lambda(&arg0.config), arg2 - arg1)
    }

    public(friend) fun live_order_value(arg0: &StrikeExposure, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order) : u64 {
        let v0 = order_px(arg0, arg1, arg2);
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::probability(&v0), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::quantity(arg2))
    }

    public(friend) fun marked_liab(arg0: &StrikeExposure, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::walk_linear(&arg0.payout, arg1, arg0.tick_size)
    }

    public(friend) fun min_prob(arg0: &StrikeExposure) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::min_prob(&arg0.config)
    }

    public(friend) fun mint_impact(arg0: &StrikeExposure, arg1: &MintRange, arg2: u64) : u64 {
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::inventory_impact_max_rate(&arg0.config) == 0 || arg2 == 0) {
            return 0
        };
        pot_for_liab(arg0, liab_of(arg0, 0x1::u64::max(arg1.max_payout, arg1.range_max_payout + arg2), arg1.total_payout + arg2)) - pot_for_liab(arg0, liab_of(arg0, arg1.max_payout, arg1.total_payout))
    }

    public(friend) fun mint_price(arg0: &MintTerms) : &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice {
        &arg0.price
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::StrikeExposureConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : StrikeExposure {
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
            payout                             : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::new(arg6),
        }
    }

    public(friend) fun nodes_exist(arg0: &StrikeExposure, arg1: u64, arg2: u64) : bool {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::has_nodes(&arg0.payout, arg1, arg2)
    }

    fun order_px(arg0: &StrikeExposure, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::range_price(arg1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::strike_from_tick(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::lower_tick(arg2), arg0.tick_size), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::strike_from_tick(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::higher_tick(arg2), arg0.tick_size))
    }

    public(friend) fun payout_liability(arg0: &StrikeExposure) : u64 {
        if (is_settled(arg0)) {
            arg0.settled_payout_liability
        } else {
            let (v1, v2) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::rsv_terms(&arg0.payout);
            liab_of(arg0, v1, v2)
        }
    }

    fun pot_for_liab(arg0: &StrikeExposure, arg1: u64) : u64 {
        0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::potential(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::inventory_impact_max_rate(&arg0.config), arg0.inventory_impact_scale, arg1)
    }

    public(friend) fun premium(arg0: &MintTerms) : u64 {
        arg0.premium
    }

    public(friend) fun prune_node(arg0: &mut StrikeExposure, arg1: u64, arg2: &0x2::vec_map::VecMap<u64, u64>) : bool {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::prune_node(&mut arg0.payout, arg1, arg2)
    }

    public(friend) fun qty_for_prem(arg0: &MintRange, arg1: u64) : u64 {
        0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::max_qty(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::probability(&arg0.price), arg1, 10000, 4294967295)
    }

    public(friend) fun range_prem(arg0: &MintRange, arg1: u64) : u64 {
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::probability(&arg0.price), arg1)
    }

    public(friend) fun range_px(arg0: &MintRange) : &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice {
        &arg0.price
    }

    public(friend) fun rebate(arg0: &LiveCloseTerms) : u64 {
        arg0.inventory_impact_rebate
    }

    public(friend) fun redeem_amt(arg0: &LiveCloseTerms) : u64 {
        arg0.redeem_amount
    }

    public(friend) fun reference_tick(arg0: &StrikeExposure) : 0x1::option::Option<u64> {
        arg0.reference_tick
    }

    public(friend) fun reference_tick_source_timestamp_ms(arg0: &StrikeExposure) : u64 {
        arg0.reference_tick_source_timestamp_ms
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

    public(friend) fun set_settled(arg0: &mut StrikeExposure, arg1: u64) {
        if (is_settled(arg0)) {
            return
        };
        arg0.settlement_price = 0x1::option::some<u64>(arg1);
        arg0.settled_payout_liability = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::settled_liab(&arg0.payout, arg1, arg0.tick_size);
    }

    public(friend) fun settle_close(arg0: &mut StrikeExposure, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order) : u64 {
        let v0 = settled_order_payout(arg0, arg1);
        arg0.settled_payout_liability = arg0.settled_payout_liability - v0;
        v0
    }

    public(friend) fun settled_order_payout(arg0: &StrikeExposure, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order) : u64 {
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::in_range(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::lower_tick(arg1), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::higher_tick(arg1), settlement_price(arg0), arg0.tick_size)) {
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::quantity(arg1)
        } else {
            0
        }
    }

    public(friend) fun settlement_price(arg0: &StrikeExposure) : u64 {
        0x1::option::destroy_some<u64>(arg0.settlement_price)
    }

    public(friend) fun start_snap(arg0: &mut StrikeExposure, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::snap_on(&mut arg0.payout, arg1);
    }

    public(friend) fun stop_snap(arg0: &mut StrikeExposure) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::snap_off(&mut arg0.payout);
    }

    public(friend) fun tick_size(arg0: &StrikeExposure) : u64 {
        arg0.tick_size
    }

    public(friend) fun tree_nodes(arg0: &StrikeExposure) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::node_count(&arg0.payout)
    }

    public(friend) fun try_close(arg0: &StrikeExposure, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order, arg3: u64) : 0x1::option::Option<LiveCloseTerms> {
        if (!valid_qty(arg3) || arg3 > 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::quantity(arg2)) {
            return 0x1::option::none<LiveCloseTerms>()
        };
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::try_range(arg1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::strike_from_tick(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::lower_tick(arg2), arg0.tick_size), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::strike_from_tick(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::higher_tick(arg2), arg0.tick_size));
        if (0x1::option::is_none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice>(&v0)) {
            return 0x1::option::none<LiveCloseTerms>()
        };
        let v1 = 0x1::option::destroy_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice>(v0);
        let v2 = LiveCloseTerms{
            expiry_market_id        : arg0.expiry_market_id,
            order                   : *arg2,
            close_quantity          : arg3,
            redeem_amount           : 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::probability(&v1), arg3),
            price                   : v1,
            inventory_impact_rebate : close_impact(arg0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::lower_tick(arg2), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::higher_tick(arg2), arg3),
        };
        0x1::option::some<LiveCloseTerms>(v2)
    }

    public(friend) fun try_mint_rng(arg0: &StrikeExposure, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg2: u64, arg3: u64) : 0x1::option::Option<MintRange> {
        if (!valid_range(arg2, arg3) || !is_admitted(arg0, arg2, arg3)) {
            return 0x1::option::none<MintRange>()
        };
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::try_range(arg1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::strike_from_tick(arg2, arg0.tick_size), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::strike_from_tick(arg3, arg0.tick_size));
        if (0x1::option::is_none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice>(&v0)) {
            return 0x1::option::none<MintRange>()
        };
        let v1 = 0x1::option::destroy_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice>(v0);
        if (!0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::range_ok(&arg0.config, &v1)) {
            return 0x1::option::none<MintRange>()
        };
        let (v2, v3) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::rsv_terms(&arg0.payout);
        let v4 = MintRange{
            expiry_market_id : arg0.expiry_market_id,
            lower_tick       : arg2,
            higher_tick      : arg3,
            price            : v1,
            max_payout       : v2,
            total_payout     : v3,
            range_max_payout : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree::range_max(&arg0.payout, arg2, arg3),
        };
        0x1::option::some<MintRange>(v4)
    }

    public(friend) fun try_settled(arg0: &mut StrikeExposure, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order::Order) : 0x1::option::Option<u64> {
        if (!is_settled(arg0)) {
            return 0x1::option::none<u64>()
        };
        let v0 = settled_order_payout(arg0, arg1);
        if (v0 > arg0.settled_payout_liability) {
            return 0x1::option::none<u64>()
        };
        arg0.settled_payout_liability = arg0.settled_payout_liability - v0;
        0x1::option::some<u64>(v0)
    }

    public(friend) fun try_settlement_price(arg0: &StrikeExposure) : 0x1::option::Option<u64> {
        arg0.settlement_price
    }

    public(friend) fun try_terms(arg0: &StrikeExposure, arg1: MintRange, arg2: u64, arg3: u64) : (0x1::option::Option<MintTerms>, u8) {
        assert!(arg1.expiry_market_id == arg0.expiry_market_id, 4);
        if (arg2 < arg3 || !valid_qty(arg2)) {
            return (0x1::option::none<MintTerms>(), 1)
        };
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::probability(&arg1.price);
        let v1 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v0, arg2);
        if (!0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::prob_ok(&arg0.config, v0) || v1 < 1000000) {
            return (0x1::option::none<MintTerms>(), 2)
        };
        let MintRange {
            expiry_market_id : v2,
            lower_tick       : v3,
            higher_tick      : v4,
            price            : v5,
            max_payout       : _,
            total_payout     : _,
            range_max_payout : _,
        } = arg1;
        let v9 = MintTerms{
            expiry_market_id        : v2,
            lower_tick              : v3,
            higher_tick             : v4,
            quantity                : arg2,
            price                   : v5,
            premium                 : v1,
            inventory_impact_charge : mint_impact(arg0, &arg1, arg2),
        };
        (0x1::option::some<MintTerms>(v9), 0)
    }

    fun valid_qty(arg0: u64) : bool {
        let v0 = 10000;
        if (arg0 > 0) {
            if (arg0 % v0 == 0) {
                arg0 / v0 <= 4294967295
            } else {
                false
            }
        } else {
            false
        }
    }

    fun valid_range(arg0: u64, arg1: u64) : bool {
        let v0 = 1073741823;
        if (arg0 < arg1) {
            if (arg1 <= v0) {
                let v2 = arg0 == 0 && arg1 == v0;
                !v2
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

