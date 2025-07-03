module 0x7235d6e6ba2b1829503197489d2f7ea45b9a797976ccf54113e0f6855f37ac67::reward_distribution {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct CoinVault<phantom T0> has store {
        coin_type: 0x1::string::String,
        vault: 0x7235d6e6ba2b1829503197489d2f7ea45b9a797976ccf54113e0f6855f37ac67::vault::Vault<T0>,
        total_rewards: u64,
        distributed_rewards: u64,
    }

    struct RewardDistributor has key {
        id: 0x2::object::UID,
        period_rewards: 0x2::table::Table<u32, 0x2::table::Table<address, u64>>,
        period_vaults: 0x2::table::Table<u32, vector<0x1::string::String>>,
        supported_coin_types: vector<0x1::string::String>,
        claimed_rewards: 0x2::table::Table<u32, 0x2::table::Table<address, vector<0x1::string::String>>>,
        period_keys: vector<u32>,
        period_total_percentages: 0x2::table::Table<u32, u64>,
    }

    struct CoinTypeKey<phantom T0> has copy, drop, store {
        period: u32,
    }

    struct UserRewardAdded has copy, drop {
        period: u32,
        user: address,
        percentage: u64,
    }

    struct RewardDeposited has copy, drop {
        period: u32,
        coin_type: 0x1::string::String,
        amount: u64,
    }

    struct RewardClaimed has copy, drop {
        user: address,
        period: u32,
        coin_type: 0x1::string::String,
        amount: u64,
    }

    struct UnclaimedReward has copy, drop, store {
        period: u32,
        coin_type: 0x1::string::String,
        amount: u64,
    }

    public entry fun add_user_rewards(arg0: &OperatorCap, arg1: &mut RewardDistributor, arg2: u32, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 0);
        if (!0x2::table::contains<u32, 0x2::table::Table<address, u64>>(&arg1.period_rewards, arg2)) {
            0x2::table::add<u32, 0x2::table::Table<address, u64>>(&mut arg1.period_rewards, arg2, 0x2::table::new<address, u64>(arg5));
        };
        if (!0x2::table::contains<u32, vector<0x1::string::String>>(&arg1.period_vaults, arg2)) {
            0x2::table::add<u32, vector<0x1::string::String>>(&mut arg1.period_vaults, arg2, 0x1::vector::empty<0x1::string::String>());
        };
        if (!0x1::vector::contains<u32>(&arg1.period_keys, &arg2)) {
            0x1::vector::push_back<u32>(&mut arg1.period_keys, arg2);
        };
        if (!0x2::table::contains<u32, u64>(&arg1.period_total_percentages, arg2)) {
            0x2::table::add<u32, u64>(&mut arg1.period_total_percentages, arg2, 0);
        };
        let v1 = 0x2::table::borrow_mut<u32, 0x2::table::Table<address, u64>>(&mut arg1.period_rewards, arg2);
        let v2 = *0x2::table::borrow<u32, u64>(&arg1.period_total_percentages, arg2);
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<address>(&arg3, v3);
            let v5 = *0x1::vector::borrow<u64>(&arg4, v3);
            if (0x2::table::contains<address, u64>(v1, v4)) {
                v2 = v2 - *0x2::table::borrow<address, u64>(v1, v4);
            };
            let v6 = v2 + v5;
            v2 = v6;
            assert!(v6 <= 1000000000, 6);
            if (0x2::table::contains<address, u64>(v1, v4)) {
                *0x2::table::borrow_mut<address, u64>(v1, v4) = v5;
            } else {
                0x2::table::add<address, u64>(v1, v4, v5);
            };
            let v7 = UserRewardAdded{
                period     : arg2,
                user       : v4,
                percentage : v5,
            };
            0x2::event::emit<UserRewardAdded>(v7);
            v3 = v3 + 1;
        };
        *0x2::table::borrow_mut<u32, u64>(&mut arg1.period_total_percentages, arg2) = v2;
    }

    public entry fun admin_withdraw_unclaimed_rewards<T0>(arg0: &OperatorCap, arg1: &mut RewardDistributor, arg2: u32, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u32, vector<0x1::string::String>>(&arg1.period_vaults, arg2), 2);
        let v0 = get_coin_type_name<T0>();
        assert!(0x1::vector::contains<0x1::string::String>(0x2::table::borrow<u32, vector<0x1::string::String>>(&arg1.period_vaults, arg2), &v0), 8);
        let v1 = CoinTypeKey<T0>{period: arg2};
        assert!(0x2::dynamic_field::exists_with_type<CoinTypeKey<T0>, CoinVault<T0>>(&arg1.id, v1), 8);
        let v2 = 0x2::dynamic_field::borrow_mut<CoinTypeKey<T0>, CoinVault<T0>>(&mut arg1.id, v1);
        let v3 = 0x7235d6e6ba2b1829503197489d2f7ea45b9a797976ccf54113e0f6855f37ac67::vault::vault_amount<T0>(&v2.vault);
        if (v3 > 0) {
            v2.distributed_rewards = v2.distributed_rewards + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x7235d6e6ba2b1829503197489d2f7ea45b9a797976ccf54113e0f6855f37ac67::vault::withdraw<T0>(&mut v2.vault, v3), arg4), arg3);
            let v4 = RewardClaimed{
                user      : arg3,
                period    : arg2,
                coin_type : v0,
                amount    : v3,
            };
            0x2::event::emit<RewardClaimed>(v4);
        };
    }

    fun check_all_coins_claimed(arg0: &vector<0x1::string::String>, arg1: &0x2::table::Table<u32, 0x2::table::Table<address, vector<0x1::string::String>>>, arg2: address, arg3: u32) : bool {
        if (!0x2::table::contains<u32, 0x2::table::Table<address, vector<0x1::string::String>>>(arg1, arg3)) {
            return false
        };
        let v0 = 0x2::table::borrow<u32, 0x2::table::Table<address, vector<0x1::string::String>>>(arg1, arg3);
        if (!0x2::table::contains<address, vector<0x1::string::String>>(v0, arg2)) {
            return false
        };
        let v1 = 0x2::table::borrow<address, vector<0x1::string::String>>(v0, arg2);
        let v2 = 0x1::vector::length<0x1::string::String>(arg0);
        if (0x1::vector::length<0x1::string::String>(v1) < v2) {
            return false
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<0x1::string::String>(arg0, v3);
            if (!0x1::vector::contains<0x1::string::String>(v1, &v4)) {
                return false
            };
            v3 = v3 + 1;
        };
        true
    }

    public entry fun claim_rewards<T0>(arg0: &mut RewardDistributor, arg1: vector<u32>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(claim_rewards_coin<T0>(arg0, arg1, arg2), v0);
    }

    public fun claim_rewards_coin<T0>(arg0: &mut RewardDistributor, arg1: vector<u32>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = get_coin_type_name<T0>();
        let v2 = 0;
        let v3 = 0x2::balance::zero<T0>();
        while (v2 < 0x1::vector::length<u32>(&arg1)) {
            let v4 = *0x1::vector::borrow<u32>(&arg1, v2);
            assert!(0x2::table::contains<u32, 0x2::table::Table<address, u64>>(&arg0.period_rewards, v4), 2);
            assert!(0x2::table::contains<u32, vector<0x1::string::String>>(&arg0.period_vaults, v4), 2);
            let v5 = 0x2::table::borrow_mut<u32, 0x2::table::Table<address, u64>>(&mut arg0.period_rewards, v4);
            assert!(0x2::table::contains<address, u64>(v5, v0), 3);
            let v6 = *0x2::table::borrow<address, u64>(v5, v0);
            let v7 = 0x2::table::borrow<u32, vector<0x1::string::String>>(&arg0.period_vaults, v4);
            let v8 = CoinTypeKey<T0>{period: v4};
            let v9 = false;
            if (0x2::table::contains<u32, 0x2::table::Table<address, vector<0x1::string::String>>>(&arg0.claimed_rewards, v4)) {
                let v10 = 0x2::table::borrow<u32, 0x2::table::Table<address, vector<0x1::string::String>>>(&arg0.claimed_rewards, v4);
                if (0x2::table::contains<address, vector<0x1::string::String>>(v10, v0)) {
                    v9 = 0x1::vector::contains<0x1::string::String>(0x2::table::borrow<address, vector<0x1::string::String>>(v10, v0), &v1);
                };
            };
            if (!v9) {
                if (0x1::vector::contains<0x1::string::String>(v7, &v1) && 0x2::dynamic_field::exists_with_type<CoinTypeKey<T0>, CoinVault<T0>>(&arg0.id, v8)) {
                    let v11 = 0x2::dynamic_field::borrow_mut<CoinTypeKey<T0>, CoinVault<T0>>(&mut arg0.id, v8);
                    let v12 = if (v4 <= 2) {
                        1000000
                    } else {
                        1000000000
                    };
                    let v13 = (((v11.total_rewards as u128) * (v6 as u128) / (v12 as u128)) as u64);
                    let v14 = v13;
                    if (v13 > 0) {
                        if (v13 >= 0x7235d6e6ba2b1829503197489d2f7ea45b9a797976ccf54113e0f6855f37ac67::vault::vault_amount<T0>(&v11.vault)) {
                            v14 = 0x7235d6e6ba2b1829503197489d2f7ea45b9a797976ccf54113e0f6855f37ac67::vault::vault_amount<T0>(&v11.vault);
                        };
                        v11.distributed_rewards = v11.distributed_rewards + v14;
                        0x2::balance::join<T0>(&mut v3, 0x7235d6e6ba2b1829503197489d2f7ea45b9a797976ccf54113e0f6855f37ac67::vault::withdraw<T0>(&mut v11.vault, v14));
                        let v15 = RewardClaimed{
                            user      : v0,
                            period    : v4,
                            coin_type : v1,
                            amount    : v14,
                        };
                        0x2::event::emit<RewardClaimed>(v15);
                    };
                };
                if (!0x2::table::contains<u32, 0x2::table::Table<address, vector<0x1::string::String>>>(&arg0.claimed_rewards, v4)) {
                    0x2::table::add<u32, 0x2::table::Table<address, vector<0x1::string::String>>>(&mut arg0.claimed_rewards, v4, 0x2::table::new<address, vector<0x1::string::String>>(arg2));
                };
                let v16 = 0x2::table::borrow_mut<u32, 0x2::table::Table<address, vector<0x1::string::String>>>(&mut arg0.claimed_rewards, v4);
                if (!0x2::table::contains<address, vector<0x1::string::String>>(v16, v0)) {
                    0x2::table::add<address, vector<0x1::string::String>>(v16, v0, 0x1::vector::singleton<0x1::string::String>(v1));
                } else {
                    0x1::vector::push_back<0x1::string::String>(0x2::table::borrow_mut<address, vector<0x1::string::String>>(v16, v0), v1);
                };
            };
            if (check_all_coins_claimed(&arg0.supported_coin_types, &arg0.claimed_rewards, v0, v4)) {
                0x2::table::remove<address, u64>(v5, v0);
            };
            v2 = v2 + 1;
        };
        0x2::coin::from_balance<T0>(v3, arg2)
    }

    public entry fun deposit_reward<T0>(arg0: &OperatorCap, arg1: &mut RewardDistributor, arg2: u32, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_coin_type_name<T0>();
        let v1 = 0x2::coin::value<T0>(&arg3);
        if (!0x2::table::contains<u32, vector<0x1::string::String>>(&arg1.period_vaults, arg2)) {
            0x2::table::add<u32, vector<0x1::string::String>>(&mut arg1.period_vaults, arg2, 0x1::vector::empty<0x1::string::String>());
        };
        let v2 = 0x2::table::borrow_mut<u32, vector<0x1::string::String>>(&mut arg1.period_vaults, arg2);
        if (!0x1::vector::contains<0x1::string::String>(&arg1.supported_coin_types, &v0)) {
            0x1::vector::push_back<0x1::string::String>(&mut arg1.supported_coin_types, v0);
        };
        if (!0x1::vector::contains<u32>(&arg1.period_keys, &arg2)) {
            0x1::vector::push_back<u32>(&mut arg1.period_keys, arg2);
        };
        let v3 = CoinTypeKey<T0>{period: arg2};
        if (!0x1::vector::contains<0x1::string::String>(v2, &v0)) {
            let v4 = 0x7235d6e6ba2b1829503197489d2f7ea45b9a797976ccf54113e0f6855f37ac67::vault::new<T0>(arg4);
            0x7235d6e6ba2b1829503197489d2f7ea45b9a797976ccf54113e0f6855f37ac67::vault::deposit<T0>(&mut v4, 0x2::coin::into_balance<T0>(arg3));
            let v5 = CoinVault<T0>{
                coin_type           : v0,
                vault               : v4,
                total_rewards       : v1,
                distributed_rewards : 0,
            };
            0x2::dynamic_field::add<CoinTypeKey<T0>, CoinVault<T0>>(&mut arg1.id, v3, v5);
            0x1::vector::push_back<0x1::string::String>(v2, v0);
        } else {
            let v6 = 0x2::dynamic_field::borrow_mut<CoinTypeKey<T0>, CoinVault<T0>>(&mut arg1.id, v3);
            0x7235d6e6ba2b1829503197489d2f7ea45b9a797976ccf54113e0f6855f37ac67::vault::deposit<T0>(&mut v6.vault, 0x2::coin::into_balance<T0>(arg3));
            v6.total_rewards = v6.total_rewards + v1;
        };
        let v7 = RewardDeposited{
            period    : arg2,
            coin_type : v0,
            amount    : v1,
        };
        0x2::event::emit<RewardDeposited>(v7);
    }

    public fun get_all_periods(arg0: &RewardDistributor) : vector<u32> {
        arg0.period_keys
    }

    public fun get_coin_type_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun get_period_reward_info<T0>(arg0: &RewardDistributor, arg1: u32, arg2: 0x1::string::String) : (u64, u64, u64) {
        if (!0x2::table::contains<u32, vector<0x1::string::String>>(&arg0.period_vaults, arg1)) {
            return (0, 0, 0)
        };
        if (!0x1::vector::contains<0x1::string::String>(0x2::table::borrow<u32, vector<0x1::string::String>>(&arg0.period_vaults, arg1), &arg2)) {
            return (0, 0, 0)
        };
        let v0 = CoinTypeKey<T0>{period: arg1};
        if (arg2 == get_coin_type_name<T0>() && 0x2::dynamic_field::exists_with_type<CoinTypeKey<T0>, CoinVault<T0>>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow<CoinTypeKey<T0>, CoinVault<T0>>(&arg0.id, v0);
            return (v1.total_rewards, v1.distributed_rewards, 0x7235d6e6ba2b1829503197489d2f7ea45b9a797976ccf54113e0f6855f37ac67::vault::vault_amount<T0>(&v1.vault))
        };
        (0, 0, 0)
    }

    public fun get_period_total_percentage(arg0: &RewardDistributor, arg1: u32) : u64 {
        if (!0x2::table::contains<u32, u64>(&arg0.period_total_percentages, arg1)) {
            return 0
        };
        *0x2::table::borrow<u32, u64>(&arg0.period_total_percentages, arg1)
    }

    public fun get_period_users_count(arg0: &RewardDistributor, arg1: u32) : u64 {
        if (!0x2::table::contains<u32, 0x2::table::Table<address, u64>>(&arg0.period_rewards, arg1)) {
            return 0
        };
        0x2::table::length<address, u64>(0x2::table::borrow<u32, 0x2::table::Table<address, u64>>(&arg0.period_rewards, arg1))
    }

    public fun get_supported_coin_types(arg0: &RewardDistributor) : vector<0x1::string::String> {
        arg0.supported_coin_types
    }

    public fun get_unclaimed_periods(arg0: &RewardDistributor, arg1: address) : vector<u32> {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = get_all_periods(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&v1)) {
            let v3 = *0x1::vector::borrow<u32>(&v1, v2);
            if (0x2::table::contains<u32, 0x2::table::Table<address, u64>>(&arg0.period_rewards, v3)) {
                if (0x2::table::contains<address, u64>(0x2::table::borrow<u32, 0x2::table::Table<address, u64>>(&arg0.period_rewards, v3), arg1)) {
                    if (0x2::table::contains<u32, vector<0x1::string::String>>(&arg0.period_vaults, v3)) {
                        0x2::table::borrow<u32, vector<0x1::string::String>>(&arg0.period_vaults, v3);
                        if (!check_all_coins_claimed(&arg0.supported_coin_types, &arg0.claimed_rewards, arg1, v3)) {
                            0x1::vector::push_back<u32>(&mut v0, v3);
                        };
                    } else {
                        0x1::vector::push_back<u32>(&mut v0, v3);
                    };
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_user_percentage(arg0: &RewardDistributor, arg1: address, arg2: u32) : u64 {
        if (!0x2::table::contains<u32, 0x2::table::Table<address, u64>>(&arg0.period_rewards, arg2)) {
            return 0
        };
        let v0 = 0x2::table::borrow<u32, 0x2::table::Table<address, u64>>(&arg0.period_rewards, arg2);
        if (!0x2::table::contains<address, u64>(v0, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(v0, arg1)
    }

    public fun get_user_unclaimed_rewards<T0>(arg0: &RewardDistributor, arg1: address) : vector<UnclaimedReward> {
        let v0 = 0x1::vector::empty<UnclaimedReward>();
        let v1 = get_coin_type_name<T0>();
        let v2 = get_all_periods(arg0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u32>(&v2)) {
            let v4 = *0x1::vector::borrow<u32>(&v2, v3);
            if (0x2::table::contains<u32, 0x2::table::Table<address, u64>>(&arg0.period_rewards, v4)) {
                let v5 = 0x2::table::borrow<u32, 0x2::table::Table<address, u64>>(&arg0.period_rewards, v4);
                if (0x2::table::contains<address, u64>(v5, arg1)) {
                    let v6 = *0x2::table::borrow<address, u64>(v5, arg1);
                    if (0x2::table::contains<u32, vector<0x1::string::String>>(&arg0.period_vaults, v4)) {
                        let v7 = 0x2::table::borrow<u32, vector<0x1::string::String>>(&arg0.period_vaults, v4);
                        let v8 = CoinTypeKey<T0>{period: v4};
                        let v9 = false;
                        if (0x2::table::contains<u32, 0x2::table::Table<address, vector<0x1::string::String>>>(&arg0.claimed_rewards, v4)) {
                            let v10 = 0x2::table::borrow<u32, 0x2::table::Table<address, vector<0x1::string::String>>>(&arg0.claimed_rewards, v4);
                            if (0x2::table::contains<address, vector<0x1::string::String>>(v10, arg1)) {
                                v9 = 0x1::vector::contains<0x1::string::String>(0x2::table::borrow<address, vector<0x1::string::String>>(v10, arg1), &v1);
                            };
                        };
                        if (!v9) {
                            if (0x1::vector::contains<0x1::string::String>(v7, &v1) && 0x2::dynamic_field::exists_with_type<CoinTypeKey<T0>, CoinVault<T0>>(&arg0.id, v8)) {
                                let v11 = 0x2::dynamic_field::borrow<CoinTypeKey<T0>, CoinVault<T0>>(&arg0.id, v8);
                                let v12 = if (v4 <= 2) {
                                    1000000
                                } else {
                                    1000000000
                                };
                                let v13 = (((v11.total_rewards as u128) * (v6 as u128) / (v12 as u128)) as u64);
                                let v14 = v13;
                                if (v13 > 0) {
                                    if (v13 >= 0x7235d6e6ba2b1829503197489d2f7ea45b9a797976ccf54113e0f6855f37ac67::vault::vault_amount<T0>(&v11.vault)) {
                                        v14 = 0x7235d6e6ba2b1829503197489d2f7ea45b9a797976ccf54113e0f6855f37ac67::vault::vault_amount<T0>(&v11.vault);
                                    };
                                    if (v14 > 0) {
                                        let v15 = UnclaimedReward{
                                            period    : v4,
                                            coin_type : v1,
                                            amount    : v14,
                                        };
                                        0x1::vector::push_back<UnclaimedReward>(&mut v0, v15);
                                    };
                                };
                            };
                        };
                    };
                };
            };
            v3 = v3 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = RewardDistributor{
            id                       : 0x2::object::new(arg0),
            period_rewards           : 0x2::table::new<u32, 0x2::table::Table<address, u64>>(arg0),
            period_vaults            : 0x2::table::new<u32, vector<0x1::string::String>>(arg0),
            supported_coin_types     : 0x1::vector::empty<0x1::string::String>(),
            claimed_rewards          : 0x2::table::new<u32, 0x2::table::Table<address, vector<0x1::string::String>>>(arg0),
            period_keys              : 0x1::vector::empty<u32>(),
            period_total_percentages : 0x2::table::new<u32, u64>(arg0),
        };
        0x2::transfer::share_object<RewardDistributor>(v1);
    }

    public entry fun set_operator_cap_to_address(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OperatorCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

