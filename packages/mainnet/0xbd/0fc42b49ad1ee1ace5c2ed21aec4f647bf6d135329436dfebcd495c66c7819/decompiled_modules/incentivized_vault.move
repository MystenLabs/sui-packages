module 0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::incentivized_vault {
    struct IncentivizedVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        vault: 0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::DeepBookVault,
        incentive_pool: 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::Pool<T0>,
        incentive_pool_cap: 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::AdminCap,
        incentive_balance: 0x2::balance::Balance<T1>,
        stake: 0x1::option::Option<0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::Stake<T0>>,
        owner: address,
    }

    struct IncentivizedVaultCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        incentive_pool_id: 0x2::object::ID,
        privilege: u64,
    }

    public fun balance<T0, T1, T2>(arg0: &IncentivizedVault<T0, T1>) : u64 {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::balance<T2>(&arg0.vault)
    }

    public fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : IncentivizedVault<T0, T1> {
        let (v0, v1) = 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::create<T0>(arg0);
        IncentivizedVault<T0, T1>{
            id                 : 0x2::object::new(arg0),
            vault              : 0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::new(arg0),
            incentive_pool     : v0,
            incentive_pool_cap : v1,
            incentive_balance  : 0x2::balance::zero<T1>(),
            stake              : 0x1::option::none<0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::Stake<T0>>(),
            owner              : 0x2::tx_context::sender(arg0),
        }
    }

    public fun add_to_farm<T0, T1>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::farm::Farm<T1>, arg2: &0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::farm::AdminCap, arg3: &0x2::clock::Clock) {
        0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::add_to_farm<T1, T0>(arg2, arg1, &arg0.incentive_pool_cap, &mut arg0.incentive_pool, 100, arg3);
    }

    public fun top_up<T0, T1>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::farm::Farm<T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::new_top_up_ticket<T0>(&mut arg0.incentive_pool);
        0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::top_up<T1, T0>(arg1, &mut arg0.incentive_pool, &mut v0, arg3);
        0x1::option::fill<0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::Stake<T0>>(&mut arg0.stake, 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::deposit_shares_new<T0>(&mut arg0.incentive_pool, arg2, v0, arg4));
    }

    public fun balance_manager_id<T0, T1>(arg0: &IncentivizedVault<T0, T1>) : 0x2::object::ID {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::balance_manager_id(&arg0.vault)
    }

    public fun cancel_all_orders<T0, T1, T2, T3>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::cancel_all_orders<T2, T3>(&mut arg0.vault, arg1, arg2, arg3);
    }

    public fun cancel_all_orders_as_trader<T0, T1, T2, T3>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::cancel_all_orders_as_trader<T2, T3>(&mut arg0.vault, arg1, arg2, arg3, arg4);
    }

    public fun cancel_order<T0, T1, T2, T3>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::cancel_order<T2, T3>(&mut arg0.vault, arg1, arg2, arg3, arg4);
    }

    public fun cancel_order_as_trader<T0, T1, T2, T3>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::cancel_order_as_trader<T2, T3>(&mut arg0.vault, arg1, arg2, arg3, arg4, arg5);
    }

    public fun cancel_orders<T0, T1, T2, T3>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: vector<u128>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::cancel_orders<T2, T3>(&mut arg0.vault, arg1, arg2, arg3, arg4);
    }

    public fun cancel_orders_as_trader<T0, T1, T2, T3>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg3: vector<u128>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::cancel_orders_as_trader<T2, T3>(&mut arg0.vault, arg1, arg2, arg3, arg4, arg5);
    }

    public fun deposit<T0, T1, T2>(arg0: &mut IncentivizedVault<T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::deposit<T0>(&mut arg0.vault, arg1, arg2);
    }

    public fun generate_trade_proof_as_owner<T0, T1>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::generate_trade_proof_as_owner(&mut arg0.vault, arg1)
    }

    public fun generate_trade_proof_as_trader<T0, T1>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::generate_trade_proof_as_trader(&mut arg0.vault, arg1, arg2)
    }

    public fun mint_trade_cap<T0, T1>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::mint_trade_cap(&mut arg0.vault, arg1)
    }

    public fun place_limit_order<T0, T1, T2, T3>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: u64, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::place_limit_order<T2, T3>(&mut arg0.vault, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun place_limit_order_as_trader<T0, T1, T2, T3>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::place_limit_order_as_trader<T2, T3>(&mut arg0.vault, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun redeem_all<T0, T1, T2, T3, T4>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        assert_owner<T0, T1>(arg0, arg1);
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::redeem_all<T4>(&mut arg0.vault, arg1)
    }

    public fun withdraw_settled_amounts<T0, T1, T2, T3>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &mut 0x2::tx_context::TxContext) {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::withdraw_settled_amounts<T2, T3>(&mut arg0.vault, arg1, arg2);
    }

    public fun withdraw_settled_amounts_as_trader<T0, T1, T2, T3>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::db_vault::withdraw_settled_amounts_as_trader<T2, T3>(&mut arg0.vault, arg1, arg2, arg3);
    }

    fun assert_owner<T0, T1>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
    }

    fun assert_trade_capacity<T0, T1>(arg0: &IncentivizedVault<T0, T1>, arg1: &IncentivizedVaultCap<T0, T1>) {
        assert!(arg1.incentive_pool_id == 0x2::object::id<0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::Pool<T0>>(&arg0.incentive_pool), 1);
    }

    public fun collect_incentive_rewards<T0, T1>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::farm::Farm<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::new_top_up_ticket<T0>(&mut arg0.incentive_pool);
        0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::top_up<T1, T0>(arg1, &mut arg0.incentive_pool, &mut v0, arg2);
        0x2::balance::join<T1>(&mut arg0.incentive_balance, 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::collect_all_rewards<T1, T0>(&mut arg0.incentive_pool, 0x1::option::borrow_mut<0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::pool::Stake<T0>>(&mut arg0.stake), v0));
    }

    public fun incentive_balance<T0, T1>(arg0: &IncentivizedVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.incentive_balance)
    }

    public fun redeem_incentives<T0, T1>(arg0: &mut IncentivizedVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.incentive_balance), arg1)
    }

    // decompiled from Move bytecode v6
}

