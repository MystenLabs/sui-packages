module 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_flowx {
    struct RewardPoolInfo has store {
        token_type: 0x1::type_name::TypeName,
        global_index: u256,
        pool_id: 0x2::object::ID,
        decimals: u256,
    }

    struct Farm has store, key {
        id: 0x2::object::UID,
        version: u64,
        total_staked: u256,
        allowed_pool_ids: vector<0x2::object::ID>,
        reward_pools: vector<RewardPoolInfo>,
    }

    struct UserRewardInfo has drop, store {
        user_index: u256,
    }

    struct HolderPositionCap has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        balance: u256,
        reward_info: 0x2::table::Table<0x1::type_name::TypeName, UserRewardInfo>,
        position: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position,
    }

    public entry fun claim_rewards<T0>(arg0: &mut HolderPositionCap, arg1: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<T0>, arg2: &mut Farm, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::constants::VERSION(), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EPackageVersionError());
        let v0 = 0x2::object::id<Farm>(arg2);
        assert!(arg0.farm_id == v0, 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EInvalidHolderPositionCap());
        assert!(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::get_farm_id<T0>(arg1) == v0, 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EInvalidRewardPool());
        let v1 = 0;
        while (v1 < 0x1::vector::length<RewardPoolInfo>(&arg2.reward_pools)) {
            let v2 = 0x1::vector::borrow_mut<RewardPoolInfo>(&mut arg2.reward_pools, v1);
            if (v2.token_type == 0x1::type_name::get<T0>()) {
                let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, UserRewardInfo>(&mut arg0.reward_info, 0x1::type_name::get<T0>());
                let v4 = 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::to_native_token(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::mul(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::sub(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_scaled_val(v2.global_index), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_scaled_val(v3.user_index)), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_scaled_val(arg0.balance)), v2.decimals);
                assert!(v4 > 0, 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::ENoRewardsToClaim());
                let v5 = 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::intern_withdraw_balance<T0>(v4, arg1);
                0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::events_v2::emit_claim_reward_event(0x2::object::id<HolderPositionCap>(arg0), v0, 0x2::balance::value<T0>(&v5), 0x1::type_name::into_string(0x1::type_name::get<T0>()));
                v3.user_index = v2.global_index;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg3), 0x2::tx_context::sender(arg3));
                break
            };
            v1 = v1 + 1;
        };
    }

    public entry fun create_reward_pool<T0>(arg0: &0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_admin::AdminCap, arg1: &mut Farm, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::constants::VERSION(), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EPackageVersionError());
        assert!(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_admin::get_farm_id(arg0) == 0x2::object::id<Farm>(arg1), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EUnauthorized());
        let v0 = 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::intern_create_reward_pool<T0>(0x2::object::id<Farm>(arg1), arg3);
        let v1 = 0x1::type_name::get<T0>();
        assert!(!vec_contains(&arg1.reward_pools, v1), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::ERewardPoolAlreadyExist());
        let v2 = RewardPoolInfo{
            token_type   : v1,
            global_index : 0,
            pool_id      : 0x2::object::id<0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<T0>>(&v0),
            decimals     : arg2,
        };
        0x1::vector::push_back<RewardPoolInfo>(&mut arg1.reward_pools, v2);
        0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::events_v2::emit_new_reward_pool_created_event(0x2::object::id<Farm>(arg1), 0x2::object::id<0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<T0>>(&v0), 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::transfer::public_share_object<0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<T0>>(v0);
    }

    public entry fun distribute_rewards<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<T0>, arg2: &mut Farm) {
        assert!(arg2.version == 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::constants::VERSION(), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EPackageVersionError());
        assert!(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::get_farm_id<T0>(arg1) == 0x2::object::id<Farm>(arg2), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EInvalidRewardPool());
        let v0 = 0;
        while (v0 < 0x1::vector::length<RewardPoolInfo>(&arg2.reward_pools)) {
            let v1 = 0x1::vector::borrow_mut<RewardPoolInfo>(&mut arg2.reward_pools, v0);
            if (v1.token_type == 0x1::type_name::get<T0>()) {
                assert!(v1.pool_id == 0x2::object::id<0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::RewardPool<T0>>(arg1), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EInvalidRewardPool());
                if (arg2.total_staked == 0) {
                    0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::intern_add_yield_gain_pending<T0>(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::to_scaled_val(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_native_token(0x2::coin::value<T0>(&arg0), v1.decimals)), arg1);
                    break
                } else {
                    0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::intern_reset_yield_gain_pending<T0>(arg1);
                    v1.global_index = 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::to_scaled_val(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::add(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_scaled_val(v1.global_index), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::div(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::add(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_native_token(0x2::coin::value<T0>(&arg0), v1.decimals), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_scaled_val(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::get_yield_gain_pending<T0>(arg1))), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_scaled_val(arg2.total_staked))));
                    break
                };
            };
            v0 = v0 + 1;
        };
        0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::events_v2::emit_distribute_reward_event(0x2::object::id<Farm>(arg2), 0x2::coin::value<T0>(&arg0), 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::reward_pool::intern_add_balance<T0>(arg0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Farm{
            id               : 0x2::object::new(arg0),
            version          : 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::constants::VERSION(),
            total_staked     : 0,
            allowed_pool_ids : 0x1::vector::empty<0x2::object::ID>(),
            reward_pools     : 0x1::vector::empty<RewardPoolInfo>(),
        };
        0x2::transfer::public_share_object<Farm>(v0);
        0x2::transfer::public_transfer<0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_admin::AdminCap>(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_admin::intern_new_farm_admin(0x2::object::id<Farm>(&v0), arg0), 0x2::tx_context::sender(arg0));
    }

    public entry fun init_holder_position_cap_display(arg0: &0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_admin::AdminCap, arg1: &Farm, arg2: 0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_admin::get_farm_id(arg0) == 0x2::object::id<Farm>(arg1), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EUnauthorized());
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"WeissFi Farming Liquidity Position"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://weiss.finance/flp/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://weissfi.s3.eu-west-3.amazonaws.com/farming-512x512.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://weissfi.s3.eu-west-3.amazonaws.com/farming-256x256.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This NFT represents your staked FlowX liquidity position in WeissFi farming protocol. Use this to claim accumulated rewards, unstake your position, or transfer your farming rights to another address."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://weiss.finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Weiss Finance"));
        let v4 = 0x2::display::new_with_fields<HolderPositionCap>(&arg2, v0, v2, arg3);
        0x2::display::update_version<HolderPositionCap>(&mut v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(arg2, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::display::Display<HolderPositionCap>>(v4, 0x2::tx_context::sender(arg3));
    }

    public entry fun initialize_allowed_pool(arg0: &0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_admin::AdminCap, arg1: &mut Farm, arg2: 0x2::object::ID) {
        assert!(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_admin::get_farm_id(arg0) == 0x2::object::id<Farm>(arg1), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EUnauthorized());
        assert!(arg1.version == 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::constants::VERSION(), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EPackageVersionError());
        if (!0x1::vector::contains<0x2::object::ID>(&arg1.allowed_pool_ids, &arg2)) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg1.allowed_pool_ids, arg2);
        };
    }

    entry fun migrate(arg0: &0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_admin::AdminCap, arg1: &mut Farm) {
        assert!(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::farm_admin::get_farm_id(arg0) == 0x2::object::id<Farm>(arg1), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EUnauthorized());
        assert!(arg1.version < 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::constants::VERSION(), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::ENotUpgrade());
        arg1.version = 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::constants::VERSION();
    }

    public entry fun stake_position(arg0: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg1: &mut Farm, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::constants::VERSION(), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EPackageVersionError());
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::pool_id(&arg0);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg1.allowed_pool_ids, &v0), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::ENotAllowedPool());
        let v1 = 0x2::table::new<0x1::type_name::TypeName, UserRewardInfo>(arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<RewardPoolInfo>(&arg1.reward_pools)) {
            let v3 = 0x1::vector::borrow<RewardPoolInfo>(&arg1.reward_pools, v2);
            let v4 = UserRewardInfo{user_index: v3.global_index};
            0x2::table::add<0x1::type_name::TypeName, UserRewardInfo>(&mut v1, v3.token_type, v4);
            v2 = v2 + 1;
        };
        arg1.total_staked = 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::to_scaled_val(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::add(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_scaled_val(arg1.total_staked), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_q64(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(&arg0))));
        let v5 = HolderPositionCap{
            id          : 0x2::object::new(arg2),
            farm_id     : 0x2::object::id<Farm>(arg1),
            balance     : 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::to_scaled_val(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_q64(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(&arg0))),
            reward_info : v1,
            position    : arg0,
        };
        0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::events_v2::emit_new_stake_position_event(0x2::object::id<HolderPositionCap>(&v5), 0x2::object::id<Farm>(arg1), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::to_scaled_val(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_q64(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(&arg0))), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(&arg0), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::tick_lower_index(&arg0), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::tick_upper_index(&arg0));
        0x2::transfer::public_transfer<HolderPositionCap>(v5, 0x2::tx_context::sender(arg2));
    }

    public entry fun unstake_position(arg0: HolderPositionCap, arg1: &mut Farm, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::constants::VERSION(), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EPackageVersionError());
        assert!(arg0.farm_id == 0x2::object::id<Farm>(arg1), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EInvalidHolderPositionCap());
        let HolderPositionCap {
            id          : v0,
            farm_id     : _,
            balance     : v2,
            reward_info : v3,
            position    : v4,
        } = arg0;
        let v5 = v4;
        let v6 = v3;
        let v7 = 0;
        while (v7 < 0x1::vector::length<RewardPoolInfo>(&arg1.reward_pools)) {
            let v8 = 0x1::vector::borrow<RewardPoolInfo>(&arg1.reward_pools, v7);
            if (0x2::table::borrow<0x1::type_name::TypeName, UserRewardInfo>(&v6, v8.token_type).user_index != v8.global_index) {
                abort 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::errors::EUnclaimedRewards()
            };
            v7 = v7 + 1;
        };
        0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::events_v2::emit_unstake_position_event(0x2::object::id<HolderPositionCap>(&arg0), 0x2::object::id<Farm>(arg1), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::to_scaled_val(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_q64(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(&v5))), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(&v5), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::tick_lower_index(&v5), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::tick_upper_index(&v5));
        arg1.total_staked = 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::to_scaled_val(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::sub(0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_scaled_val(arg1.total_staked), 0x9ec78ad67035029b202a08d25f72ade9c6ed6ca3abb0939fade3e895117d69a0::wf_decimal::from_scaled_val(v2)));
        0x2::table::drop<0x1::type_name::TypeName, UserRewardInfo>(v6);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(v5, 0x2::tx_context::sender(arg2));
    }

    fun vec_contains(arg0: &vector<RewardPoolInfo>, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RewardPoolInfo>(arg0)) {
            if (0x1::vector::borrow<RewardPoolInfo>(arg0, v0).token_type == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

