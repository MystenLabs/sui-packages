module 0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::main {
    struct GlobalState has key {
        id: 0x2::object::UID,
        version: u64,
        is_active: bool,
        platform_fee_percentage: u64,
        epoch_period_ms: u64,
        locking_period_ms: u64,
        tokens: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct UserJwltokenInfo has copy, drop, store {
        jwltoken_staked: u64,
        total_rewards: u64,
        last_staked_at: u64,
        last_epoch_checked: u64,
    }

    struct TokenInfoSca has key {
        id: 0x2::object::UID,
        sca_vault: 0x2::balance::Balance<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>,
        jwlsca_vault: 0x2::balance::Balance<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>,
        min_deposit_amount: u64,
        staking_percentage: u64,
        total_sca_to_stake: u64,
        total_sca_staked: u64,
        total_sca_to_add_liquidity: u64,
        total_jwlsca_staked: u64,
        total_jwlsca_compounded: u64,
        total_stakers: u64,
        total_stakers_checked: u64,
        current_epoch: u64,
        epoch_rewards: u64,
        epoch_start_time: u64,
        last_epoch_got_rewards: u64,
        user_jwltoken_info: 0x2::linked_table::LinkedTable<address, UserJwltokenInfo>,
        ve_sca_unlock_at: u64,
        ve_sca_key: 0x1::option::Option<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>,
    }

    struct TokenInfoCetus has key {
        id: 0x2::object::UID,
        cetus_vault: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>,
        jwlcetus_vault: 0x2::balance::Balance<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>,
        min_deposit_amount: u64,
        staking_percentage: u64,
        total_cetus_to_stake: u64,
        total_cetus_staked: u64,
        total_cetus_to_add_liquidity: u64,
        total_jwlcetus_staked: u64,
        total_jwlcetus_compounded: u64,
        total_stakers: u64,
        total_stakers_checked: u64,
        current_epoch: u64,
        epoch_rewards: u64,
        epoch_start_time: u64,
        last_epoch_got_rewards: u64,
        user_jwltoken_info: 0x2::linked_table::LinkedTable<address, UserJwltokenInfo>,
    }

    struct EpochPeriodUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct LockingPeriodUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct MinDepositAmountUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct StakingPercentageUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct ActiveStatusUpdatedEvent has copy, drop {
        current_status: bool,
    }

    struct VeScaKeyUpdatedEvent has copy, drop {
        ve_sca_key_id: 0x2::object::ID,
    }

    struct VeScaKeyRedeemedEvent has copy, drop {
        ve_sca_key_id: 0x2::object::ID,
    }

    struct MigratedEvent has copy, drop {
        prev_version: u64,
        new_version: u64,
    }

    struct StakeScaEvent has copy, drop {
        user: address,
        amount: u64,
        staked_at: u64,
    }

    struct StakeCetusEvent has copy, drop {
        user: address,
        amount: u64,
        staked_at: u64,
    }

    struct ConvertScaEvent has copy, drop {
        user: address,
        amount: u64,
        converted_at: u64,
    }

    struct ConvertCetusEvent has copy, drop {
        user: address,
        amount: u64,
        converted_at: u64,
    }

    struct StakeJwlscaEvent has copy, drop {
        user: address,
        amount: u64,
        staked_at: u64,
    }

    struct StakeJwlcetusEvent has copy, drop {
        user: address,
        amount: u64,
        staked_at: u64,
    }

    struct UnstakeJwlscaEvent has copy, drop {
        user: address,
        amount: u64,
        unstaked_at: u64,
    }

    struct UnstakeJwlcetusEvent has copy, drop {
        user: address,
        amount: u64,
        unstaked_at: u64,
    }

    struct LiquidityAddedEvent has copy, drop {
        clmm_pool_id: 0x2::object::ID,
        position_nft_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct EpochRewardsAddedEvent has copy, drop {
        reward_token_type_name: 0x1::type_name::TypeName,
        epoch: u64,
        rewards: u64,
    }

    struct RewardsDistributedEvent has copy, drop {
        reward_token_type_name: 0x1::type_name::TypeName,
        epoch: u64,
        total_rewards: u64,
        total_stakers: u64,
    }

    struct TriggeredNextEpochEvent has copy, drop {
        prev_epoch: u64,
        next_epoch: u64,
    }

    struct ClaimedRewardsEvent has copy, drop {
        user: address,
        epoch: u64,
        rewards: u64,
    }

    struct ExtendScaLockPeriodEvent has copy, drop {
        ve_sca_key_id: 0x2::object::ID,
        new_unlock_at: u64,
    }

    public entry fun add_epoch_rewards_cetus(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OperatorCap, arg1: &mut GlobalState, arg2: &mut TokenInfoCetus, arg3: 0x2::coin::Coin<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>, arg4: &0x2::clock::Clock) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg2.current_epoch > arg2.last_epoch_got_rewards, 123);
        assert!(arg2.epoch_start_time + arg1.epoch_period_ms >= 0x2::clock::timestamp_ms(arg4), 113);
        let v0 = 0x2::coin::value<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>(&arg3);
        0x2::coin::put<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>(&mut arg2.jwlcetus_vault, arg3);
        arg2.epoch_rewards = arg2.epoch_rewards + v0;
        arg2.last_epoch_got_rewards = arg2.current_epoch;
        let v1 = EpochRewardsAddedEvent{
            reward_token_type_name : 0x1::type_name::get<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>(),
            epoch                  : arg2.current_epoch,
            rewards                : v0,
        };
        0x2::event::emit<EpochRewardsAddedEvent>(v1);
    }

    public entry fun add_epoch_rewards_sca(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OperatorCap, arg1: &mut GlobalState, arg2: &mut TokenInfoSca, arg3: 0x2::coin::Coin<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>, arg4: &0x2::clock::Clock) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg2.current_epoch > arg2.last_epoch_got_rewards, 123);
        assert!(arg2.epoch_start_time + arg1.epoch_period_ms >= 0x2::clock::timestamp_ms(arg4), 113);
        let v0 = 0x2::coin::value<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>(&arg3);
        0x2::coin::put<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>(&mut arg2.jwlsca_vault, arg3);
        arg2.epoch_rewards = arg2.epoch_rewards + v0;
        arg2.last_epoch_got_rewards = arg2.current_epoch;
        let v1 = EpochRewardsAddedEvent{
            reward_token_type_name : 0x1::type_name::get<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>(),
            epoch                  : arg2.current_epoch,
            rewards                : v0,
        };
        0x2::event::emit<EpochRewardsAddedEvent>(v1);
    }

    public entry fun add_liquidity_cetus(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OperatorCap, arg1: &mut GlobalState, arg2: &mut TokenInfoCetus, arg3: &mut 0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JwlCetusMetadata<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg2.cetus_vault) > 0, 110);
        assert!(0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg2.cetus_vault) >= arg8, 111);
        assert!(arg2.total_cetus_to_add_liquidity >= arg8, 117);
        let v0 = if (arg9) {
            arg7
        } else {
            arg8
        };
        0x2::coin::put<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>(&mut arg2.jwlcetus_vault, 0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::mint(arg3, arg7, arg11));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg4, arg5, 0x2::balance::split<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>(&mut arg2.jwlcetus_vault, arg7), 0x2::balance::split<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg2.cetus_vault, arg8), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg4, arg5, arg6, v0, arg9, arg10));
        arg2.total_cetus_to_add_liquidity = arg2.total_cetus_to_add_liquidity - arg8;
        let v1 = LiquidityAddedEvent{
            clmm_pool_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(arg5),
            position_nft_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg6),
            amount_a        : arg7,
            amount_b        : arg8,
        };
        0x2::event::emit<LiquidityAddedEvent>(v1);
    }

    public entry fun add_liquidity_sca(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OperatorCap, arg1: &mut GlobalState, arg2: &mut TokenInfoSca, arg3: &mut 0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JwlScaMetadata<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA, 0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(0x2::balance::value<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&arg2.sca_vault) > 0, 110);
        assert!(0x2::balance::value<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&arg2.sca_vault) >= arg8, 111);
        assert!(arg2.total_sca_to_add_liquidity >= arg8, 117);
        let v0 = if (arg9) {
            arg7
        } else {
            arg8
        };
        0x2::coin::put<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>(&mut arg2.jwlsca_vault, 0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::mint(arg3, arg7, arg11));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA, 0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(arg4, arg5, 0x2::balance::split<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>(&mut arg2.jwlsca_vault, arg7), 0x2::balance::split<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&mut arg2.sca_vault, arg8), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA, 0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(arg4, arg5, arg6, v0, arg9, arg10));
        arg2.total_sca_to_add_liquidity = arg2.total_sca_to_add_liquidity - arg8;
        let v1 = LiquidityAddedEvent{
            clmm_pool_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA, 0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>>(arg5),
            position_nft_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg6),
            amount_a        : arg7,
            amount_b        : arg8,
        };
        0x2::event::emit<LiquidityAddedEvent>(v1);
    }

    fun assert_active(arg0: &GlobalState) {
        assert!(arg0.is_active, 100);
    }

    fun assert_version(arg0: &GlobalState) {
        assert!(arg0.version == 1, 1);
    }

    fun check_user_jwltoken_info(arg0: &mut 0x2::linked_table::LinkedTable<address, UserJwltokenInfo>, arg1: address) {
        if (!0x2::linked_table::contains<address, UserJwltokenInfo>(arg0, arg1)) {
            let v0 = UserJwltokenInfo{
                jwltoken_staked    : 0,
                total_rewards      : 0,
                last_staked_at     : 0,
                last_epoch_checked : 0,
            };
            0x2::linked_table::push_back<address, UserJwltokenInfo>(arg0, arg1, v0);
        };
    }

    public entry fun claim_rewards_cetus(arg0: &mut GlobalState, arg1: &mut TokenInfoCetus, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        assert!(arg1.epoch_start_time + arg0.epoch_period_ms >= 0x2::clock::timestamp_ms(arg2), 113);
        let v0 = 0x2::linked_table::borrow_mut<address, UserJwltokenInfo>(&mut arg1.user_jwltoken_info, 0x2::tx_context::sender(arg4));
        assert!(v0.total_rewards >= arg3, 121);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>>(0x2::coin::take<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>(&mut arg1.jwlcetus_vault, arg3, arg4), 0x2::tx_context::sender(arg4));
        arg1.total_jwlcetus_staked = arg1.total_jwlcetus_staked - arg3;
        v0.jwltoken_staked = v0.jwltoken_staked - arg3;
        v0.total_rewards = v0.total_rewards - arg3;
        let v1 = ClaimedRewardsEvent{
            user    : 0x2::tx_context::sender(arg4),
            epoch   : arg1.current_epoch,
            rewards : arg3,
        };
        0x2::event::emit<ClaimedRewardsEvent>(v1);
    }

    public entry fun claim_rewards_sca(arg0: &mut GlobalState, arg1: &mut TokenInfoSca, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        assert!(arg1.epoch_start_time + arg0.epoch_period_ms >= 0x2::clock::timestamp_ms(arg2), 113);
        let v0 = 0x2::linked_table::borrow_mut<address, UserJwltokenInfo>(&mut arg1.user_jwltoken_info, 0x2::tx_context::sender(arg4));
        assert!(v0.total_rewards >= arg3, 121);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>>(0x2::coin::take<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>(&mut arg1.jwlsca_vault, arg3, arg4), 0x2::tx_context::sender(arg4));
        arg1.total_jwlsca_staked = arg1.total_jwlsca_staked - arg3;
        v0.jwltoken_staked = v0.jwltoken_staked - arg3;
        v0.total_rewards = v0.total_rewards - arg3;
        let v1 = ClaimedRewardsEvent{
            user    : 0x2::tx_context::sender(arg4),
            epoch   : arg1.current_epoch,
            rewards : arg3,
        };
        0x2::event::emit<ClaimedRewardsEvent>(v1);
    }

    public entry fun claim_xcetus_staking_rewards<T0>(arg0: &mut 0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::dividend::DividendManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x785248249ac457dfd378bdc6d2fbbfec9d1daf65e9d728b820eb4888c8da2c10::router::redeem_v2<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun convert_cetus(arg0: &GlobalState, arg1: &mut 0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JwlCetusMetadata<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>, arg2: 0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg3: &mut TokenInfoCetus, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        let v0 = 0x2::coin::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg2);
        let v1 = 0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::math::mul_div(v0, arg3.staking_percentage, 10000);
        arg3.total_cetus_to_stake = arg3.total_cetus_to_stake + v1;
        arg3.total_cetus_to_add_liquidity = arg3.total_cetus_to_add_liquidity + v0 - v1;
        0x2::coin::put<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg3.cetus_vault, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>>(0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::mint(arg1, v0, arg5), 0x2::tx_context::sender(arg5));
        let v2 = ConvertCetusEvent{
            user         : 0x2::tx_context::sender(arg5),
            amount       : v0,
            converted_at : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ConvertCetusEvent>(v2);
    }

    public entry fun convert_sca(arg0: &GlobalState, arg1: &mut 0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JwlScaMetadata<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>, arg2: 0x2::coin::Coin<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>, arg3: &mut TokenInfoSca, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        let v0 = 0x2::coin::value<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&arg2);
        let v1 = 0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::math::mul_div(v0, arg3.staking_percentage, 10000);
        arg3.total_sca_to_stake = arg3.total_sca_to_stake + v1;
        arg3.total_sca_to_add_liquidity = arg3.total_sca_to_add_liquidity + v0 - v1;
        0x2::coin::put<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&mut arg3.sca_vault, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>>(0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::mint(arg1, v0, arg5), 0x2::tx_context::sender(arg5));
        let v2 = ConvertScaEvent{
            user         : 0x2::tx_context::sender(arg5),
            amount       : v0,
            converted_at : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ConvertScaEvent>(v2);
    }

    public entry fun distribute_rewards_cetus(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OperatorCap, arg1: &mut GlobalState, arg2: &mut TokenInfoCetus, arg3: &0x2::clock::Clock) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg2.epoch_start_time + arg1.epoch_period_ms < 0x2::clock::timestamp_ms(arg3), 114);
        assert!(arg2.total_stakers > 0, 118);
        assert!(arg2.total_stakers > arg2.total_stakers_checked, 119);
        let v0 = 0x2::linked_table::length<address, UserJwltokenInfo>(&arg2.user_jwltoken_info);
        let v1 = 0;
        let v2 = *0x1::option::borrow<address>(0x2::linked_table::front<address, UserJwltokenInfo>(&arg2.user_jwltoken_info));
        while (v1 < v0) {
            let v3 = 0x2::linked_table::borrow_mut<address, UserJwltokenInfo>(&mut arg2.user_jwltoken_info, v2);
            if (arg2.current_epoch != v3.last_epoch_checked) {
                if (v3.jwltoken_staked > 0) {
                    let v4 = 0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::math::mul_div(v3.jwltoken_staked, arg2.epoch_rewards, arg2.total_jwlcetus_staked);
                    arg2.total_jwlcetus_compounded = arg2.total_jwlcetus_compounded + v4;
                    arg2.total_stakers_checked = arg2.total_stakers_checked + 1;
                    v3.jwltoken_staked = v3.jwltoken_staked + v4;
                    v3.total_rewards = v3.total_rewards + v4;
                    v3.last_epoch_checked = arg2.current_epoch;
                };
            };
            if (v0 >= 2 && v1 >= v0 - 2) {
                let v5 = 0x1::option::borrow<address>(0x2::linked_table::next<address, UserJwltokenInfo>(&arg2.user_jwltoken_info, v2));
                v2 = *v5;
            };
            v1 = v1 + 1;
        };
        let v6 = RewardsDistributedEvent{
            reward_token_type_name : 0x1::type_name::get<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>(),
            epoch                  : arg2.current_epoch,
            total_rewards          : arg2.epoch_rewards,
            total_stakers          : arg2.total_stakers,
        };
        0x2::event::emit<RewardsDistributedEvent>(v6);
    }

    public entry fun distribute_rewards_sca(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OperatorCap, arg1: &mut GlobalState, arg2: &mut TokenInfoSca, arg3: &0x2::clock::Clock) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg2.epoch_start_time + arg1.epoch_period_ms < 0x2::clock::timestamp_ms(arg3), 114);
        assert!(arg2.total_stakers > 0, 118);
        assert!(arg2.total_stakers > arg2.total_stakers_checked, 119);
        let v0 = 0x2::linked_table::length<address, UserJwltokenInfo>(&arg2.user_jwltoken_info);
        let v1 = 0;
        let v2 = *0x1::option::borrow<address>(0x2::linked_table::front<address, UserJwltokenInfo>(&arg2.user_jwltoken_info));
        while (v1 < v0) {
            let v3 = 0x2::linked_table::borrow_mut<address, UserJwltokenInfo>(&mut arg2.user_jwltoken_info, v2);
            if (arg2.current_epoch != v3.last_epoch_checked) {
                if (v3.jwltoken_staked > 0) {
                    let v4 = 0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::math::mul_div(v3.jwltoken_staked, arg2.epoch_rewards, arg2.total_jwlsca_staked);
                    arg2.total_jwlsca_compounded = arg2.total_jwlsca_compounded + v4;
                    arg2.total_stakers_checked = arg2.total_stakers_checked + 1;
                    v3.jwltoken_staked = v3.jwltoken_staked + v4;
                    v3.total_rewards = v3.total_rewards + v4;
                    v3.last_epoch_checked = arg2.current_epoch;
                };
            };
            if (v0 >= 2 && v1 >= v0 - 2) {
                let v5 = 0x1::option::borrow<address>(0x2::linked_table::next<address, UserJwltokenInfo>(&arg2.user_jwltoken_info, v2));
                v2 = *v5;
            };
            v1 = v1 + 1;
        };
        let v6 = RewardsDistributedEvent{
            reward_token_type_name : 0x1::type_name::get<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>(),
            epoch                  : arg2.current_epoch,
            total_rewards          : arg2.epoch_rewards,
            total_stakers          : arg2.total_stakers,
        };
        0x2::event::emit<RewardsDistributedEvent>(v6);
    }

    public entry fun extend_lock_period_sca(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OperatorCap, arg1: &mut GlobalState, arg2: &mut TokenInfoSca, arg3: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg4: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg5: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg6: u64, arg7: &0x2::clock::Clock) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(0x1::option::is_some<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg2.ve_sca_key), 122);
        assert!(arg2.ve_sca_unlock_at <= 0x2::clock::timestamp_ms(arg7) + 126144000000 - 2 * 86400000, 122);
        0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::extend_lock_period(arg3, 0x1::option::borrow<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg2.ve_sca_key), arg4, arg5, arg6, arg7);
        arg2.ve_sca_unlock_at = arg6 * 1000;
        let v0 = ExtendScaLockPeriodEvent{
            ve_sca_key_id : 0x2::object::id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(0x1::option::borrow<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg2.ve_sca_key)),
            new_unlock_at : arg6,
        };
        0x2::event::emit<ExtendScaLockPeriodEvent>(v0);
    }

    public fun get_block_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun get_user_jwlcetus_info(arg0: &TokenInfoCetus, arg1: address) : UserJwltokenInfo {
        if (!0x2::linked_table::contains<address, UserJwltokenInfo>(&arg0.user_jwltoken_info, arg1)) {
            UserJwltokenInfo{jwltoken_staked: 0, total_rewards: 0, last_staked_at: 0, last_epoch_checked: 0}
        } else {
            *0x2::linked_table::borrow<address, UserJwltokenInfo>(&arg0.user_jwltoken_info, arg1)
        }
    }

    public fun get_user_jwlsca_info(arg0: &TokenInfoSca, arg1: address) : UserJwltokenInfo {
        if (!0x2::linked_table::contains<address, UserJwltokenInfo>(&arg0.user_jwltoken_info, arg1)) {
            UserJwltokenInfo{jwltoken_staked: 0, total_rewards: 0, last_staked_at: 0, last_epoch_checked: 0}
        } else {
            *0x2::linked_table::borrow<address, UserJwltokenInfo>(&arg0.user_jwltoken_info, arg1)
        }
    }

    public entry fun initialize_global_state(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalState{
            id                      : 0x2::object::new(arg2),
            version                 : 1,
            is_active               : true,
            platform_fee_percentage : arg1,
            epoch_period_ms         : 604800000,
            locking_period_ms       : 604800000,
            tokens                  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<GlobalState>(v0);
    }

    public entry fun migrate(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: &mut GlobalState) {
        assert_active(arg1);
        assert!(arg1.version < 1, 1);
        let v0 = MigratedEvent{
            prev_version : arg1.version,
            new_version  : 1,
        };
        0x2::event::emit<MigratedEvent>(v0);
        arg1.version = 1;
    }

    public entry fun mint_venft_and_stake_cetus(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OperatorCap, arg1: &mut GlobalState, arg2: &mut TokenInfoCetus, arg3: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::LockUpManager, arg4: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg2.cetus_vault) > 0, 110);
        assert!(0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg2.cetus_vault) >= arg2.total_cetus_to_stake, 111);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>();
        let v1 = 0x2::coin::take<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg2.cetus_vault, arg2.total_cetus_to_stake, arg6);
        let v2 = 0x2::coin::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v1);
        0x1::vector::push_back<0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut v0, v1);
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::mint_and_convert(arg3, arg4, v0, v2, arg6);
        arg2.total_cetus_to_stake = arg2.total_cetus_to_stake - v2;
        arg2.total_cetus_staked = arg2.total_cetus_staked + v2;
        let v3 = StakeCetusEvent{
            user      : 0x2::tx_context::sender(arg6),
            amount    : v2,
            staked_at : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<StakeCetusEvent>(v3);
    }

    public entry fun redeem_sca(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: &mut GlobalState, arg2: &mut TokenInfoSca, arg3: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg4: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey, arg5: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg6: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg2.ve_sca_unlock_at < 0x2::clock::timestamp_ms(arg7), 115);
        let v0 = 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::redeem(arg3, arg4, arg5, arg6, arg7, arg8);
        arg2.total_sca_staked = arg2.total_sca_staked - 0x2::coin::value<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>>(v0, 0x2::tx_context::sender(arg8));
    }

    public entry fun redeem_ve_sca_key(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: &mut GlobalState, arg2: &mut TokenInfoSca, arg3: address) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = 0x1::option::extract<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&mut arg2.ve_sca_key);
        let v1 = VeScaKeyRedeemedEvent{ve_sca_key_id: 0x2::object::id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&v0)};
        0x2::event::emit<VeScaKeyRedeemedEvent>(v1);
        0x2::transfer::public_transfer<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(v0, arg3);
    }

    public entry fun register_token_cetus(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: &mut GlobalState, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.tokens, &v0), 112);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.tokens, 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>());
        let v1 = TokenInfoCetus{
            id                           : 0x2::object::new(arg5),
            cetus_vault                  : 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
            jwlcetus_vault               : 0x2::balance::zero<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>(),
            min_deposit_amount           : arg2,
            staking_percentage           : arg3,
            total_cetus_to_stake         : 0,
            total_cetus_staked           : 0,
            total_cetus_to_add_liquidity : 0,
            total_jwlcetus_staked        : 0,
            total_jwlcetus_compounded    : 0,
            total_stakers                : 0,
            total_stakers_checked        : 0,
            current_epoch                : 1,
            epoch_rewards                : 0,
            epoch_start_time             : 0x2::clock::timestamp_ms(arg4),
            last_epoch_got_rewards       : 0,
            user_jwltoken_info           : 0x2::linked_table::new<address, UserJwltokenInfo>(arg5),
        };
        0x2::transfer::share_object<TokenInfoCetus>(v1);
    }

    public entry fun register_token_sca(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: &mut GlobalState, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = 0x1::type_name::get<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.tokens, &v0), 112);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.tokens, 0x1::type_name::get<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>());
        let v1 = TokenInfoSca{
            id                         : 0x2::object::new(arg5),
            sca_vault                  : 0x2::balance::zero<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(),
            jwlsca_vault               : 0x2::balance::zero<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>(),
            min_deposit_amount         : arg2,
            staking_percentage         : arg3,
            total_sca_to_stake         : 0,
            total_sca_staked           : 0,
            total_sca_to_add_liquidity : 0,
            total_jwlsca_staked        : 0,
            total_jwlsca_compounded    : 0,
            total_stakers              : 0,
            total_stakers_checked      : 0,
            current_epoch              : 1,
            epoch_rewards              : 0,
            epoch_start_time           : 0x2::clock::timestamp_ms(arg4),
            last_epoch_got_rewards     : 0,
            user_jwltoken_info         : 0x2::linked_table::new<address, UserJwltokenInfo>(arg5),
            ve_sca_unlock_at           : 0,
            ve_sca_key                 : 0x1::option::none<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(),
        };
        0x2::transfer::share_object<TokenInfoSca>(v1);
    }

    public entry fun stake_cetus(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OperatorCap, arg1: &mut GlobalState, arg2: &mut TokenInfoCetus, arg3: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::LockUpManager, arg4: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg5: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg2.cetus_vault) > 0, 110);
        assert!(0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg2.cetus_vault) >= arg2.total_cetus_to_stake, 111);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>();
        let v1 = 0x2::coin::take<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg2.cetus_vault, arg2.total_cetus_to_stake, arg7);
        let v2 = 0x2::coin::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v1);
        0x1::vector::push_back<0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&mut v0, v1);
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::convert(arg3, arg4, v0, v2, arg5, arg7);
        arg2.total_cetus_to_stake = arg2.total_cetus_to_stake - v2;
        arg2.total_cetus_staked = arg2.total_cetus_staked + v2;
        let v3 = StakeCetusEvent{
            user      : 0x2::tx_context::sender(arg7),
            amount    : v2,
            staked_at : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<StakeCetusEvent>(v3);
    }

    public entry fun stake_jwlcetus(arg0: &mut GlobalState, arg1: &mut TokenInfoCetus, arg2: 0x2::coin::Coin<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        let v0 = &mut arg1.user_jwltoken_info;
        check_user_jwltoken_info(v0, 0x2::tx_context::sender(arg4));
        let v1 = 0x2::linked_table::borrow_mut<address, UserJwltokenInfo>(&mut arg1.user_jwltoken_info, 0x2::tx_context::sender(arg4));
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.epoch_start_time + arg0.epoch_period_ms >= v2, 113);
        let v3 = 0x2::coin::value<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>(&arg2);
        0x2::coin::put<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>(&mut arg1.jwlcetus_vault, arg2);
        if (v1.jwltoken_staked == 0) {
            arg1.total_stakers = arg1.total_stakers + 1;
        };
        arg1.total_jwlcetus_staked = arg1.total_jwlcetus_staked + v3;
        v1.jwltoken_staked = v1.jwltoken_staked + v3;
        v1.last_staked_at = v2;
        let v4 = StakeJwlcetusEvent{
            user      : 0x2::tx_context::sender(arg4),
            amount    : v3,
            staked_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StakeJwlcetusEvent>(v4);
    }

    public entry fun stake_jwlsca(arg0: &mut GlobalState, arg1: &mut TokenInfoSca, arg2: 0x2::coin::Coin<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        let v0 = &mut arg1.user_jwltoken_info;
        check_user_jwltoken_info(v0, 0x2::tx_context::sender(arg4));
        let v1 = 0x2::linked_table::borrow_mut<address, UserJwltokenInfo>(&mut arg1.user_jwltoken_info, 0x2::tx_context::sender(arg4));
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.epoch_start_time + arg0.epoch_period_ms >= v2, 113);
        let v3 = 0x2::coin::value<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>(&arg2);
        0x2::coin::put<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>(&mut arg1.jwlsca_vault, arg2);
        if (v1.jwltoken_staked == 0) {
            arg1.total_stakers = arg1.total_stakers + 1;
        };
        arg1.total_jwlsca_staked = arg1.total_jwlsca_staked + v3;
        v1.jwltoken_staked = v1.jwltoken_staked + v3;
        v1.last_staked_at = v2;
        let v4 = StakeJwlscaEvent{
            user      : 0x2::tx_context::sender(arg4),
            amount    : v3,
            staked_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StakeJwlscaEvent>(v4);
    }

    public entry fun stake_sca(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OperatorCap, arg1: &mut GlobalState, arg2: &mut TokenInfoSca, arg3: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg4: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg5: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(0x2::balance::value<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&arg2.sca_vault) > 0, 110);
        assert!(0x2::balance::value<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&arg2.sca_vault) >= arg2.total_sca_to_stake, 111);
        let v0 = 0x2::coin::take<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&mut arg2.sca_vault, arg2.total_sca_to_stake, arg8);
        let v1 = 0x2::coin::value<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&v0);
        if (0x1::option::is_none<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg2.ve_sca_key)) {
            0x1::option::fill<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&mut arg2.ve_sca_key, 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::mint_ve_sca_key(arg3, arg4, arg5, v0, arg6, arg7, arg8));
            arg2.ve_sca_unlock_at = arg6 * 1000;
        } else {
            if (arg2.ve_sca_unlock_at <= 0x2::clock::timestamp_ms(arg7) + 126144000000 - 2 * 86400000) {
                0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::extend_lock_period(arg3, 0x1::option::borrow<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg2.ve_sca_key), arg4, arg5, arg6, arg7);
                arg2.ve_sca_unlock_at = arg6 * 1000;
            };
            0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::lock_more_sca(arg3, 0x1::option::borrow<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg2.ve_sca_key), arg4, arg5, v0, arg7);
        };
        arg2.total_sca_to_stake = arg2.total_sca_to_stake - v1;
        arg2.total_sca_staked = arg2.total_sca_staked + v1;
        let v2 = StakeScaEvent{
            user      : 0x2::tx_context::sender(arg8),
            amount    : v1,
            staked_at : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<StakeScaEvent>(v2);
    }

    public entry fun trigger_next_epoch_cetus(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OperatorCap, arg1: &mut GlobalState, arg2: &mut TokenInfoCetus, arg3: &0x2::clock::Clock) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg2.epoch_start_time + arg1.epoch_period_ms < v0, 114);
        assert!(arg2.total_stakers == arg2.total_stakers_checked, 120);
        arg2.total_jwlcetus_staked = arg2.total_jwlcetus_staked + arg2.total_jwlcetus_compounded;
        arg2.total_stakers_checked = 0;
        arg2.total_jwlcetus_compounded = 0;
        arg2.current_epoch = arg2.current_epoch + 1;
        arg2.epoch_rewards = 0;
        arg2.epoch_start_time = v0;
        let v1 = TriggeredNextEpochEvent{
            prev_epoch : arg2.current_epoch - 1,
            next_epoch : arg2.current_epoch,
        };
        0x2::event::emit<TriggeredNextEpochEvent>(v1);
    }

    public entry fun trigger_next_epoch_sca(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OperatorCap, arg1: &mut GlobalState, arg2: &mut TokenInfoSca, arg3: &0x2::clock::Clock) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg2.epoch_start_time + arg1.epoch_period_ms < v0, 114);
        assert!(arg2.total_stakers == arg2.total_stakers_checked, 120);
        arg2.total_jwlsca_staked = arg2.total_jwlsca_staked + arg2.total_jwlsca_compounded;
        arg2.total_stakers_checked = 0;
        arg2.total_jwlsca_compounded = 0;
        arg2.current_epoch = arg2.current_epoch + 1;
        arg2.epoch_rewards = 0;
        arg2.epoch_start_time = v0;
        let v1 = TriggeredNextEpochEvent{
            prev_epoch : arg2.current_epoch - 1,
            next_epoch : arg2.current_epoch,
        };
        0x2::event::emit<TriggeredNextEpochEvent>(v1);
    }

    public entry fun unstake_jwlcetus(arg0: &mut GlobalState, arg1: &mut TokenInfoCetus, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::linked_table::borrow_mut<address, UserJwltokenInfo>(&mut arg1.user_jwltoken_info, 0x2::tx_context::sender(arg4));
        assert!(arg1.epoch_start_time + arg0.epoch_period_ms >= v0, 113);
        assert!(v1.last_staked_at + arg0.locking_period_ms < v0, 115);
        assert!(v1.jwltoken_staked >= arg3, 116);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>>(0x2::coin::take<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlcetus::JWLCETUS>(&mut arg1.jwlcetus_vault, arg3, arg4), 0x2::tx_context::sender(arg4));
        if (v1.jwltoken_staked == arg3) {
            arg1.total_stakers = arg1.total_stakers - 1;
        };
        arg1.total_jwlcetus_staked = arg1.total_jwlcetus_staked - arg3;
        v1.jwltoken_staked = v1.jwltoken_staked - arg3;
        let v2 = UnstakeJwlcetusEvent{
            user        : 0x2::tx_context::sender(arg4),
            amount      : arg3,
            unstaked_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UnstakeJwlcetusEvent>(v2);
    }

    public entry fun unstake_jwlsca(arg0: &mut GlobalState, arg1: &mut TokenInfoSca, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::linked_table::borrow_mut<address, UserJwltokenInfo>(&mut arg1.user_jwltoken_info, 0x2::tx_context::sender(arg4));
        assert!(arg1.epoch_start_time + arg0.epoch_period_ms >= v0, 113);
        assert!(v1.last_staked_at + arg0.locking_period_ms < v0, 115);
        assert!(v1.jwltoken_staked >= arg3, 116);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>>(0x2::coin::take<0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::jwlsca::JWLSCA>(&mut arg1.jwlsca_vault, arg3, arg4), 0x2::tx_context::sender(arg4));
        if (v1.jwltoken_staked == arg3) {
            arg1.total_stakers = arg1.total_stakers - 1;
        };
        arg1.total_jwlsca_staked = arg1.total_jwlsca_staked - arg3;
        v1.jwltoken_staked = v1.jwltoken_staked - arg3;
        let v2 = UnstakeJwlscaEvent{
            user        : 0x2::tx_context::sender(arg4),
            amount      : arg3,
            unstaked_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UnstakeJwlscaEvent>(v2);
    }

    public entry fun update_active_status(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: &mut GlobalState, arg2: bool) {
        assert_version(arg1);
        arg1.is_active = arg2;
        let v0 = ActiveStatusUpdatedEvent{current_status: arg2};
        0x2::event::emit<ActiveStatusUpdatedEvent>(v0);
    }

    public entry fun update_epoch_period(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: &mut GlobalState, arg2: u64) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = EpochPeriodUpdatedEvent{
            prev_value : arg1.epoch_period_ms,
            new_value  : arg2,
        };
        0x2::event::emit<EpochPeriodUpdatedEvent>(v0);
        arg1.epoch_period_ms = arg2;
    }

    public entry fun update_locking_period(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: &mut GlobalState, arg2: u64) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = LockingPeriodUpdatedEvent{
            prev_value : arg1.locking_period_ms,
            new_value  : arg2,
        };
        0x2::event::emit<LockingPeriodUpdatedEvent>(v0);
        arg1.locking_period_ms = arg2;
    }

    public entry fun update_min_deposit_amount_cetus(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: &GlobalState, arg2: &mut TokenInfoCetus, arg3: u64) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = MinDepositAmountUpdatedEvent{
            prev_value : arg2.min_deposit_amount,
            new_value  : arg3,
        };
        0x2::event::emit<MinDepositAmountUpdatedEvent>(v0);
        arg2.min_deposit_amount = arg3;
    }

    public entry fun update_min_deposit_amount_sca(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: &GlobalState, arg2: &mut TokenInfoSca, arg3: u64) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = MinDepositAmountUpdatedEvent{
            prev_value : arg2.min_deposit_amount,
            new_value  : arg3,
        };
        0x2::event::emit<MinDepositAmountUpdatedEvent>(v0);
        arg2.min_deposit_amount = arg3;
    }

    public entry fun update_staking_percentage_cetus(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: &GlobalState, arg2: &mut TokenInfoCetus, arg3: u64) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = StakingPercentageUpdatedEvent{
            prev_value : arg2.staking_percentage,
            new_value  : arg3,
        };
        0x2::event::emit<StakingPercentageUpdatedEvent>(v0);
        arg2.staking_percentage = arg3;
    }

    public entry fun update_staking_percentage_sca(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: &GlobalState, arg2: &mut TokenInfoSca, arg3: u64) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = StakingPercentageUpdatedEvent{
            prev_value : arg2.staking_percentage,
            new_value  : arg3,
        };
        0x2::event::emit<StakingPercentageUpdatedEvent>(v0);
        arg2.staking_percentage = arg3;
    }

    public entry fun update_ve_sca_key(arg0: &0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::ownership::OwnerCap, arg1: &mut GlobalState, arg2: &mut TokenInfoSca, arg3: 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        assert_version(arg1);
        0x2::transfer::public_transfer<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(0x1::option::extract<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&mut arg2.ve_sca_key), 0x2::tx_context::sender(arg4));
        let v0 = VeScaKeyUpdatedEvent{ve_sca_key_id: 0x2::object::id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg3)};
        0x2::event::emit<VeScaKeyUpdatedEvent>(v0);
        0x1::option::fill<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&mut arg2.ve_sca_key, arg3);
    }

    // decompiled from Move bytecode v6
}

