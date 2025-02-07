module 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::pool {
    struct PoolRegisterEvent has copy, drop {
        pool_id: 0x2::object::ID,
        expiry: u64,
    }

    struct PoolRewarderAddEvent has copy, drop {
        pool_reward_id: 0x2::object::ID,
        reward_token: 0x1::type_name::TypeName,
        emission_per_second: u64,
        amount: u64,
        end_time: u64,
    }

    struct PoolRewarderRemoveEvent has copy, drop {
        pool_reward_id: 0x2::object::ID,
    }

    struct PoolRewarderStopEvent has copy, drop {
        pool_reward_id: 0x2::object::ID,
    }

    struct PoolRewarderWithdrawEvent has copy, drop {
        pool_reward_id: 0x2::object::ID,
        amount: u64,
    }

    struct PoolRewarderUpdateEvent has copy, drop {
        pool_reward_id: 0x2::object::ID,
        emission_per_second: u64,
        amount: u64,
        end_time: u64,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        expiry: u64,
        vault: 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::balance_bag::BalanceBag,
        total_stake_shares: u64,
        rewarders: 0x2::vec_map::VecMap<0x2::object::ID, PoolRewarderInfo>,
    }

    struct PoolRewarderInfo has store, key {
        id: 0x2::object::UID,
        owner: address,
        reward_token: 0x1::type_name::TypeName,
        emission_per_second: u64,
        total_reward: u64,
        last_reward_time: u64,
        reward_harvested: u64,
        acc_per_share: u128,
        end_time: u64,
        active: bool,
    }

    struct WrappedPositionNFT has store, key {
        id: 0x2::object::UID,
        market_position: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_position::MarketPosition,
        share: u64,
        rewards_debt: 0x2::vec_map::VecMap<0x2::object::ID, u256>,
        rewards_harvested: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
    }

    public fun add_reward_pool<T0: drop>(arg0: &mut Pool, arg1: &mut 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::checked_package_version(arg1);
        assert!(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::has_role(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::get_acl(arg1), 0x2::tx_context::sender(arg6), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::whitelist_role()), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        assert!(arg0.expiry > 0x2::clock::timestamp_ms(arg5), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::market_expired());
        assert!(0x2::coin::value<T0>(&arg3) > 0, 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::invalid_reward_amount());
        assert!(arg4 > 0x2::clock::timestamp_ms(arg5) && arg4 <= arg0.expiry, 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::invalid_end_time());
        assert!((arg4 - 0x2::clock::timestamp_ms(arg5)) / 1000 * arg2 <= 0x2::coin::value<T0>(&arg3), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::emission_exceeds_total_reward());
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = PoolRewarderInfo{
            id                  : 0x2::object::new(arg6),
            owner               : 0x2::tx_context::sender(arg6),
            reward_token        : 0x1::type_name::get<T0>(),
            emission_per_second : arg2,
            total_reward        : v0,
            last_reward_time    : 0x2::clock::timestamp_ms(arg5),
            reward_harvested    : 0,
            acc_per_share       : 0,
            end_time            : arg4,
            active              : true,
        };
        if (!0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::balance_bag::contains<T0>(&arg0.vault)) {
            0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::balance_bag::init_balance<T0>(&mut arg0.vault);
        };
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::balance_bag::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg3));
        let v2 = 0x2::object::id<PoolRewarderInfo>(&v1);
        0x2::vec_map::insert<0x2::object::ID, PoolRewarderInfo>(&mut arg0.rewarders, v2, v1);
        let v3 = PoolRewarderAddEvent{
            pool_reward_id      : v2,
            reward_token        : 0x1::type_name::get<T0>(),
            emission_per_second : arg2,
            amount              : v0,
            end_time            : arg4,
        };
        0x2::event::emit<PoolRewarderAddEvent>(v3);
        v2
    }

    public fun add_reward_pool_total_reward<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<T0>, arg2: &mut Pool, arg3: &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::checked_package_version(arg3);
        assert!(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::has_role(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::get_acl(arg3), 0x2::tx_context::sender(arg4), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::whitelist_role()), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(&mut arg2.rewarders, &arg0);
        assert!(0x1::type_name::get<T0>() == v0.reward_token, 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::reward_token_type_mismatch());
        assert!(v0.owner == 0x2::tx_context::sender(arg4), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::balance_bag::join<T0>(&mut arg2.vault, 0x2::coin::into_balance<T0>(arg1));
        v0.total_reward = v0.total_reward + 0x2::coin::value<T0>(&arg1);
    }

    public fun borrow_pool_rewarders(arg0: &Pool) : &0x2::vec_map::VecMap<0x2::object::ID, PoolRewarderInfo> {
        &arg0.rewarders
    }

    public fun borrow_pool_vault(arg0: &Pool) : &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::balance_bag::BalanceBag {
        &arg0.vault
    }

    public fun claim<T0: drop>(arg0: &mut Pool, arg1: &mut WrappedPositionNFT, arg2: &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::checked_package_version(arg2);
        assert!(arg0.market_id == 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_position::market_state_id(&arg1.market_position), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::mismatched_market_position());
        let v0 = &mut arg0.rewarders;
        let v1 = 0x2::vec_map::keys<0x2::object::ID, PoolRewarderInfo>(v0);
        let v2 = 0x2::coin::zero<T0>(arg4);
        while (!0x1::vector::is_empty<0x2::object::ID>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x2::object::ID>(&mut v1);
            let v4 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(v0, &v3);
            if (v4.reward_token != 0x1::type_name::get<T0>()) {
                continue
            };
            if (!v4.active) {
                continue
            };
            update_acc_per_share(v4, arg2, arg0.total_stake_shares, arg3);
            let v5 = 0x2::object::id<PoolRewarderInfo>(v4);
            let v6 = 0x2::vec_map::try_get<0x2::object::ID, u256>(&arg1.rewards_debt, &v5);
            let v7 = 0x2::vec_map::try_get<0x2::object::ID, u64>(&arg1.rewards_harvested, &v5);
            let v8 = (((arg1.share as u256) * (v4.acc_per_share as u256) - 0x1::option::get_with_default<u256>(&v6, 0) - (0x1::option::get_with_default<u64>(&v7, 0) as u256)) as u64);
            if (0x2::vec_map::contains<0x2::object::ID, u64>(&arg1.rewards_harvested, &v5)) {
                let (_, v10) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg1.rewards_harvested, &v5);
                0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg1.rewards_harvested, v5, v10 + v8);
            } else {
                0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg1.rewards_harvested, v5, v8);
            };
            0x2::coin::join<T0>(&mut v2, 0x2::coin::from_balance<T0>(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::balance_bag::split<T0>(&mut arg0.vault, v8), arg4));
            v4.reward_harvested = v4.reward_harvested + v8;
        };
        v2
    }

    public fun emergent_stop_pool_rewarder(arg0: 0x2::object::ID, arg1: &mut Pool, arg2: &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::checked_package_version(arg2);
        assert!(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::has_role(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::get_acl(arg2), 0x2::tx_context::sender(arg3), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::whitelist_role()), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(&mut arg1.rewarders, &arg0);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        assert!(v0.active == true, 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::pool_rewarder_not_active());
        v0.active = false;
        let v1 = PoolRewarderStopEvent{pool_reward_id: arg0};
        0x2::event::emit<PoolRewarderStopEvent>(v1);
    }

    public fun emergent_withdraw_pool_rewarder<T0: drop>(arg0: 0x2::object::ID, arg1: &mut Pool, arg2: &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::checked_package_version(arg2);
        assert!(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::has_role(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::get_acl(arg2), 0x2::tx_context::sender(arg4), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::admin_role()), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(&mut arg1.rewarders, &arg0);
        let v1 = v0.total_reward - v0.reward_harvested;
        v0.reward_harvested = v0.total_reward;
        v0.last_reward_time = 0x2::clock::timestamp_ms(arg3);
        v0.end_time = 0x2::clock::timestamp_ms(arg3);
        v0.active = false;
        let v2 = PoolRewarderWithdrawEvent{
            pool_reward_id : arg0,
            amount         : v1,
        };
        0x2::event::emit<PoolRewarderWithdrawEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::balance_bag::split<T0>(&mut arg1.vault, v1), arg4), v0.owner);
    }

    public fun enable_pool_rewarder(arg0: 0x2::object::ID, arg1: &mut Pool, arg2: &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::checked_package_version(arg2);
        assert!(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::has_role(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::get_acl(arg2), 0x2::tx_context::sender(arg3), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::whitelist_role()), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(&mut arg1.rewarders, &arg0);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        assert!(v0.active == false, 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::pool_rewarder_already_active());
        v0.active = true;
    }

    public fun get_pool_expiry(arg0: &Pool) : u64 {
        arg0.expiry
    }

    public fun get_pool_market_id(arg0: &Pool) : 0x2::object::ID {
        arg0.market_id
    }

    public fun get_pool_rewarder_info(arg0: &PoolRewarderInfo) : (0x1::type_name::TypeName, u64, u64, u128, u64, u64, u64, bool) {
        (arg0.reward_token, arg0.emission_per_second, arg0.total_reward, arg0.acc_per_share, arg0.last_reward_time, arg0.reward_harvested, arg0.end_time, arg0.active)
    }

    public fun get_total_stake_shares(arg0: &Pool) : u64 {
        arg0.total_stake_shares
    }

    public fun is_pool_rewarder_valid(arg0: &PoolRewarderInfo) : bool {
        arg0.active
    }

    public fun register_pool<T0: drop>(arg0: &mut 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg1: &0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::checked_package_version(arg0);
        assert!(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::has_role(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::get_acl(arg0), 0x2::tx_context::sender(arg3), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::admin_role()), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        let v0 = 0x2::object::id<0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::MarketState<T0>>(arg1);
        let v1 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market::get_market_expiry<T0>(arg1);
        assert!(v1 > 0x2::clock::timestamp_ms(arg2), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::market_expired());
        let v2 = Pool{
            id                 : 0x2::object::new(arg3),
            market_id          : v0,
            expiry             : v1,
            vault              : 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::balance_bag::new(arg3),
            total_stake_shares : 0,
            rewarders          : 0x2::vec_map::empty<0x2::object::ID, PoolRewarderInfo>(),
        };
        assert!(!0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::has_pool(arg0, v0), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::pool_already_exists());
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::add_pool(arg0, v0);
        let v3 = PoolRegisterEvent{
            pool_id : 0x2::object::id<Pool>(&v2),
            expiry  : v1,
        };
        0x2::event::emit<PoolRegisterEvent>(v3);
        0x2::transfer::share_object<Pool>(v2);
    }

    public fun remove_reward_pool(arg0: 0x2::object::ID, arg1: &mut Pool, arg2: &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::checked_package_version(arg2);
        assert!(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::has_role(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::get_acl(arg2), 0x2::tx_context::sender(arg3), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::admin_role()), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, PoolRewarderInfo>(&mut arg1.rewarders, &arg0);
        let PoolRewarderInfo {
            id                  : v2,
            owner               : _,
            reward_token        : _,
            emission_per_second : _,
            total_reward        : _,
            last_reward_time    : _,
            reward_harvested    : _,
            acc_per_share       : _,
            end_time            : _,
            active              : _,
        } = v1;
        0x2::object::delete(v2);
        let v12 = PoolRewarderRemoveEvent{pool_reward_id: arg0};
        0x2::event::emit<PoolRewarderRemoveEvent>(v12);
    }

    public fun stake(arg0: &mut Pool, arg1: &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg2: 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_position::MarketPosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : WrappedPositionNFT {
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::checked_package_version(arg1);
        assert!(arg0.expiry > 0x2::clock::timestamp_ms(arg3), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::market_expired());
        assert!(0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_position::market_state_id(&arg2) == arg0.market_id, 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::mismatched_market_position());
        let v0 = 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_position::lp_amount(&arg2);
        let v1 = WrappedPositionNFT{
            id                : 0x2::object::new(arg4),
            market_position   : arg2,
            share             : v0,
            rewards_debt      : 0x2::vec_map::empty<0x2::object::ID, u256>(),
            rewards_harvested : 0x2::vec_map::empty<0x2::object::ID, u64>(),
        };
        let v2 = &mut arg0.rewarders;
        let v3 = 0x2::vec_map::keys<0x2::object::ID, PoolRewarderInfo>(v2);
        while (!0x1::vector::is_empty<0x2::object::ID>(&v3)) {
            let v4 = 0x1::vector::pop_back<0x2::object::ID>(&mut v3);
            let v5 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(v2, &v4);
            if (!is_pool_rewarder_valid(v5)) {
                continue
            };
            update_acc_per_share(v5, arg1, arg0.total_stake_shares, arg3);
            0x2::vec_map::insert<0x2::object::ID, u256>(&mut v1.rewards_debt, 0x2::object::id<PoolRewarderInfo>(v5), (v0 as u256) * (v5.acc_per_share as u256));
        };
        arg0.total_stake_shares = arg0.total_stake_shares + v0;
        v1
    }

    public fun unstake(arg0: &mut Pool, arg1: WrappedPositionNFT, arg2: &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_position::MarketPosition {
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::checked_package_version(arg2);
        assert!(arg0.market_id == 0xbb3d96702663ff0640a02c8d9a27fb8a1e81196274cdeb0ee823e993125914b5::market_position::market_state_id(&arg1.market_position), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::mismatched_market_position());
        let v0 = &mut arg0.rewarders;
        let v1 = 0x2::vec_map::keys<0x2::object::ID, PoolRewarderInfo>(v0);
        while (!0x1::vector::is_empty<0x2::object::ID>(&v1)) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut v1);
            let v3 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(v0, &v2);
            if (!is_pool_rewarder_valid(v3)) {
                continue
            };
            update_acc_per_share(v3, arg2, arg0.total_stake_shares, arg3);
            let v4 = 0x2::object::id<PoolRewarderInfo>(v3);
            let v5 = 0x2::vec_map::try_get<0x2::object::ID, u64>(&arg1.rewards_harvested, &v4);
            let v6 = 0x2::vec_map::try_get<0x2::object::ID, u256>(&arg1.rewards_debt, &v4);
            assert!((((arg1.share as u256) * (v3.acc_per_share as u256) - 0x1::option::get_with_default<u256>(&v6, 0) - (0x1::option::get_with_default<u64>(&v5, 0) as u256)) as u64) == 0, 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::reward_not_harvested());
        };
        let WrappedPositionNFT {
            id                : v7,
            market_position   : v8,
            share             : v9,
            rewards_debt      : _,
            rewards_harvested : _,
        } = arg1;
        arg0.total_stake_shares = arg0.total_stake_shares - v9;
        0x2::object::delete(v7);
        v8
    }

    public(friend) fun update_acc_per_share(arg0: &mut PoolRewarderInfo, arg1: &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = v0;
        if (arg0.end_time < v0) {
            v1 = arg0.end_time;
        };
        if (arg2 != 0) {
            arg0.acc_per_share = arg0.acc_per_share + (0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::get_acceleration_factor(arg1, 0x2::object::id<PoolRewarderInfo>(arg0)) as u128) * ((((v1 - arg0.last_reward_time) as u64) / 1000) as u128) * (arg0.emission_per_second as u128) / (arg2 as u128);
        };
        arg0.last_reward_time = v1;
    }

    public fun update_pool_rewarder_acc_per_share(arg0: &mut PoolRewarderInfo, arg1: &mut Pool, arg2: &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg3: &0x2::clock::Clock) {
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::checked_package_version(arg2);
        update_acc_per_share(arg0, arg2, arg1.total_stake_shares, arg3);
    }

    public fun update_reward_pool_emission_rate(arg0: 0x2::object::ID, arg1: &mut Pool, arg2: u64, arg3: &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::checked_package_version(arg3);
        assert!(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::has_role(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::get_acl(arg3), 0x2::tx_context::sender(arg5), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::whitelist_role()), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(&mut arg1.rewarders, &arg0);
        assert!(v0.owner == 0x2::tx_context::sender(arg5), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        update_acc_per_share(v0, arg3, arg1.total_stake_shares, arg4);
        v0.emission_per_second = arg2;
    }

    public fun update_reward_pool_end_time(arg0: 0x2::object::ID, arg1: &mut Pool, arg2: u64, arg3: &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::checked_package_version(arg3);
        assert!(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::has_role(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config::get_acl(arg3), 0x2::tx_context::sender(arg5), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::whitelist_role()), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        0x2::vec_map::get_mut<0x2::object::ID, PoolRewarderInfo>(&mut arg1.rewarders, &arg0).end_time = arg2;
    }

    // decompiled from Move bytecode v6
}

