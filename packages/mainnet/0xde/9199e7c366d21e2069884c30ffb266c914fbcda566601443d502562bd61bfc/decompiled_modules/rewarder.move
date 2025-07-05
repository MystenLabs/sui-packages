module 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::rewarder {
    struct RewarderManager has store {
        rewarders: vector<Rewarder>,
        last_update_time: u64,
        pending_rewards: vector<u128>,
    }

    struct Rewarder has copy, drop, store {
        reward_coin: 0x1::type_name::TypeName,
        emissions_per_second: u128,
        growth_global: u128,
    }

    struct FeeTracking {
        bin_fees: 0x2::table::Table<u32, FeeAmounts>,
        total_fees: FeeAmounts,
        bin_ids: vector<u32>,
    }

    struct FeeAmounts has copy, drop, store {
        fee_x: u64,
        fee_y: u64,
    }

    struct RewardDistribution has drop {
        bin_id: u32,
        reward_amount: u128,
        rewarder_index: u64,
    }

    struct RewarderGlobalVault has store, key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    struct RewarderAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewarderInitEvent has copy, drop {
        global_vault_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct EmissionUpdateEvent has copy, drop {
        pool: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        old_rate: u128,
        new_rate: u128,
    }

    struct DepositEvent has copy, drop {
        vault: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        total_balance: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        remaining_balance: u64,
    }

    struct RewardDistributionEvent has copy, drop {
        pool: 0x2::object::ID,
        bins_count: u64,
        total_rewards_distributed: vector<u64>,
    }

    public(friend) fun new() : RewarderManager {
        RewarderManager{
            rewarders        : 0x1::vector::empty<Rewarder>(),
            last_update_time : 0,
            pending_rewards  : 0x1::vector::empty<u128>(),
        }
    }

    fun accumulate_pending_rewards(arg0: &mut RewarderManager, arg1: u64) {
        if (arg1 <= arg0.last_update_time) {
            return
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            let v1 = 0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0);
            if (v1.emissions_per_second > 0) {
                let v2 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::mul_u128(v1.emissions_per_second, ((arg1 - arg0.last_update_time) as u128));
                let v3 = 0x1::vector::borrow_mut<u128>(&mut arg0.pending_rewards, v0);
                *v3 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u128(*v3, v2);
            };
            v0 = v0 + 1;
        };
        arg0.last_update_time = arg1;
    }

    public(friend) fun add_rewarder<T0>(arg0: &mut RewarderManager, arg1: 0x2::object::ID) {
        assert!(0x1::vector::length<Rewarder>(&arg0.rewarders) < 5, 3000);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!rewarder_exists(arg0, v0), 3001);
        let v1 = Rewarder{
            reward_coin          : v0,
            emissions_per_second : 0,
            growth_global        : 0,
        };
        0x1::vector::push_back<Rewarder>(&mut arg0.rewarders, v1);
        0x1::vector::push_back<u128>(&mut arg0.pending_rewards, 0);
    }

    public fun balance_of<T0>(arg0: &RewarderGlobalVault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        }
    }

    fun calculate_bin_reward_share(arg0: &FeeAmounts, arg1: &FeeAmounts, arg2: u128) : u128 {
        let v0 = if (arg1.fee_x > 0) {
            ((arg0.fee_x as u128) << 64) / (arg1.fee_x as u128)
        } else {
            0
        };
        let v1 = if (arg1.fee_y > 0) {
            ((arg0.fee_y as u128) << 64) / (arg1.fee_y as u128)
        } else {
            0
        };
        arg2 * 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::max_u128(v0, v1) >> 64
    }

    public(friend) fun calculate_reward_distributions(arg0: &mut RewarderManager, arg1: FeeTracking, arg2: 0x2::object::ID, arg3: u64) : vector<RewardDistribution> {
        accumulate_pending_rewards(arg0, arg3);
        let FeeTracking {
            bin_fees   : v0,
            total_fees : v1,
            bin_ids    : v2,
        } = arg1;
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (v4.fee_x == 0 && v4.fee_y == 0) {
            0x2::table::drop<u32, FeeAmounts>(v5);
            return 0x1::vector::empty<RewardDistribution>()
        };
        let v6 = 0x1::vector::empty<RewardDistribution>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            let v9 = *0x1::vector::borrow<u128>(&arg0.pending_rewards, v8);
            let v10 = 0;
            if (v9 > 0) {
                let v11 = 0;
                while (v11 < 0x1::vector::length<u32>(&v3)) {
                    let v12 = *0x1::vector::borrow<u32>(&v3, v11);
                    let v13 = calculate_bin_reward_share(0x2::table::borrow<u32, FeeAmounts>(&v5, v12), &v4, v9);
                    if (v13 > 0) {
                        let v14 = RewardDistribution{
                            bin_id         : v12,
                            reward_amount  : v13,
                            rewarder_index : v8,
                        };
                        0x1::vector::push_back<RewardDistribution>(&mut v6, v14);
                        v10 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(v10, 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::u128_to_u64(v13));
                    };
                    v11 = v11 + 1;
                };
                *0x1::vector::borrow_mut<u128>(&mut arg0.pending_rewards, v8) = 0;
            };
            0x1::vector::push_back<u64>(&mut v7, v10);
            v8 = v8 + 1;
        };
        0x2::table::drop<u32, FeeAmounts>(v5);
        let v15 = RewardDistributionEvent{
            pool                      : arg2,
            bins_count                : 0x1::vector::length<u32>(&v3),
            total_rewards_distributed : v7,
        };
        0x2::event::emit<RewardDistributionEvent>(v15);
        v6
    }

    public fun calculate_reward_growth(arg0: u64, arg1: u128) : u128 {
        assert!(arg1 > 0, 3009);
        ((arg0 as u128) << 64) / arg1
    }

    public fun calculate_rewards_owed(arg0: u128, arg1: u128, arg2: u128) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg2 >= arg1) {
            arg2 - arg1
        } else {
            0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u128(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u128(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::sub_u128(340282366920938463463374607431768211455, arg1), arg2), 1)
        };
        let v1 = arg0 * v0 >> 64;
        if (v1 > (18446744073709551615 as u128)) {
            18446744073709551615
        } else {
            (v1 as u64)
        }
    }

    public fun deposit_reward<T0>(arg0: &mut RewarderGlobalVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        0x2::balance::join<T0>(v1, arg1);
        let v2 = DepositEvent{
            vault         : 0x2::object::id<RewarderGlobalVault>(arg0),
            reward_type   : v0,
            amount        : 0x2::balance::value<T0>(&arg1),
            total_balance : 0x2::balance::value<T0>(v1),
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public(friend) fun destroy_fee_tracking(arg0: FeeTracking) {
        let FeeTracking {
            bin_fees   : v0,
            total_fees : _,
            bin_ids    : _,
        } = arg0;
        0x2::table::drop<u32, FeeAmounts>(v0);
    }

    public fun emergency_withdraw<T0>(arg0: &RewarderAdminCap, arg1: &mut RewarderGlobalVault, arg2: u64) : 0x2::balance::Balance<T0> {
        withdraw_reward<T0>(arg1, arg2)
    }

    public fun emission_rate<T0>(arg0: &RewarderManager) : u128 {
        let v0 = find_rewarder(arg0, 0x1::type_name::get<T0>());
        if (0x1::option::is_some<Rewarder>(&v0)) {
            0x1::option::borrow<Rewarder>(&v0).emissions_per_second
        } else {
            0
        }
    }

    fun find_rewarder(arg0: &RewarderManager, arg1: 0x1::type_name::TypeName) : 0x1::option::Option<Rewarder> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            let v1 = 0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0);
            if (v1.reward_coin == arg1) {
                return 0x1::option::some<Rewarder>(*v1)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<Rewarder>()
    }

    fun find_rewarder_mut(arg0: &mut RewarderManager, arg1: 0x1::type_name::TypeName) : &mut Rewarder {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            if (0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).reward_coin == arg1) {
                return 0x1::vector::borrow_mut<Rewarder>(&mut arg0.rewarders, v0)
            };
            v0 = v0 + 1;
        };
        abort 3004
    }

    public fun get_distribution_info(arg0: &RewardDistribution) : (u32, u128, u64) {
        (arg0.bin_id, arg0.reward_amount, arg0.rewarder_index)
    }

    public fun get_pending_rewards(arg0: &RewarderManager) : &vector<u128> {
        &arg0.pending_rewards
    }

    public fun get_rewarders(arg0: &RewarderManager) : &vector<Rewarder> {
        &arg0.rewarders
    }

    public fun growth_precision_shift() : u8 {
        64
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewarderGlobalVault{
            id       : 0x2::object::new(arg0),
            balances : 0x2::bag::new(arg0),
        };
        let v1 = RewarderAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RewarderGlobalVault>(v0);
        0x2::transfer::transfer<RewarderAdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = RewarderInitEvent{
            global_vault_id : 0x2::object::id<RewarderGlobalVault>(&v0),
            admin_cap_id    : 0x2::object::id<RewarderAdminCap>(&v1),
        };
        0x2::event::emit<RewarderInitEvent>(v2);
    }

    public fun last_update_time(arg0: &RewarderManager) : u64 {
        arg0.last_update_time
    }

    public fun max_rewarders_per_pool() : u64 {
        5
    }

    public fun min_emission_duration() : u64 {
        86400
    }

    public(friend) fun new_fee_tracking(arg0: &mut 0x2::tx_context::TxContext) : FeeTracking {
        let v0 = FeeAmounts{
            fee_x : 0,
            fee_y : 0,
        };
        FeeTracking{
            bin_fees   : 0x2::table::new<u32, FeeAmounts>(arg0),
            total_fees : v0,
            bin_ids    : 0x1::vector::empty<u32>(),
        }
    }

    fun rewarder_exists(arg0: &RewarderManager, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            if (0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).reward_coin == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun rewarder_index<T0>(arg0: &RewarderManager) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            if (0x1::vector::borrow<Rewarder>(&arg0.rewarders, v0).reward_coin == 0x1::type_name::get<T0>()) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public(friend) fun settle_rewards(arg0: &mut RewarderManager, arg1: u64) {
        accumulate_pending_rewards(arg0, arg1);
    }

    public(friend) fun track_bin_fees(arg0: &mut FeeTracking, arg1: u32, arg2: u64, arg3: u64) {
        if (!0x2::table::contains<u32, FeeAmounts>(&arg0.bin_fees, arg1)) {
            let v0 = FeeAmounts{
                fee_x : 0,
                fee_y : 0,
            };
            0x2::table::add<u32, FeeAmounts>(&mut arg0.bin_fees, arg1, v0);
            0x1::vector::push_back<u32>(&mut arg0.bin_ids, arg1);
        };
        let v1 = 0x2::table::borrow_mut<u32, FeeAmounts>(&mut arg0.bin_fees, arg1);
        v1.fee_x = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(v1.fee_x, arg2);
        v1.fee_y = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(v1.fee_y, arg3);
        arg0.total_fees.fee_x = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.total_fees.fee_x, arg2);
        arg0.total_fees.fee_y = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::add_u64(arg0.total_fees.fee_y, arg3);
    }

    public(friend) fun update_emission<T0>(arg0: &RewarderGlobalVault, arg1: &mut RewarderManager, arg2: 0x2::object::ID, arg3: u128, arg4: u64) {
        accumulate_pending_rewards(arg1, arg4);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = find_rewarder_mut(arg1, v0);
        let v2 = v1.emissions_per_second;
        if (arg3 > v2 && arg3 > 0) {
            assert!(balance_of<T0>(arg0) >= 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::u128_to_u64(0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::safe_math::mul_u128(arg3, (86400 as u128))), 3003);
        };
        v1.emissions_per_second = arg3;
        let v3 = EmissionUpdateEvent{
            pool        : arg2,
            reward_type : v0,
            old_rate    : v2,
            new_rate    : arg3,
        };
        0x2::event::emit<EmissionUpdateEvent>(v3);
    }

    public(friend) fun update_rewards_growth(arg0: &mut RewarderManager, arg1: u128, arg2: u64) : vector<u128> {
        let v0 = arg0.last_update_time + arg2;
        accumulate_pending_rewards(arg0, v0);
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Rewarder>(&arg0.rewarders)) {
            0x1::vector::push_back<u128>(&mut v1, 0);
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut RewarderGlobalVault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 3004);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 3003);
        let v2 = 0x2::balance::split<T0>(v1, arg1);
        let v3 = WithdrawEvent{
            vault             : 0x2::object::id<RewarderGlobalVault>(arg0),
            reward_type       : v0,
            amount            : arg1,
            remaining_balance : 0x2::balance::value<T0>(v1),
        };
        0x2::event::emit<WithdrawEvent>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

