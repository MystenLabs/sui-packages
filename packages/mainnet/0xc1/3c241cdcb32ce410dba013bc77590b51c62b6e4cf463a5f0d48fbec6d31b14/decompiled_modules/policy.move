module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy {
    struct Policy has store {
        numeraire: u8,
        supra_holder: 0x2::object::ID,
        max_price_age_ms: u64,
        max_deviation_bps: u64,
        max_slippage_bps: u64,
        index_size: u64,
        max_weight_bps: u64,
        drift_tolerance_bps: u64,
        min_trade_value: u64,
        denominations: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        deposit_fee_bps: u64,
        withdrawal_fee_bps: u64,
        fee_collector: address,
        nav_max_age_ms: u64,
        rebalance_interval_ms: u64,
        open_crank_grace_ms: u64,
        composition_timelock_ms: u64,
        reweight_timelock_ms: u64,
        feed_timelock_ms: u64,
        emergency_delay_ms: u64,
        holder_timelock_ms: u64,
        pending_holder: 0x1::option::Option<PendingHolder>,
    }

    struct PendingHolder has drop, store {
        holder: 0x2::object::ID,
        proposed_at_ms: u64,
        effective_ms: u64,
    }

    struct SupraHolderRotationProposed has copy, drop {
        current: 0x2::object::ID,
        proposed: 0x2::object::ID,
        proposed_at_ms: u64,
        effective_ms: u64,
    }

    struct SupraHolderRotationExecuted has copy, drop {
        previous: 0x2::object::ID,
        current: 0x2::object::ID,
        proposed_at_ms: u64,
        timestamp_ms: u64,
    }

    struct SupraHolderRotationCancelled has copy, drop {
        current: 0x2::object::ID,
        cancelled: 0x2::object::ID,
    }

    struct SupraHolderRotationExtended has copy, drop {
        holder: 0x2::object::ID,
        previous_ms: u64,
        effective_ms: u64,
    }

    public(friend) fun accept_denomination(arg0: &mut Policy, arg1: 0x1::type_name::TypeName, arg2: u64) {
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.denominations, &arg1), 103);
        assert!(arg2 >= 25 && arg2 <= 500, 100);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.denominations, arg1, arg2);
    }

    public(friend) fun assert_denomination(arg0: &Policy, arg1: 0x1::type_name::TypeName) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.denominations, &arg1), 102);
    }

    public(friend) fun assert_within_peg(arg0: &Policy, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = if (arg2 > 1000000) {
            arg2 - 1000000
        } else {
            1000000 - arg2
        };
        assert!((((v0 as u128) * (10000 as u128) / (1000000 as u128)) as u64) <= peg_band_bps(arg0, arg1), 100);
    }

    public fun bps_divisor() : u64 {
        10000
    }

    public(friend) fun cancel_supra_holder(arg0: &mut Policy) : 0x2::object::ID {
        assert!(0x1::option::is_some<PendingHolder>(&arg0.pending_holder), 105);
        let PendingHolder {
            holder         : v0,
            proposed_at_ms : _,
            effective_ms   : _,
        } = 0x1::option::extract<PendingHolder>(&mut arg0.pending_holder);
        let v3 = SupraHolderRotationCancelled{
            current   : arg0.supra_holder,
            cancelled : v0,
        };
        0x2::event::emit<SupraHolderRotationCancelled>(v3);
        v0
    }

    public fun composition_timelock_ms(arg0: &Policy) : u64 {
        arg0.composition_timelock_ms
    }

    public fun deposit_fee_bps(arg0: &Policy) : u64 {
        arg0.deposit_fee_bps
    }

    public fun drift_tolerance_bps(arg0: &Policy) : u64 {
        arg0.drift_tolerance_bps
    }

    public(friend) fun drop_denomination(arg0: &mut Policy, arg1: 0x1::type_name::TypeName) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.denominations, &arg1), 102);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.denominations, &arg1);
    }

    public fun emergency_delay_ms(arg0: &Policy) : u64 {
        arg0.emergency_delay_ms
    }

    public(friend) fun execute_supra_holder(arg0: &mut Policy, arg1: &0x2::clock::Clock) : (0x2::object::ID, 0x2::object::ID) {
        assert!(0x1::option::is_some<PendingHolder>(&arg0.pending_holder), 105);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= 0x1::option::borrow<PendingHolder>(&arg0.pending_holder).effective_ms, 106);
        let PendingHolder {
            holder         : v1,
            proposed_at_ms : v2,
            effective_ms   : _,
        } = 0x1::option::extract<PendingHolder>(&mut arg0.pending_holder);
        let v4 = arg0.supra_holder;
        arg0.supra_holder = v1;
        let v5 = SupraHolderRotationExecuted{
            previous       : v4,
            current        : v1,
            proposed_at_ms : v2,
            timestamp_ms   : v0,
        };
        0x2::event::emit<SupraHolderRotationExecuted>(v5);
        (v4, v1)
    }

    public fun fee_collector(arg0: &Policy) : address {
        arg0.fee_collector
    }

    public fun feed_timelock_ms(arg0: &Policy) : u64 {
        arg0.feed_timelock_ms
    }

    public fun holder_timelock_ms(arg0: &Policy) : u64 {
        arg0.holder_timelock_ms
    }

    public fun index_size(arg0: &Policy) : u64 {
        arg0.index_size
    }

    public fun is_denomination(arg0: &Policy, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.denominations, &arg1)
    }

    public fun max_deviation_bps(arg0: &Policy) : u64 {
        arg0.max_deviation_bps
    }

    public fun max_price_age_ms(arg0: &Policy) : u64 {
        arg0.max_price_age_ms
    }

    public fun max_slippage_bps(arg0: &Policy) : u64 {
        arg0.max_slippage_bps
    }

    public fun max_weight_bps(arg0: &Policy) : u64 {
        arg0.max_weight_bps
    }

    public fun min_trade_value(arg0: &Policy) : u64 {
        arg0.min_trade_value
    }

    public fun nav_max_age_ms(arg0: &Policy) : u64 {
        arg0.nav_max_age_ms
    }

    public(friend) fun new(arg0: u8, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: address) : Policy {
        assert!(arg0 == 0 || arg0 == 1, 101);
        assert!(arg2 >= 45000 && arg2 <= 600000, 100);
        assert!(arg3 >= 3 && arg3 <= 10, 100);
        Policy{
            numeraire               : arg0,
            supra_holder            : arg1,
            max_price_age_ms        : arg2,
            max_deviation_bps       : 5000,
            max_slippage_bps        : 100,
            index_size              : arg3,
            max_weight_bps          : 4000,
            drift_tolerance_bps     : 300,
            min_trade_value         : 10000,
            denominations           : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            deposit_fee_bps         : 0,
            withdrawal_fee_bps      : 0,
            fee_collector           : arg4,
            nav_max_age_ms          : 120000,
            rebalance_interval_ms   : 86400000,
            open_crank_grace_ms     : 43200000,
            composition_timelock_ms : 86400000,
            reweight_timelock_ms    : 3600000,
            feed_timelock_ms        : 86400000,
            emergency_delay_ms      : 172800000,
            holder_timelock_ms      : 86400000,
            pending_holder          : 0x1::option::none<PendingHolder>(),
        }
    }

    public fun numeraire(arg0: &Policy) : u8 {
        arg0.numeraire
    }

    public fun numeraire_scale() : u64 {
        1000000
    }

    public fun open_crank_grace_ms(arg0: &Policy) : u64 {
        arg0.open_crank_grace_ms
    }

    public(friend) fun peg_band_bps(arg0: &Policy, arg1: 0x1::type_name::TypeName) : u64 {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.denominations, &arg1), 102);
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.denominations, &arg1)
    }

    public(friend) fun pending_holder_count(arg0: &Policy) : u64 {
        if (0x1::option::is_some<PendingHolder>(&arg0.pending_holder)) {
            1
        } else {
            0
        }
    }

    public fun pending_holder_effective_ms(arg0: &Policy) : u64 {
        if (0x1::option::is_some<PendingHolder>(&arg0.pending_holder)) {
            0x1::option::borrow<PendingHolder>(&arg0.pending_holder).effective_ms
        } else {
            0
        }
    }

    public fun pending_supra_holder(arg0: &Policy) : 0x1::option::Option<0x2::object::ID> {
        if (0x1::option::is_some<PendingHolder>(&arg0.pending_holder)) {
            0x1::option::some<0x2::object::ID>(0x1::option::borrow<PendingHolder>(&arg0.pending_holder).holder)
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public(friend) fun propose_supra_holder(arg0: &mut Policy, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x1::option::is_none<PendingHolder>(&arg0.pending_holder), 104);
        assert!(arg1 != 0x2::object::id_from_address(@0x0), 108);
        assert!(arg1 != arg0.supra_holder, 107);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = v0 + arg0.holder_timelock_ms;
        let v2 = PendingHolder{
            holder         : arg1,
            proposed_at_ms : v0,
            effective_ms   : v1,
        };
        0x1::option::fill<PendingHolder>(&mut arg0.pending_holder, v2);
        let v3 = SupraHolderRotationProposed{
            current        : arg0.supra_holder,
            proposed       : arg1,
            proposed_at_ms : v0,
            effective_ms   : v1,
        };
        0x2::event::emit<SupraHolderRotationProposed>(v3);
        (v1, v0)
    }

    public fun quote_usd() : u8 {
        1
    }

    public fun quote_usdt() : u8 {
        0
    }

    public(friend) fun raise_composition_timelock(arg0: &mut Policy, arg1: u64) {
        assert!(arg1 >= arg0.composition_timelock_ms, 100);
        arg0.composition_timelock_ms = arg1;
    }

    public(friend) fun raise_emergency_delay(arg0: &mut Policy, arg1: u64) {
        assert!(arg1 >= arg0.emergency_delay_ms, 100);
        arg0.emergency_delay_ms = arg1;
    }

    public(friend) fun raise_feed_timelock(arg0: &mut Policy, arg1: u64) {
        assert!(arg1 >= arg0.feed_timelock_ms, 100);
        arg0.feed_timelock_ms = arg1;
    }

    public(friend) fun raise_holder_timelock(arg0: &mut Policy, arg1: u64) {
        assert!(arg1 >= arg0.holder_timelock_ms, 100);
        arg0.holder_timelock_ms = arg1;
        if (0x1::option::is_some<PendingHolder>(&arg0.pending_holder)) {
            let v0 = 0x1::option::borrow_mut<PendingHolder>(&mut arg0.pending_holder);
            let v1 = v0.proposed_at_ms + arg1;
            if (v1 > v0.effective_ms) {
                v0.effective_ms = v1;
                let v2 = SupraHolderRotationExtended{
                    holder       : v0.holder,
                    previous_ms  : v0.effective_ms,
                    effective_ms : v1,
                };
                0x2::event::emit<SupraHolderRotationExtended>(v2);
            };
        };
    }

    public(friend) fun raise_reweight_timelock(arg0: &mut Policy, arg1: u64) {
        assert!(arg1 >= arg0.reweight_timelock_ms, 100);
        arg0.reweight_timelock_ms = arg1;
    }

    public fun rebalance_interval_ms(arg0: &Policy) : u64 {
        arg0.rebalance_interval_ms
    }

    public fun reweight_timelock_ms(arg0: &Policy) : u64 {
        arg0.reweight_timelock_ms
    }

    public(friend) fun set_drift_tolerance(arg0: &mut Policy, arg1: u64) {
        assert!(arg1 >= 50 && arg1 <= 2000, 100);
        arg0.drift_tolerance_bps = arg1;
    }

    public(friend) fun set_fee_collector(arg0: &mut Policy, arg1: address) {
        assert!(arg1 != @0x0, 100);
        arg0.fee_collector = arg1;
    }

    public(friend) fun set_fees(arg0: &mut Policy, arg1: u64, arg2: u64) {
        assert!(arg1 <= 1000 && arg2 <= 1000, 100);
        arg0.deposit_fee_bps = arg1;
        arg0.withdrawal_fee_bps = arg2;
    }

    public(friend) fun set_max_deviation(arg0: &mut Policy, arg1: u64) {
        assert!(arg1 >= 500 && arg1 <= 9000, 100);
        arg0.max_deviation_bps = arg1;
    }

    public(friend) fun set_max_price_age(arg0: &mut Policy, arg1: u64) {
        assert!(arg1 >= 45000 && arg1 <= 600000, 100);
        arg0.max_price_age_ms = arg1;
    }

    public(friend) fun set_max_slippage(arg0: &mut Policy, arg1: u64) {
        assert!(arg1 >= 10 && arg1 <= 2000, 100);
        arg0.max_slippage_bps = arg1;
    }

    public(friend) fun set_rebalance_schedule(arg0: &mut Policy, arg1: u64, arg2: u64) {
        assert!(arg1 >= 3600000 && arg1 <= 604800000, 100);
        arg0.rebalance_interval_ms = arg1;
        arg0.open_crank_grace_ms = arg2;
    }

    public fun supra_holder(arg0: &Policy) : 0x2::object::ID {
        arg0.supra_holder
    }

    public fun withdrawal_fee_bps(arg0: &Policy) : u64 {
        arg0.withdrawal_fee_bps
    }

    // decompiled from Move bytecode v7
}

