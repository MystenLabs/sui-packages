module 0x80b92600ee5e10cf728cb8e2f6443ad1aa73d87c3f237da206c3fdcf2813ec04::condenser {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        condenser_id: 0x2::object::ID,
    }

    struct Condenser<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        source: 0x2::balance::Balance<T1>,
        flow_amount: u64,
        flow_interval: u64,
        pool: 0x2::balance::Balance<T1>,
        total_weight: u64,
        total_staked: u64,
        cumulative_unit: u128,
        latest_release_time: u64,
        max_lock_time: u64,
        staked_bag: 0x2::object_bag::ObjectBag,
        finished_bag: 0x2::bag::Bag,
        kettle: 0x1::option::Option<0x80b92600ee5e10cf728cb8e2f6443ad1aa73d87c3f237da206c3fdcf2813ec04::kettle::Kettle>,
        kettle_boil_period: u64,
        latest_kettle_boil: u64,
        kettle_param_object_id: 0x1::option::Option<address>,
        kettle_param_object_type: 0x1::option::Option<0x1::ascii::String>,
        adjust_flow_amount_to_source_percent: u64,
        timecapsule_store_id: 0x1::option::Option<0x2::object::ID>,
        meta: vector<u8>,
    }

    struct CondenserStakeRecord<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        condenser_id: 0x2::object::ID,
        stake_amount: u64,
        start_uint: u128,
        start_claim_time: u64,
        stake_weight: u64,
        lock_until: u64,
        meta: vector<u8>,
    }

    struct CondenserFinishedRecord<phantom T0, phantom T1> has store {
        condenser_id: 0x2::object::ID,
        reward: 0x2::balance::Balance<T1>,
        meta: vector<u8>,
    }

    struct MintEvent has copy, drop {
        condenser_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        type_s: vector<u8>,
        type_r: vector<u8>,
    }

    struct FlowRateUpdated has copy, drop {
        condenser_id: 0x2::object::ID,
        flow_amount: u64,
        flow_interval: u64,
    }

    struct StakeEvent has copy, drop {
        condenser_id: 0x2::object::ID,
        time_capsule_key: address,
        stake_amount: u64,
        stake_weight: u64,
        stake_amount_increase: u64,
        lock_until: u64,
    }

    struct ClaimEvent has copy, drop {
        condenser_id: 0x2::object::ID,
        time_capsule_key: address,
        reward_amount: u64,
        claim_time: u64,
    }

    public entry fun attach_kettle<T0, T1>(arg0: &AdminCap, arg1: &mut Condenser<T0, T1>, arg2: 0x80b92600ee5e10cf728cb8e2f6443ad1aa73d87c3f237da206c3fdcf2813ec04::kettle::Kettle, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin_cap<T0, T1>(arg0, arg1);
        0x1::option::fill<0x80b92600ee5e10cf728cb8e2f6443ad1aa73d87c3f237da206c3fdcf2813ec04::kettle::Kettle>(&mut arg1.kettle, arg2);
        arg1.kettle_param_object_id = 0x1::option::none<address>();
        arg1.kettle_param_object_type = 0x1::option::none<0x1::ascii::String>();
    }

    public fun boil_kettle_with_fountain<T0, T1, T2>(arg0: &mut Condenser<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<T2, T1>) {
        if (0x1::option::is_some<0x80b92600ee5e10cf728cb8e2f6443ad1aa73d87c3f237da206c3fdcf2813ec04::kettle::Kettle>(&arg0.kettle)) {
            source_to_pool<T0, T1>(arg0, arg1);
            if (0x1::option::is_some<address>(&arg0.kettle_param_object_id)) {
            } else {
                let v0 = 0x2::object::id<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<T2, T1>>(arg2);
                arg0.kettle_param_object_id = 0x1::option::some<address>(0x2::object::id_to_address(&v0));
                let v1 = b"";
                let v2 = b"S";
                let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
                0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::set<vector<u8>>(&mut v1, 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::key(&v2), 0x1::ascii::as_bytes(&v3));
                let v4 = b"R";
                let v5 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
                0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::set<vector<u8>>(&mut v1, 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::key(&v4), 0x1::ascii::as_bytes(&v5));
                let v6 = b"T";
                let v7 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
                0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::set<vector<u8>>(&mut v1, 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::key(&v6), 0x1::ascii::as_bytes(&v7));
                let v8 = b"fountain_core::Fountain<{T:s},{R:s}>";
                arg0.kettle_param_object_type = 0x1::ascii::try_string(0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::format::format(&v8, &v1));
            };
            let v9 = 0x2::clock::timestamp_ms(arg1);
            if (arg0.kettle_boil_period == 0 || arg0.latest_kettle_boil < v9 + arg0.kettle_boil_period) {
                0x2::balance::join<T1>(&mut arg0.source, 0x80b92600ee5e10cf728cb8e2f6443ad1aa73d87c3f237da206c3fdcf2813ec04::kettle::boil_with_fountain<T2, T1>(0x1::option::borrow_mut<0x80b92600ee5e10cf728cb8e2f6443ad1aa73d87c3f237da206c3fdcf2813ec04::kettle::Kettle>(&mut arg0.kettle), arg1, arg2));
                arg0.latest_kettle_boil = v9;
                if (arg0.adjust_flow_amount_to_source_percent > 0) {
                    let v10 = arg0.adjust_flow_amount_to_source_percent;
                    let v11 = v10;
                    if (v10 > 100) {
                        v11 = 100;
                    };
                    arg0.flow_amount = v11 * 0x2::balance::value<T1>(&arg0.source) / 100;
                    let v12 = FlowRateUpdated{
                        condenser_id  : 0x2::object::id<Condenser<T0, T1>>(arg0),
                        flow_amount   : arg0.flow_amount,
                        flow_interval : arg0.flow_interval,
                    };
                    0x2::event::emit<FlowRateUpdated>(v12);
                };
            };
        };
    }

    fun check_admin_cap<T0, T1>(arg0: &AdminCap, arg1: &Condenser<T0, T1>) {
        assert!(arg0.condenser_id == 0x2::object::id<Condenser<T0, T1>>(arg1), 2);
    }

    public fun check_finished<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Condenser<T0, T1>, arg2: address) {
        if (0x2::object_bag::contains<address>(&arg1.staked_bag, arg2)) {
            if (0x2::object_bag::borrow<address, CondenserStakeRecord<T0, T1>>(&arg1.staked_bag, arg2).lock_until < 0x2::clock::timestamp_ms(arg0)) {
                let v0 = 0x2::object::id<Condenser<T0, T1>>(arg1);
                let v1 = claim_balance<T0, T1>(arg0, arg1, arg2);
                let v2 = CondenserFinishedRecord<T0, T1>{
                    condenser_id : v0,
                    reward       : v1,
                    meta         : 0x1::vector::empty<u8>(),
                };
                0x2::bag::add<address, CondenserFinishedRecord<T0, T1>>(&mut arg1.finished_bag, arg2, v2);
            };
        };
    }

    public fun claim<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Condenser<T0, T1>, arg2: &0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::timecapsule::Timecapsule) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::object::id_to_address(0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::timecapsule::id(arg2));
        let v1 = 0x2::object::id<Condenser<T0, T1>>(arg1);
        if (0x2::object_bag::contains<address>(&arg1.staked_bag, v0)) {
            let v2 = claim_balance<T0, T1>(arg0, arg1, v0);
            let v3 = ClaimEvent{
                condenser_id     : v1,
                time_capsule_key : v0,
                reward_amount    : 0x2::balance::value<T1>(&v2),
                claim_time       : 0x2::clock::timestamp_ms(arg0),
            };
            0x2::event::emit<ClaimEvent>(v3);
            return v2
        };
        if (0x2::bag::contains<address>(&arg1.finished_bag, v0)) {
            let CondenserFinishedRecord {
                condenser_id : _,
                reward       : v5,
                meta         : _,
            } = 0x2::bag::remove<address, CondenserFinishedRecord<T0, T1>>(&mut arg1.finished_bag, v0);
            let v7 = v5;
            let v8 = ClaimEvent{
                condenser_id     : v1,
                time_capsule_key : v0,
                reward_amount    : 0x2::balance::value<T1>(&v7),
                claim_time       : 0x2::clock::timestamp_ms(arg0),
            };
            0x2::event::emit<ClaimEvent>(v8);
            return v7
        };
        0x2::balance::zero<T1>()
    }

    fun claim_balance<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Condenser<T0, T1>, arg2: address) : 0x2::balance::Balance<T1> {
        source_to_pool<T0, T1>(arg1, arg0);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::object_bag::borrow_mut<address, CondenserStakeRecord<T0, T1>>(&mut arg1.staked_bag, arg2);
        let v2 = (mul_factor_u128((v1.stake_weight as u128), arg1.cumulative_unit - v1.start_uint, 18446744073709551616) as u64);
        v1.start_uint = arg1.cumulative_unit;
        let v3 = 0x2::balance::split<T1>(&mut arg1.pool, v2);
        if (v1.lock_until >= v0) {
            v1.start_claim_time = v0;
        } else {
            if (v1.start_claim_time > v1.lock_until) {
                0x2::balance::join<T1>(&mut arg1.source, v3);
                return 0x2::balance::zero<T1>()
            };
            0x2::balance::join<T1>(&mut arg1.source, 0x2::balance::split<T1>(&mut v3, v2 - v2 * (v1.lock_until - v1.start_claim_time) * 1000000 / (v0 - v1.start_claim_time) / 1000000));
            let CondenserStakeRecord {
                id               : v4,
                condenser_id     : _,
                stake_amount     : v6,
                start_uint       : _,
                start_claim_time : _,
                stake_weight     : v9,
                lock_until       : _,
                meta             : _,
            } = 0x2::object_bag::remove<address, CondenserStakeRecord<T0, T1>>(&mut arg1.staked_bag, arg2);
            arg1.total_staked = arg1.total_staked - v6;
            arg1.total_weight = arg1.total_weight - v9;
            0x2::object::delete(v4);
        };
        v3
    }

    fun collect_resource<T0, T1>(arg0: &mut Condenser<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg1);
        if (v0 > 0) {
            0x2::balance::join<T1>(&mut arg0.pool, arg1);
            arg0.cumulative_unit = arg0.cumulative_unit + mul_factor_u128((v0 as u128), 18446744073709551616, (arg0.total_weight as u128));
        } else {
            0x2::balance::destroy_zero<T1>(arg1);
        };
    }

    public fun compute_weight(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg1;
        if (arg1 > arg2) {
            v0 = arg2;
        };
        let v1 = mul_factor(arg0, v0, arg2);
        assert!(v1 > 0, 8);
        v1
    }

    fun current_drand_round(arg0: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 1692803367;
        if (v1 > v0) {
            return 0
        };
        (v0 - v1) / 3
    }

    public fun get_reward_amount<T0, T1>(arg0: &Condenser<T0, T1>, arg1: address, arg2: u64) : u64 {
        if (0x2::object_bag::contains<address>(&arg0.staked_bag, arg1)) {
            let v0 = 0x2::object_bag::borrow<address, CondenserStakeRecord<T0, T1>>(&arg0.staked_bag, arg1);
            return (mul_factor_u128((v0.stake_weight as u128), arg0.cumulative_unit + mul_factor_u128((get_virtual_released_amount<T0, T1>(arg0, arg2) as u128), 18446744073709551616, (arg0.total_weight as u128)) - v0.start_uint, 18446744073709551616) as u64)
        };
        if (0x2::bag::contains<address>(&arg0.finished_bag, arg1)) {
            return 0x2::balance::value<T1>(&0x2::bag::borrow<address, CondenserFinishedRecord<T0, T1>>(&arg0.finished_bag, arg1).reward)
        };
        0
    }

    public fun get_reward_info<T0, T1>(arg0: &Condenser<T0, T1>, arg1: address, arg2: u64) : (u64, u64, u64, u64, u64, u64) {
        let v0 = get_reward_amount<T0, T1>(arg0, arg1, arg2);
        let v1 = v0;
        let v2 = get_reward_amount<T0, T1>(arg0, arg1, arg2 + 60000);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        if (0x2::object_bag::contains<address>(&arg0.staked_bag, arg1)) {
            let v7 = 0x2::object_bag::borrow<address, CondenserStakeRecord<T0, T1>>(&arg0.staked_bag, arg1);
            v3 = v7.stake_weight;
            v4 = v7.stake_amount;
            let v8 = v7.lock_until;
            v5 = v8;
            v6 = v7.start_claim_time;
            if (v8 < arg2) {
                let v9 = v0 * (v7.lock_until - v7.start_claim_time) * 1000000 / (arg2 - v7.start_claim_time) / 1000000;
                v1 = v9;
                v2 = v9;
            };
        };
        (v1, v2 - v1, v3, v4, v5, v6)
    }

    public fun get_source_balance<T0, T1>(arg0: &Condenser<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.source)
    }

    public fun get_total_weight<T0, T1>(arg0: &Condenser<T0, T1>) : u64 {
        arg0.total_weight
    }

    public fun get_virtual_released_amount<T0, T1>(arg0: &Condenser<T0, T1>, arg1: u64) : u64 {
        if (arg1 > arg0.latest_release_time) {
            let v1 = mul_factor(arg0.flow_amount, arg1 - arg0.latest_release_time, arg0.flow_interval);
            let v2 = v1;
            let v3 = get_source_balance<T0, T1>(arg0);
            if (v1 > v3) {
                v2 = v3;
            };
            v2
        } else {
            0
        }
    }

    public entry fun mint_condenser<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_condenser_with_admin_cap<T0, T1>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3), arg4);
        0x2::transfer::share_object<Condenser<T0, T1>>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun mul_factor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) / 2) / (arg2 as u128)) as u64)
    }

    public fun mul_factor_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 0);
        (arg0 * arg1 + arg2 / 2) / arg2
    }

    public fun new_condenser<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Condenser<T0, T1> {
        Condenser<T0, T1>{
            id                                   : 0x2::object::new(arg4),
            source                               : 0x2::balance::zero<T1>(),
            flow_amount                          : arg0,
            flow_interval                        : arg1,
            pool                                 : 0x2::balance::zero<T1>(),
            total_weight                         : 0,
            total_staked                         : 0,
            cumulative_unit                      : 0,
            latest_release_time                  : arg3,
            max_lock_time                        : arg2,
            staked_bag                           : 0x2::object_bag::new(arg4),
            finished_bag                         : 0x2::bag::new(arg4),
            kettle                               : 0x1::option::none<0x80b92600ee5e10cf728cb8e2f6443ad1aa73d87c3f237da206c3fdcf2813ec04::kettle::Kettle>(),
            kettle_boil_period                   : 0,
            latest_kettle_boil                   : 0,
            kettle_param_object_id               : 0x1::option::none<address>(),
            kettle_param_object_type             : 0x1::option::none<0x1::ascii::String>(),
            adjust_flow_amount_to_source_percent : 0,
            timecapsule_store_id                 : 0x1::option::none<0x2::object::ID>(),
            meta                                 : 0x1::vector::empty<u8>(),
        }
    }

    public fun new_condenser_with_admin_cap<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (Condenser<T0, T1>, AdminCap) {
        let v0 = new_condenser<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x2::object::id<Condenser<T0, T1>>(&v0);
        let v2 = AdminCap{
            id           : 0x2::object::new(arg4),
            condenser_id : v1,
        };
        let v3 = MintEvent{
            condenser_id : v1,
            admin_cap_id : 0x2::object::id<AdminCap>(&v2),
            type_s       : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            type_r       : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())),
        };
        0x2::event::emit<MintEvent>(v3);
        (v0, v2)
    }

    public entry fun release_kettle<T0, T1>(arg0: &AdminCap, arg1: &mut Condenser<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin_cap<T0, T1>(arg0, arg1);
        0x2::transfer::public_transfer<0x80b92600ee5e10cf728cb8e2f6443ad1aa73d87c3f237da206c3fdcf2813ec04::kettle::Kettle>(0x1::option::extract<0x80b92600ee5e10cf728cb8e2f6443ad1aa73d87c3f237da206c3fdcf2813ec04::kettle::Kettle>(&mut arg1.kettle), 0x2::tx_context::sender(arg2));
    }

    fun release_resource<T0, T1>(arg0: &mut Condenser<T0, T1>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 > arg0.latest_release_time) {
            let v2 = mul_factor(arg0.flow_amount, v0 - arg0.latest_release_time, arg0.flow_interval);
            let v3 = v2;
            let v4 = get_source_balance<T0, T1>(arg0);
            if (v2 > v4) {
                v3 = v4;
            };
            arg0.latest_release_time = v0;
            0x2::balance::split<T1>(&mut arg0.source, v3)
        } else {
            0x2::balance::zero<T1>()
        }
    }

    fun source_to_pool<T0, T1>(arg0: &mut Condenser<T0, T1>, arg1: &0x2::clock::Clock) {
        if (get_source_balance<T0, T1>(arg0) > 0 && get_total_weight<T0, T1>(arg0) > 0) {
            let v0 = release_resource<T0, T1>(arg0, arg1);
            collect_resource<T0, T1>(arg0, v0);
        } else {
            let v1 = 0x2::clock::timestamp_ms(arg1);
            if (v1 > arg0.latest_release_time) {
                arg0.latest_release_time = v1;
            };
        };
    }

    public fun stake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Condenser<T0, T1>, arg2: &0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::timecapsule::Timecapsule, arg3: &mut 0x2::tx_context::TxContext) {
        source_to_pool<T0, T1>(arg1, arg0);
        let v0 = 0x2::object::id_to_address(0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::timecapsule::id(arg2));
        let v1 = 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::timecapsule::stored_coin_amount<T0>(arg2);
        let v2 = 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::timecapsule::for_round(arg2);
        let v3 = current_drand_round(arg0);
        assert!(v3 < v2, 7);
        let v4 = (v2 - v3) * 3000;
        let v5 = compute_weight(v1, v4, arg1.max_lock_time);
        if (0x2::object_bag::contains<address>(&arg1.staked_bag, v0)) {
            let v6 = 0x2::object_bag::borrow_mut<address, CondenserStakeRecord<T0, T1>>(&mut arg1.staked_bag, v0);
            if (v1 > v6.stake_amount) {
                arg1.total_staked = arg1.total_staked + v1 - v6.stake_amount;
                v6.stake_amount = v1;
            };
            if (v5 > v6.stake_weight) {
                let v7 = StakeEvent{
                    condenser_id          : 0x2::object::id<Condenser<T0, T1>>(arg1),
                    time_capsule_key      : v0,
                    stake_amount          : v1,
                    stake_weight          : v5,
                    stake_amount_increase : v5 - v6.stake_weight,
                    lock_until            : v6.lock_until,
                };
                0x2::event::emit<StakeEvent>(v7);
                arg1.total_weight = arg1.total_weight - v6.stake_weight + v5;
                v6.stake_weight = v5;
                v6.stake_amount = v1;
            };
        } else {
            arg1.total_weight = arg1.total_weight + v5;
            arg1.total_staked = arg1.total_staked + v1;
            let v8 = 0x2::object::id<Condenser<T0, T1>>(arg1);
            let v9 = 0x2::clock::timestamp_ms(arg0);
            let v10 = v9 + v4;
            let v11 = StakeEvent{
                condenser_id          : v8,
                time_capsule_key      : v0,
                stake_amount          : v1,
                stake_weight          : v5,
                stake_amount_increase : 0,
                lock_until            : v10,
            };
            0x2::event::emit<StakeEvent>(v11);
            let v12 = CondenserStakeRecord<T0, T1>{
                id               : 0x2::object::new(arg3),
                condenser_id     : v8,
                stake_amount     : v1,
                start_uint       : arg1.cumulative_unit,
                start_claim_time : v9,
                stake_weight     : v5,
                lock_until       : v10,
                meta             : 0x1::vector::empty<u8>(),
            };
            0x2::object_bag::add<address, CondenserStakeRecord<T0, T1>>(&mut arg1.staked_bag, v0, v12);
        };
    }

    public fun supply<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Condenser<T0, T1>, arg2: 0x2::balance::Balance<T1>) {
        source_to_pool<T0, T1>(arg1, arg0);
        0x2::balance::join<T1>(&mut arg1.source, arg2);
    }

    public fun supply_coin<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Condenser<T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        source_to_pool<T0, T1>(arg1, arg0);
        0x2::balance::join<T1>(&mut arg1.source, 0x2::coin::into_balance<T1>(arg2));
    }

    public fun total_weight<T0, T1>(arg0: &Condenser<T0, T1>) : u64 {
        arg0.total_weight
    }

    public entry fun update_flow_rate<T0, T1>(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut Condenser<T0, T1>, arg3: u64, arg4: u64) {
        check_admin_cap<T0, T1>(arg0, arg2);
        source_to_pool<T0, T1>(arg2, arg1);
        arg2.flow_amount = arg3;
        arg2.flow_interval = arg4;
        let v0 = FlowRateUpdated{
            condenser_id  : 0x2::object::id<Condenser<T0, T1>>(arg2),
            flow_amount   : arg3,
            flow_interval : arg4,
        };
        0x2::event::emit<FlowRateUpdated>(v0);
    }

    public entry fun update_kettle_settings<T0, T1>(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut Condenser<T0, T1>, arg3: u64, arg4: u64) {
        check_admin_cap<T0, T1>(arg0, arg2);
        arg2.kettle_boil_period = arg3;
        arg2.adjust_flow_amount_to_source_percent = arg4;
    }

    // decompiled from Move bytecode v6
}

