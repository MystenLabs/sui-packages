module 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::farm_flowx {
    struct RewardPoolInfo has store {
        token_type: 0x1::type_name::TypeName,
        global_index: u256,
        pool_id: 0x2::object::ID,
        decimals: u8,
    }

    struct Farm has store, key {
        id: 0x2::object::UID,
        version: u64,
        total_staked: u256,
        allowed_position_token_list: vector<0x1::type_name::TypeName>,
        reward_pools: vector<RewardPoolInfo>,
        flowx_v3_address: address,
    }

    struct UserRewardInfo has drop, store {
        user_index: u256,
    }

    struct HolderPositionCap has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        balance: u256,
        reward_info: 0x2::table::Table<0x1::type_name::TypeName, UserRewardInfo>,
        position: Position,
    }

    struct I32 has copy, drop, store {
        bits: u32,
    }

    struct PositionRewardInfo has copy, drop, store {
        reward_growth_inside_last: u128,
        coins_owed_reward: u64,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        fee_rate: u64,
        coin_type_x: 0x1::type_name::TypeName,
        coin_type_y: 0x1::type_name::TypeName,
        tick_lower_index: I32,
        tick_upper_index: I32,
        liquidity: u128,
        fee_growth_inside_x_last: u128,
        fee_growth_inside_y_last: u128,
        coins_owed_x: u64,
        coins_owed_y: u64,
        reward_infos: vector<PositionRewardInfo>,
    }

    public entry fun claim_rewards<T0>(arg0: &mut HolderPositionCap, arg1: &mut 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::RewardPool<T0>, arg2: &mut Farm, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::constants::VERSION(), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EPackageVersionError());
        let v0 = 0x2::object::id<Farm>(arg2);
        assert!(arg0.farm_id == v0, 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EInvalidHolderPositionCap());
        assert!(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::get_farm_id<T0>(arg1) == v0, 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EInvalidRewardPool());
        let v1 = 0;
        while (v1 < 0x1::vector::length<RewardPoolInfo>(&arg2.reward_pools)) {
            let v2 = 0x1::vector::borrow_mut<RewardPoolInfo>(&mut arg2.reward_pools, v1);
            if (v2.token_type == 0x1::type_name::get<T0>()) {
                let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, UserRewardInfo>(&mut arg0.reward_info, 0x1::type_name::get<T0>());
                let v4 = 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::intern_withdraw_balance<T0>(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::to_native_token(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::mul(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::sub(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_scaled_val(v2.global_index), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_scaled_val(v3.user_index)), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_scaled_val(arg0.balance)), v2.decimals), arg1);
                0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::events_v1::emit_claim_reward_event(v0, 0x2::balance::value<T0>(&v4), 0x1::type_name::into_string(0x1::type_name::get<T0>()));
                v3.user_index = v2.global_index;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg3), 0x2::tx_context::sender(arg3));
                break
            };
            v1 = v1 + 1;
        };
    }

    public entry fun create_reward_pool<T0>(arg0: &0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::farm_admin::AdminCap, arg1: &mut Farm, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::constants::VERSION(), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EPackageVersionError());
        assert!(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::farm_admin::get_farm_id(arg0) == 0x2::object::id<Farm>(arg1), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EUnauthorized());
        let v0 = 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::intern_create_reward_pool<T0>(0x2::object::id<Farm>(arg1), arg3);
        let v1 = 0x1::type_name::get<T0>();
        assert!(!vec_contains(&arg1.reward_pools, v1), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::ERewardPoolAlreadyExist());
        let v2 = RewardPoolInfo{
            token_type   : v1,
            global_index : 0,
            pool_id      : 0x2::object::id<0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::RewardPool<T0>>(&v0),
            decimals     : arg2,
        };
        0x1::vector::push_back<RewardPoolInfo>(&mut arg1.reward_pools, v2);
        0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::events_v1::emit_new_reward_pool_created_event(0x2::object::id<Farm>(arg1), 0x2::object::id<0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::RewardPool<T0>>(&v0), 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::transfer::public_share_object<0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::RewardPool<T0>>(v0);
    }

    public entry fun distribute_rewards<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::RewardPool<T0>, arg2: &mut Farm) {
        assert!(arg2.version == 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::constants::VERSION(), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EPackageVersionError());
        assert!(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::get_farm_id<T0>(arg1) == 0x2::object::id<Farm>(arg2), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EInvalidRewardPool());
        let v0 = 0;
        while (v0 < 0x1::vector::length<RewardPoolInfo>(&arg2.reward_pools)) {
            let v1 = 0x1::vector::borrow_mut<RewardPoolInfo>(&mut arg2.reward_pools, v0);
            if (v1.token_type == 0x1::type_name::get<T0>()) {
                assert!(v1.pool_id == 0x2::object::id<0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::RewardPool<T0>>(arg1), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EInvalidRewardPool());
                if (arg2.total_staked == 0) {
                    0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::intern_add_yield_gain_pending<T0>(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::to_scaled_val(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_native_token(0x2::coin::value<T0>(&arg0), v1.decimals)), arg1);
                    break
                } else {
                    0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::intern_reset_yield_gain_pending<T0>(arg1);
                    v1.global_index = 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::to_scaled_val(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::add(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_scaled_val(v1.global_index), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::div(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::add(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_native_token(0x2::coin::value<T0>(&arg0), v1.decimals), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_scaled_val(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::get_yield_gain_pending<T0>(arg1))), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_scaled_val(arg2.total_staked))));
                    break
                };
            };
            v0 = v0 + 1;
        };
        0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::events_v1::emit_distribute_reward_event(0x2::object::id<Farm>(arg2), 0x2::coin::value<T0>(&arg0), 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::reward_pool::intern_add_balance<T0>(arg0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Farm{
            id                          : 0x2::object::new(arg0),
            version                     : 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::constants::VERSION(),
            total_staked                : 0,
            allowed_position_token_list : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reward_pools                : 0x1::vector::empty<RewardPoolInfo>(),
            flowx_v3_address            : 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::constants::FLOWX_V3_ADDRESS(),
        };
        0x2::transfer::public_share_object<Farm>(v0);
        0x2::transfer::public_transfer<0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::farm_admin::AdminCap>(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::farm_admin::intern_new_farm_admin(0x2::object::id<Farm>(&v0), arg0), 0x2::tx_context::sender(arg0));
    }

    public entry fun init_holder_position_cap_display(arg0: &0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::farm_admin::AdminCap, arg1: &Farm, arg2: 0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::farm_admin::get_farm_id(arg0) == 0x2::object::id<Farm>(arg1), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EUnauthorized());
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

    public entry fun initialize_allowed_tokens<T0>(arg0: &0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::farm_admin::AdminCap, arg1: &mut Farm) {
        assert!(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::farm_admin::get_farm_id(arg0) == 0x2::object::id<Farm>(arg1), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EUnauthorized());
        assert!(arg1.version == 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::constants::VERSION(), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EPackageVersionError());
        let v0 = 0x1::type_name::get<T0>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.allowed_position_token_list, &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.allowed_position_token_list, v0);
        };
    }

    entry fun migrate(arg0: &0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::farm_admin::AdminCap, arg1: &mut Farm) {
        assert!(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::farm_admin::get_farm_id(arg0) == 0x2::object::id<Farm>(arg1), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EUnauthorized());
        assert!(arg1.version < 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::constants::VERSION(), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::ENotUpgrade());
        arg1.version = 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::constants::VERSION();
    }

    public entry fun stake_position(arg0: Position, arg1: &mut Farm, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::constants::VERSION(), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EPackageVersionError());
        let v0 = 0x1::type_name::get<Position>();
        let v1 = 0x1::type_name::get_address(&v0);
        assert!(0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1)) == arg1.flowx_v3_address, 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EInvalidPositionSource());
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.allowed_position_token_list, &arg0.coin_type_x), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::ENotAllowedTypeName());
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.allowed_position_token_list, &arg0.coin_type_y), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::ENotAllowedTypeName());
        let v2 = 0x2::table::new<0x1::type_name::TypeName, UserRewardInfo>(arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<RewardPoolInfo>(&arg1.reward_pools)) {
            let v4 = 0x1::vector::borrow<RewardPoolInfo>(&arg1.reward_pools, v3);
            let v5 = UserRewardInfo{user_index: v4.global_index};
            0x2::table::add<0x1::type_name::TypeName, UserRewardInfo>(&mut v2, v4.token_type, v5);
            v3 = v3 + 1;
        };
        0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::events_v1::emit_new_stake_position_event(0x2::object::id<Farm>(arg1), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::to_scaled_val(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_q64(arg0.liquidity)));
        arg1.total_staked = 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::to_scaled_val(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::add(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_scaled_val(arg1.total_staked), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_q64(arg0.liquidity)));
        let v6 = HolderPositionCap{
            id          : 0x2::object::new(arg2),
            farm_id     : 0x2::object::id<Farm>(arg1),
            balance     : 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::to_scaled_val(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_q64(arg0.liquidity)),
            reward_info : v2,
            position    : arg0,
        };
        0x2::transfer::public_transfer<HolderPositionCap>(v6, 0x2::tx_context::sender(arg2));
    }

    public entry fun unstake_position(arg0: HolderPositionCap, arg1: &mut Farm, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::constants::VERSION(), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EPackageVersionError());
        assert!(arg0.farm_id == 0x2::object::id<Farm>(arg1), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EInvalidHolderPositionCap());
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
                abort 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::errors::EUnclaimedRewards()
            };
            v7 = v7 + 1;
        };
        0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::events_v1::emit_unstake_position_event(0x2::object::id<Farm>(arg1), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::to_scaled_val(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_q64(v5.liquidity)));
        arg1.total_staked = 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::to_scaled_val(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::sub(0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_scaled_val(arg1.total_staked), 0x6f1d8f889b1de7cd763abdcdc449846cec78114fe59dc5d2b2f7bc0cfbf5997::wf_decimal::from_scaled_val(v2)));
        0x2::table::drop<0x1::type_name::TypeName, UserRewardInfo>(v6);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<Position>(v5, 0x2::tx_context::sender(arg2));
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

