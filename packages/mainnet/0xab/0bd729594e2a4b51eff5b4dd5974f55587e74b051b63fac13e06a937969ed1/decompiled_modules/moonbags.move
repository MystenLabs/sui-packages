module 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ConfigChangedEvent has copy, drop, store {
        old_platform_fee: u64,
        new_platform_fee: u64,
        old_initial_virtual_token_reserves: u64,
        new_initial_virtual_token_reserves: u64,
        old_remain_token_reserves: u64,
        new_remain_token_reserves: u64,
        old_token_decimals: u8,
        new_token_decimals: u8,
        old_init_platform_fee_withdraw: u16,
        new_init_platform_fee_withdraw: u16,
        old_init_creator_fee_withdraw: u16,
        new_init_creator_fee_withdraw: u16,
        old_init_stake_fee_withdraw: u16,
        new_init_stake_fee_withdraw: u16,
        old_init_platform_stake_fee_withdraw: u16,
        new_init_platform_stake_fee_withdraw: u16,
        old_token_platform_type_name: 0x1::ascii::String,
        new_token_platform_type_name: 0x1::ascii::String,
        ts: u64,
    }

    struct ConfigChangedEventV2 has copy, drop, store {
        old_platform_fee: u64,
        new_platform_fee: u64,
        old_initial_virtual_token_reserves: u64,
        new_initial_virtual_token_reserves: u64,
        old_remain_token_reserves: u64,
        new_remain_token_reserves: u64,
        old_token_decimals: u8,
        new_token_decimals: u8,
        old_init_platform_fee_withdraw: u16,
        new_init_platform_fee_withdraw: u16,
        old_init_creator_fee_withdraw: u16,
        new_init_creator_fee_withdraw: u16,
        old_init_stake_fee_withdraw: u16,
        new_init_stake_fee_withdraw: u16,
        old_init_platform_stake_fee_withdraw: u16,
        new_init_platform_stake_fee_withdraw: u16,
        old_token_platform_type_name: 0x1::ascii::String,
        new_token_platform_type_name: 0x1::ascii::String,
        ts: u64,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        treasury: address,
        fee_platform_recipient: address,
        platform_fee: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
        init_platform_fee_withdraw: u16,
        init_creator_fee_withdraw: u16,
        init_stake_fee_withdraw: u16,
        init_platform_stake_fee_withdraw: u16,
        token_platform_type_name: 0x1::ascii::String,
    }

    struct CreatedEvent has copy, drop, store {
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        uri: 0x1::ascii::String,
        description: 0x1::ascii::String,
        twitter: 0x1::ascii::String,
        telegram: 0x1::ascii::String,
        website: 0x1::ascii::String,
        token_address: 0x1::ascii::String,
        bonding_curve: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        created_by: address,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        real_sui_reserves: u64,
        real_token_reserves: u64,
        platform_fee_withdraw: u16,
        creator_fee_withdraw: u16,
        stake_fee_withdraw: u16,
        platform_stake_fee_withdraw: u16,
        threshold: u64,
        ts: u64,
    }

    struct CreatedEventV2 has copy, drop, store {
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        uri: 0x1::ascii::String,
        description: 0x1::ascii::String,
        twitter: 0x1::ascii::String,
        telegram: 0x1::ascii::String,
        website: 0x1::ascii::String,
        token_address: 0x1::ascii::String,
        bonding_curve: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        created_by: address,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        real_sui_reserves: u64,
        real_token_reserves: u64,
        platform_fee_withdraw: u16,
        creator_fee_withdraw: u16,
        stake_fee_withdraw: u16,
        platform_stake_fee_withdraw: u16,
        threshold: u64,
        bonding_dex: u8,
        ts: u64,
    }

    struct OwnershipTransferredEvent has copy, drop, store {
        old_admin: address,
        new_admin: address,
        ts: u64,
    }

    struct OwnershipTransferredEventV2 has copy, drop, store {
        old_admin: address,
        new_admin: address,
        ts: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        real_sui_reserves: 0x2::coin::Coin<0x2::sui::SUI>,
        real_token_reserves: 0x2::coin::Coin<T0>,
        virtual_token_reserves: u64,
        virtual_sui_reserves: u64,
        remain_token_reserves: 0x2::coin::Coin<T0>,
        fee_recipient: 0x2::coin::Coin<0x2::sui::SUI>,
        is_completed: bool,
        platform_fee_withdraw: u16,
        creator_fee_withdraw: u16,
        stake_fee_withdraw: u16,
        platform_stake_fee_withdraw: u16,
        threshold: u64,
    }

    struct PoolCompletedEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        lp: 0x1::ascii::String,
        ts: u64,
    }

    struct PoolCompletedEventV2 has copy, drop, store {
        token_address: 0x1::ascii::String,
        lp: 0x1::ascii::String,
        ts: u64,
    }

    struct PoolMigratingEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        sui_amount: u64,
        token_amount: u64,
        bonding_dex: u8,
        ts: u64,
    }

    struct ThresholdConfig has store, key {
        id: 0x2::object::UID,
        threshold: u64,
    }

    struct TradedEvent has copy, drop, store {
        is_buy: bool,
        user: address,
        token_address: 0x1::ascii::String,
        sui_amount: u64,
        token_amount: u64,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        real_sui_reserves: u64,
        real_token_reserves: u64,
        pool_id: 0x2::object::ID,
        fee: u64,
        ts: u64,
    }

    struct TradedEventV2 has copy, drop, store {
        is_buy: bool,
        user: address,
        token_address: 0x1::ascii::String,
        sui_amount: u64,
        token_amount: u64,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        real_sui_reserves: u64,
        real_token_reserves: u64,
        pool_id: 0x2::object::ID,
        fee: u64,
        ts: u64,
    }

    public fun assert_pool_not_completed<T0>(arg0: &Configuration) {
        abort 0
    }

    public fun burn_turbos_position_nft<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg1: &mut Configuration, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun buy_exact_in<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun buy_exact_in_returns<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        abort 0
    }

    public fun buy_exact_in_returns_with_lock<T0>(arg0: &mut Configuration, arg1: &0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_token_lock::Configuration, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        abort 0
    }

    public entry fun buy_exact_in_with_lock<T0>(arg0: &mut Configuration, arg1: &0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_token_lock::Configuration, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun buy_exact_out<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun buy_exact_out_returns<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        abort 0
    }

    public fun check_pool_exist<T0>(arg0: &Configuration) : bool {
        abort 0
    }

    public entry fun create<T0>(arg0: &mut Configuration, arg1: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_stake::Configuration, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::CoinMetadata<T0>, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun create_and_first_buy<T0>(arg0: &mut Configuration, arg1: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_stake::Configuration, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg15: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg17: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg18: 0x2::coin::CoinMetadata<T0>, arg19: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun create_and_first_buy_v2<T0>(arg0: &mut Configuration, arg1: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_stake::Configuration, arg2: 0x2::coin::TreasuryCap<T0>, arg3: u8, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: 0x1::ascii::String, arg15: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg18: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg19: 0x2::coin::CoinMetadata<T0>, arg20: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun create_and_lock_first_buy<T0>(arg0: &mut Configuration, arg1: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_stake::Configuration, arg2: &0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_token_lock::Configuration, arg3: 0x2::coin::TreasuryCap<T0>, arg4: u8, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: u64, arg9: &0x2::clock::Clock, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: 0x1::ascii::String, arg15: 0x1::ascii::String, arg16: 0x1::ascii::String, arg17: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg19: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg20: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg21: 0x2::coin::CoinMetadata<T0>, arg22: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun create_and_lock_first_buy_with_fee<T0>(arg0: &mut Configuration, arg1: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_stake::Configuration, arg2: &0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_token_lock::Configuration, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u8, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: u64, arg10: &0x2::clock::Clock, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: 0x1::ascii::String, arg15: 0x1::ascii::String, arg16: 0x1::ascii::String, arg17: 0x1::ascii::String, arg18: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg19: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg20: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg21: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg22: 0x2::coin::CoinMetadata<T0>, arg23: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun create_threshold_config(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun create_v2<T0>(arg0: &mut Configuration, arg1: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_stake::Configuration, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::CoinMetadata<T0>, arg4: u8, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun create_with_fee<T0>(arg0: &mut Configuration, arg1: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_stake::Configuration, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u8, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: 0x1::ascii::String, arg15: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun early_complete_pool<T0>(arg0: &AdminCap, arg1: &mut Configuration, arg2: &mut ThresholdConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun estimate_amount_out<T0>(arg0: &mut Configuration, arg1: u64, arg2: u64) : (u64, u64) {
        abort 0
    }

    public entry fun init_cetus_pool<T0>(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: &mut Pool<T0>, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun migrate_version(arg0: &AdminCap, arg1: &mut Configuration) {
        abort 0
    }

    public fun redeem<T0>(arg0: &mut Configuration, arg1: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::Versioned, arg2: &mut 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::ClmmVester, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: u16, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun release_inner<T0>(arg0: &mut Configuration, arg1: 0x1::ascii::String, arg2: address) {
        0x2::transfer::public_transfer<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(0x2::dynamic_object_field::remove<vector<u8>, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, arg1).id, b"burn_proof"), arg2);
    }

    public fun release_proof<T0>(arg0: &0x2::package::UpgradeCap, arg1: &mut Configuration, arg2: 0x1::ascii::String, arg3: address) {
        assert!(0x2::object::id_address<0x2::package::UpgradeCap>(arg0) == @0x8db6a874b0828427c59cf0d7cccf50c1523a8b264ab784cbc0bfedb632668b8b, 9001);
        release_inner<T0>(arg1, arg2, arg3);
    }

    public entry fun sell<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun sell_returns<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        abort 0
    }

    public fun skim<T0>(arg0: &AdminCap, arg1: &mut Configuration, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: &mut Configuration, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun update_buy_block_duration_config(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64) {
        abort 0
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u16, arg7: u16, arg8: u16, arg9: u16, arg10: 0x1::ascii::String, arg11: &0x2::clock::Clock) {
        abort 0
    }

    public entry fun update_config_withdraw_fee(arg0: &AdminCap, arg1: &mut Configuration, arg2: u16, arg3: u16, arg4: u16, arg5: u16) {
        abort 0
    }

    public entry fun update_fee_recipients(arg0: &AdminCap, arg1: &mut Configuration, arg2: address, arg3: address) {
        abort 0
    }

    public entry fun update_initial_virtual_token_reserves(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64) {
        abort 0
    }

    public entry fun update_lock_buy_duration_config(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64) {
        abort 0
    }

    public entry fun update_threshold_config(arg0: &AdminCap, arg1: &mut ThresholdConfig, arg2: u64) {
        abort 0
    }

    public fun withdraw_fee_bonding_curve<T0, T1>(arg0: &mut Configuration, arg1: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_stake::Configuration, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun withdraw_fee_cetus<T0, T1>(arg0: &mut Configuration, arg1: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_stake::Configuration, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun withdraw_fee_turbos_sui_after<T0, T1, T2>(arg0: &mut Configuration, arg1: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_stake::Configuration, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun withdraw_fee_turbos_sui_first<T0, T1, T2>(arg0: &mut Configuration, arg1: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_stake::Configuration, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, T0, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v7
}

