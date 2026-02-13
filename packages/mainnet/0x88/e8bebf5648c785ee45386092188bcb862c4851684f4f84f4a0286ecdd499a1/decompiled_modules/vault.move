module 0xb749f8a72f200793e9df0fa3ac554ce94f81576ef901e7c5e871a140163cd85b::vault {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TradeCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        admin: address,
        balances: 0x2::bag::Bag,
        positions: 0x2::bag::Bag,
        position_refs: vector<PositionRef>,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionRef has copy, drop, store {
        id: 0x2::object::ID,
        protocol: u8,
    }

    public fun balance<T0>(arg0: &AdminCap, arg1: &Vault, arg2: &0x2::tx_context::TxContext) : u64 {
        assert_admin(arg1, arg2);
        balance_internal<T0>(arg1)
    }

    fun all_positions(arg0: &Vault) : vector<PositionRef> {
        let v0 = 0x1::vector::empty<PositionRef>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<PositionRef>(&arg0.position_refs)) {
            0x1::vector::push_back<PositionRef>(&mut v0, *0x1::vector::borrow<PositionRef>(&arg0.position_refs, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun all_positions_with_admin_cap(arg0: &AdminCap, arg1: &Vault, arg2: &0x2::tx_context::TxContext) : vector<PositionRef> {
        assert_admin(arg1, arg2);
        all_positions(arg1)
    }

    public fun all_positions_with_trade_cap(arg0: &TradeCap, arg1: &Vault) : vector<PositionRef> {
        assert_trade_cap_vault(arg0, arg1);
        all_positions(arg1)
    }

    public fun assert_admin(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
    }

    fun assert_trade_cap_vault(arg0: &TradeCap, arg1: &Vault) {
        assert!(arg0.vault_id == 0x2::object::id<Vault>(arg1), 1);
    }

    fun balance_internal<T0>(arg0: &Vault) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun balance_with_trade_cap<T0>(arg0: &TradeCap, arg1: &Vault) : u64 {
        assert_trade_cap_vault(arg0, arg1);
        balance_internal<T0>(arg1)
    }

    fun borrow_balance_mut<T0>(arg0: &mut Vault) : &mut 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
    }

    public fun close_cetus_navi_lp<T0, T1>(arg0: &TradeCap, arg1: &mut Vault, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg10: u8, arg11: u8, arg12: 0x2::object::ID, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = close_cetus_navi_lp_base<T0, T1>(arg0, arg1, arg2, arg8, arg9, arg12);
        close_cetus_navi_lp_finalize<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v0, v1, v2, arg13);
    }

    fun close_cetus_navi_lp_base<T0, T1>(arg0: &TradeCap, arg1: &mut Vault, arg2: &0x2::clock::Clock, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x2::object::ID) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert_trade_cap_vault(arg0, arg1);
        let v0 = delete_position<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, arg5);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let (v2, v3) = if (v1 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg3, arg4, &mut v0, v1, arg2)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg3, arg4, &v0, false);
        0x2::balance::join<T0>(&mut v5, v6);
        0x2::balance::join<T1>(&mut v4, v7);
        (v0, v5, v4)
    }

    fun close_cetus_navi_lp_finalize<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: u8, arg9: u8, arg10: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg11: 0x2::balance::Balance<T0>, arg12: 0x2::balance::Balance<T1>, arg13: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg6, arg7, arg10);
        deposit_balance_into_navi_if_non_zero<T0>(arg0, arg1, arg2, arg8, arg11, arg4, arg5, arg13);
        deposit_balance_into_navi_if_non_zero<T1>(arg0, arg1, arg3, arg9, arg12, arg4, arg5, arg13);
    }

    public fun close_cetus_navi_lp_with_1_reward<T0, T1, T2>(arg0: &TradeCap, arg1: &mut Vault, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: u8, arg12: u8, arg13: 0x2::object::ID, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = close_cetus_navi_lp_base<T0, T1>(arg0, arg1, arg2, arg8, arg10, arg13);
        let v3 = v0;
        let v4 = collect_cetus_reward_if_exists<T0, T1, T2>(arg2, arg8, arg9, arg10, &v3);
        close_cetus_navi_lp_finalize<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg11, arg12, v3, v1, v2, arg14);
        put_balance<T2>(arg1, v4);
    }

    public fun close_cetus_navi_lp_with_2_rewards<T0, T1, T2, T3>(arg0: &TradeCap, arg1: &mut Vault, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: u8, arg12: u8, arg13: 0x2::object::ID, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = close_cetus_navi_lp_base<T0, T1>(arg0, arg1, arg2, arg8, arg10, arg13);
        let v3 = v0;
        let v4 = collect_cetus_reward_if_exists<T0, T1, T2>(arg2, arg8, arg9, arg10, &v3);
        let v5 = collect_cetus_reward_if_exists<T0, T1, T3>(arg2, arg8, arg9, arg10, &v3);
        close_cetus_navi_lp_finalize<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg11, arg12, v3, v1, v2, arg14);
        put_balance<T2>(arg1, v4);
        put_balance<T3>(arg1, v5);
    }

    public fun close_cetus_navi_lp_with_3_rewards<T0, T1, T2, T3, T4>(arg0: &TradeCap, arg1: &mut Vault, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: u8, arg12: u8, arg13: 0x2::object::ID, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = close_cetus_navi_lp_base<T0, T1>(arg0, arg1, arg2, arg8, arg10, arg13);
        let v3 = v0;
        let v4 = collect_cetus_reward_if_exists<T0, T1, T2>(arg2, arg8, arg9, arg10, &v3);
        let v5 = collect_cetus_reward_if_exists<T0, T1, T3>(arg2, arg8, arg9, arg10, &v3);
        let v6 = collect_cetus_reward_if_exists<T0, T1, T4>(arg2, arg8, arg9, arg10, &v3);
        close_cetus_navi_lp_finalize<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg11, arg12, v3, v1, v2, arg14);
        put_balance<T2>(arg1, v4);
        put_balance<T3>(arg1, v5);
        put_balance<T4>(arg1, v6);
    }

    fun collect_cetus_reward_if_exists<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : 0x2::balance::Balance<T2> {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg3));
        if (0x1::option::is_some<u64>(&v0)) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg3, arg4, arg2, false, arg0)
        } else {
            0x2::balance::zero<T2>()
        }
    }

    public fun collect_cetus_reward_to_navi<T0, T1, T2>(arg0: &TradeCap, arg1: &Vault, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: 0x2::object::ID, arg12: &mut 0x2::tx_context::TxContext) {
        assert_trade_cap_vault(arg0, arg1);
        deposit_balance_into_navi_if_non_zero<T2>(arg2, arg3, arg4, arg5, collect_cetus_reward_if_exists<T0, T1, T2>(arg2, arg8, arg9, arg10, 0x2::bag::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions, arg11)), arg6, arg7, arg12);
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            balances      : 0x2::bag::new(arg0),
            positions     : 0x2::bag::new(arg0),
            position_refs : 0x1::vector::empty<PositionRef>(),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    fun delete_position<T0: store>(arg0: &mut Vault, arg1: 0x2::object::ID) : T0 {
        remove_position_ref(arg0, arg1);
        0x2::bag::remove<0x2::object::ID, T0>(&mut arg0.positions, arg1)
    }

    public fun delete_position_with_admin_cap<T0: store>(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : T0 {
        assert_admin(arg1, arg3);
        delete_position<T0>(arg1, arg2)
    }

    public fun delete_position_with_trade_cap<T0: store>(arg0: &TradeCap, arg1: &mut Vault, arg2: 0x2::object::ID) : T0 {
        assert_trade_cap_vault(arg0, arg1);
        delete_position<T0>(arg1, arg2)
    }

    public fun deposit<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        put_balance<T0>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    fun deposit_balance_into_navi_if_non_zero<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: u8, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg4);
        if (v0 > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::entry_deposit<T0>(arg0, arg1, arg2, arg3, 0x2::coin::from_balance<T0>(arg4, arg7), v0, arg5, arg6, arg7);
        } else {
            0x2::balance::destroy_zero<T0>(arg4);
        };
    }

    public fun deposit_with_trade_cap<T0>(arg0: &TradeCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<T0>) {
        assert_trade_cap_vault(arg0, arg1);
        put_balance<T0>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_trade_cap(arg0: &AdminCap, arg1: &Vault, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        let v0 = TradeCap{
            id       : 0x2::object::new(arg3),
            vault_id : 0x2::object::id<Vault>(arg1),
        };
        0x2::transfer::public_transfer<TradeCap>(v0, arg2);
    }

    public fun open_cetus_navi_lp<T0, T1>(arg0: &TradeCap, arg1: &mut Vault, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg12: u8, arg13: u8, arg14: u32, arg15: u32, arg16: u128, arg17: u64, arg18: u64, arg19: &mut 0x3::sui_system::SuiSystemState, arg20: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_trade_cap_vault(arg0, arg1);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg10, arg11, arg14, arg15, arg20);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg10, arg11, &mut v0, arg16, arg3);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v1);
        assert!(v2 <= arg17, 3);
        assert!(v3 <= arg18, 3);
        let v4 = if (v2 > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_v2<T0>(arg3, arg4, arg5, arg6, arg12, v2, arg8, arg9, arg19, arg20)
        } else {
            0x2::balance::zero<T0>()
        };
        let v5 = if (v3 > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_v2<T1>(arg3, arg4, arg5, arg7, arg13, v3, arg8, arg9, arg19, arg20)
        } else {
            0x2::balance::zero<T1>()
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg10, arg11, v4, v5, v1);
        let v6 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0);
        store_position<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, v6, v0, arg2);
        v6
    }

    public fun open_cetus_navi_lp_with_oracle_update<T0, T1>(arg0: &TradeCap, arg1: &mut Vault, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg15: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg16: u8, arg17: u8, arg18: u32, arg19: u32, arg20: u128, arg21: u64, arg22: u64, arg23: address, arg24: address, arg25: &mut 0x3::sui_system::SuiSystemState, arg26: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_trade_cap_vault(arg0, arg1);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg14, arg15, arg18, arg19, arg26);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg14, arg15, &mut v0, arg20, arg3);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v1);
        assert!(v2 <= arg21, 3);
        assert!(v3 <= arg22, 3);
        let v4 = if (v2 > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg3, arg5, arg4, arg6, arg7, arg23);
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_v2<T0>(arg3, arg4, arg9, arg10, arg16, v2, arg12, arg13, arg25, arg26)
        } else {
            0x2::balance::zero<T0>()
        };
        let v5 = if (v3 > 0) {
            0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg3, arg5, arg4, arg6, arg8, arg24);
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_v2<T1>(arg3, arg4, arg9, arg11, arg17, v3, arg12, arg13, arg25, arg26)
        } else {
            0x2::balance::zero<T1>()
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg14, arg15, v4, v5, v1);
        let v6 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0);
        store_position<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, v6, v0, arg2);
        v6
    }

    public fun position_ref_id(arg0: &PositionRef) : 0x2::object::ID {
        arg0.id
    }

    public fun position_ref_protocol(arg0: &PositionRef) : u8 {
        arg0.protocol
    }

    public fun position_refs_with_admin_cap(arg0: &AdminCap, arg1: &Vault, arg2: &0x2::tx_context::TxContext) : &vector<PositionRef> {
        assert_admin(arg1, arg2);
        &arg1.position_refs
    }

    public fun position_refs_with_trade_cap(arg0: &TradeCap, arg1: &Vault) : &vector<PositionRef> {
        assert_trade_cap_vault(arg0, arg1);
        &arg1.position_refs
    }

    fun positions_by_protocol(arg0: &Vault, arg1: u8) : vector<PositionRef> {
        let v0 = 0x1::vector::empty<PositionRef>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<PositionRef>(&arg0.position_refs)) {
            let v2 = *0x1::vector::borrow<PositionRef>(&arg0.position_refs, v1);
            if (v2.protocol == arg1) {
                0x1::vector::push_back<PositionRef>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun positions_by_protocol_with_admin_cap(arg0: &AdminCap, arg1: &Vault, arg2: u8, arg3: &0x2::tx_context::TxContext) : vector<PositionRef> {
        assert_admin(arg1, arg3);
        positions_by_protocol(arg1, arg2)
    }

    public fun positions_by_protocol_with_trade_cap(arg0: &TradeCap, arg1: &Vault, arg2: u8) : vector<PositionRef> {
        assert_trade_cap_vault(arg0, arg1);
        positions_by_protocol(arg1, arg2)
    }

    fun put_balance<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun put_balance_with_admin_cap<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        put_balance<T0>(arg1, arg2);
    }

    public fun put_balance_with_trade_cap<T0>(arg0: &TradeCap, arg1: &mut Vault, arg2: 0x2::balance::Balance<T0>) {
        assert_trade_cap_vault(arg0, arg1);
        put_balance<T0>(arg1, arg2);
    }

    fun remove_position_ref(arg0: &mut Vault, arg1: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PositionRef>(&arg0.position_refs)) {
            let v1 = *0x1::vector::borrow<PositionRef>(&arg0.position_refs, v0);
            if (v1.id == arg1) {
                0x1::vector::remove<PositionRef>(&mut arg0.position_refs, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 2
    }

    fun store_position<T0: store>(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: T0, arg3: u8) {
        0x2::bag::add<0x2::object::ID, T0>(&mut arg0.positions, arg1, arg2);
        let v0 = PositionRef{
            id       : arg1,
            protocol : arg3,
        };
        0x1::vector::push_back<PositionRef>(&mut arg0.position_refs, v0);
    }

    public fun store_position_with_admin_cap<T0: store>(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::object::ID, arg3: T0, arg4: u8, arg5: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg5);
        store_position<T0>(arg1, arg2, arg3, arg4);
    }

    public fun store_position_with_trade_cap<T0: store>(arg0: &TradeCap, arg1: &mut Vault, arg2: 0x2::object::ID, arg3: T0, arg4: u8) {
        assert_trade_cap_vault(arg0, arg1);
        store_position<T0>(arg1, arg2, arg3, arg4);
    }

    fun take_all_balance<T0>(arg0: &mut Vault) : 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::bag::remove<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public fun take_all_balance_with_admin_cap<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_admin(arg1, arg2);
        take_all_balance<T0>(arg1)
    }

    public fun take_all_balance_with_trade_cap<T0>(arg0: &TradeCap, arg1: &mut Vault) : 0x2::balance::Balance<T0> {
        assert_trade_cap_vault(arg0, arg1);
        take_all_balance<T0>(arg1)
    }

    fun take_balance<T0>(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(borrow_balance_mut<T0>(arg0), arg1)
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(take_balance<T0>(arg1, arg2), arg4), arg3);
    }

    public fun withdraw_with_trade_cap<T0>(arg0: &TradeCap, arg1: &mut Vault, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_trade_cap_vault(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(take_balance<T0>(arg1, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

