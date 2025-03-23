module 0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::scallop_vault {
    struct ScallopVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        scoin: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
        deposits_open: bool,
    }

    public fun admin_deposit<T0, T1>(arg0: &0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::AdminCap, arg1: &mut ScallopVault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::SessionFlow<T0, T1>, arg6: &0x2::clock::Clock, arg7: &0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::af_version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::af_version::assert_current_version(arg7);
        assert!(0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::is_move<T0, T1>(arg5), 9223373136366534659);
        assert!(!0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::can_consoom<T0, T1>(arg5), 9223373140661633029);
        assert!(deposits_open<T0, T1>(arg1), 9223373144956338177);
        deposit<T0, T1>(arg1, arg2, arg3, arg4, arg6, arg8);
        0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::events::scallop_vault_deposit(0x2::object::id_address<ScallopVault<T0, T1>>(arg1), 0x2::coin::value<T0>(&arg2));
        0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::allow_consoom<T0, T1>(&arg1.id, arg5);
    }

    public fun admin_withdraw<T0, T1>(arg0: &0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::AdminCap, arg1: &mut ScallopVault<T0, T1>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::af_version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::SessionFlow<T0, T1>, 0x2::coin::Coin<T0>) {
        0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::af_version::assert_current_version(arg6);
        let v0 = withdraw<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg7);
        0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::events::scallop_vault_withdraw(0x2::object::id_address<ScallopVault<T0, T1>>(arg1), 0x2::coin::value<T0>(&v0));
        (0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::create_session<T0, T1>(&arg1.id, 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::move_kind(), 0x2::coin::value<T0>(&v0)), v0)
    }

    public fun convert_coin_to_scoin(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats(arg0, arg1, arg2, arg3);
        let v4 = if (v3 > 0) {
            0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::scallop_math_u64::mul_div(arg4, v3, v0 + v1 - v2)
        } else {
            arg4
        };
        assert!(v4 > 0, 1);
        v4
    }

    public fun convert_scoin_to_coin(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats(arg0, arg1, arg2, arg3);
        0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::scallop_math_u64::mul_div(arg4, v0 + v1 - v2, v3)
    }

    public fun create_vault<T0, T1>(arg0: &0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopVault<T0, T1>{
            id            : 0x2::object::new(arg1),
            scoin         : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
            deposits_open : true,
        };
        0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::authorize(arg0, &mut v0.id);
        0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::events::scallop_vault_created<T0, T1>(0x2::object::id_address<ScallopVault<T0, T1>>(&v0));
        0x2::transfer::share_object<ScallopVault<T0, T1>>(v0);
    }

    fun deposit<T0, T1>(arg0: &mut ScallopVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deposits_open, 9223373424129212417);
        deposit_scoin<T0, T1>(arg0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg3, arg2, arg1, arg4, arg5));
        0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::events::scallop_vault_deposit(0x2::object::id_address<ScallopVault<T0, T1>>(arg0), 0x2::coin::value<T0>(&arg1));
    }

    fun deposit_scoin<T0, T1>(arg0: &mut ScallopVault<T0, T1>, arg1: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>) {
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.scoin, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1));
    }

    public fun deposits_open<T0, T1>(arg0: &ScallopVault<T0, T1>) : bool {
        arg0.deposits_open
    }

    public fun get_reserve_stats(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg0, arg1, arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::af_version::create_version(arg0);
    }

    public fun public_deposit<T0, T1>(arg0: &mut ScallopVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::af_version::Version, arg7: &mut 0x2::tx_context::TxContext) : 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::SessionFlow<T0, T1> {
        0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::af_version::assert_current_version(arg6);
        assert!(deposits_open<T0, T1>(arg0), 9223372277372944385);
        let v0 = 0x2::coin::value<T0>(&arg1);
        deposit<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg7);
        0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::events::scallop_vault_deposit(0x2::object::id_address<ScallopVault<T0, T1>>(arg0), v0);
        let v1 = 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::create_session<T0, T1>(&arg0.id, 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::deposit_kind(), v0);
        if (arg4) {
            0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::allow_consoom<T0, T1>(&arg0.id, &mut v1);
        };
        v1
    }

    public fun public_withdraw<T0, T1>(arg0: &mut ScallopVault<T0, T1>, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::SessionFlow<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::af_version::Version, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::af_version::assert_current_version(arg5);
        assert!(0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::is_withdrawal<T0, T1>(arg3), 9223372457761701891);
        assert!(!0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::can_consoom<T0, T1>(arg3), 9223372462056800261);
        let v0 = withdraw<T0, T1>(arg0, arg1, arg2, 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::value<T0, T1>(arg3), arg4, arg6);
        0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::allow_consoom<T0, T1>(&arg0.id, arg3);
        0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::events::scallop_vault_withdraw(0x2::object::id_address<ScallopVault<T0, T1>>(arg0), 0x2::coin::value<T0>(&v0));
        v0
    }

    public fun scoin_type<T0, T1>(arg0: &ScallopVault<T0, T1>) : 0x1::type_name::TypeName {
        0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>()
    }

    public fun toggle_deposits<T0, T1>(arg0: &0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::AdminCap, arg1: &mut ScallopVault<T0, T1>, arg2: bool) {
        arg1.deposits_open = arg2;
    }

    public fun total_assets<T0, T1>(arg0: &ScallopVault<T0, T1>, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &0x2::clock::Clock) : u64 {
        convert_scoin_to_coin(arg2, arg1, 0x1::type_name::get<T0>(), arg3, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.scoin))
    }

    public fun total_scoin<T0, T1>(arg0: &ScallopVault<T0, T1>) : u64 {
        0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.scoin)
    }

    fun withdraw<T0, T1>(arg0: &mut ScallopVault<T0, T1>, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = convert_coin_to_scoin(arg2, arg1, 0x1::type_name::get<T0>(), arg4, arg3);
        let v1 = withdraw_scoin<T0, T1>(arg0, v0, arg5);
        0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::events::scallop_vault_withdraw(0x2::object::id_address<ScallopVault<T0, T1>>(arg0), arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg1, v1, arg4, arg5)
    }

    fun withdraw_scoin<T0, T1>(arg0: &mut ScallopVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.scoin, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

