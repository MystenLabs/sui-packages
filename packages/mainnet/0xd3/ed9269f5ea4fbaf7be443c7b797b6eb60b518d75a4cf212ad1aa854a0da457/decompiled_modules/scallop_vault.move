module 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::scallop_vault {
    struct ScallopVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        scoin: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
        deposits_open: bool,
    }

    public fun convert_coin_to_scoin(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats(arg0, arg1, arg2, arg3);
        let v4 = if (v3 > 0) {
            0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::scallop_math_u64::mul_div(arg4, v3, v0 + v1 - v2)
        } else {
            arg4
        };
        assert!(v4 > 0, 1);
        v4
    }

    public fun convert_scoin_to_coin(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats(arg0, arg1, arg2, arg3);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::scallop_math_u64::mul_div(arg4, v0 + v1 - v2, v3)
    }

    public(friend) fun create_vault<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopVault<T0, T1>{
            id            : 0x2::object::new(arg0),
            scoin         : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
            deposits_open : true,
        };
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::events::scallop_vault_created(0x2::object::id_address<ScallopVault<T0, T1>>(&v0), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), 0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>());
        0x2::transfer::share_object<ScallopVault<T0, T1>>(v0);
    }

    public(friend) fun deposit_scoin<T0, T1>(arg0: &mut ScallopVault<T0, T1>, arg1: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>) {
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.scoin, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1));
    }

    public fun deposits_open<T0, T1>(arg0: &ScallopVault<T0, T1>) : bool {
        arg0.deposits_open
    }

    public fun get_reserve_stats(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg0, arg1, arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), arg2))
    }

    public fun scoin_type<T0, T1>(arg0: &ScallopVault<T0, T1>) : 0x1::type_name::TypeName {
        0x1::type_name::get<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>()
    }

    public(friend) fun toggle_deposits<T0, T1>(arg0: &mut ScallopVault<T0, T1>, arg1: bool) {
        arg0.deposits_open = arg1;
    }

    public(friend) fun total_assets<T0, T1>(arg0: &ScallopVault<T0, T1>, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &0x2::clock::Clock) : u64 {
        convert_scoin_to_coin(arg2, arg1, 0x1::type_name::get<T0>(), arg3, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.scoin))
    }

    public fun total_scoin<T0, T1>(arg0: &ScallopVault<T0, T1>) : u64 {
        0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.scoin)
    }

    public fun withdraw_scoin<T0, T1>(arg0: &mut ScallopVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.scoin, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

