module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::liquidity_position {
    struct LiquidityPosition has store, key {
        id: 0x2::object::UID,
        assets: 0x2::vec_set::VecSet<u64>,
    }

    public(friend) fun delete(arg0: LiquidityPosition) {
        let LiquidityPosition {
            id     : v0,
            assets : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun new(arg0: vector<u64>, arg1: &mut 0x2::tx_context::TxContext) : LiquidityPosition {
        LiquidityPosition{
            id     : 0x2::object::new(arg1),
            assets : 0x2::vec_set::from_keys<u64>(arg0),
        }
    }

    public(friend) fun add_asset<T0>(arg0: &mut LiquidityPosition, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry) : u64 {
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T0>(arg1);
        0x2::vec_set::insert<u64>(&mut arg0.assets, v0);
        v0
    }

    public(friend) fun assets(arg0: &LiquidityPosition) : 0x2::vec_set::VecSet<u64> {
        arg0.assets
    }

    public(friend) fun remove_asset<T0>(arg0: &mut LiquidityPosition, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry) : u64 {
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T0>(arg1);
        0x2::vec_set::remove<u64>(&mut arg0.assets, &v0);
        v0
    }

    public fun withdraw_fees<T0>(arg0: &LiquidityPosition, arg1: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::id<LiquidityPosition>(arg0);
        0x2::coin::from_balance<T0>(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::withdraw_fee<T0>(arg1, arg2, arg3, 0x2::object::id_to_address(&v0), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::lp_product(), arg4, arg5), arg5)
    }

    // decompiled from Move bytecode v6
}

