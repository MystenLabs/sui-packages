module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::liquidity_book {
    struct LiquidityBook has store, key {
        id: 0x2::object::UID,
        subscribed_vaults: 0x2::vec_set::VecSet<address>,
        max_slippage: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        protocol_fee_beneficiary: address,
        fee_models: vector<u64>,
        protocol_fee: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        positions_by_id: 0x2::table::Table<address, vector<LiquidityEntry>>,
    }

    struct LiquidityEntry has copy, drop, store {
        position_id: address,
        liquidity: u64,
        vault_id: address,
        assets: 0x2::vec_set::VecSet<u64>,
        asset: u64,
        fee: u64,
    }

    public fun swap<T0, T1>(arg0: &mut LiquidityBook, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg4: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg5: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>, arg6: vector<address>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::balance::zero<T1>();
        let v1 = 0x1::vector::empty<vector<LiquidityEntry>>();
        0x1::vector::reverse<address>(&mut arg6);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg6)) {
            let v3 = 0x1::vector::empty<LiquidityEntry>();
            let v4 = *0x2::table::borrow<address, vector<LiquidityEntry>>(&arg0.positions_by_id, 0x1::vector::pop_back<address>(&mut arg6));
            0x1::vector::reverse<LiquidityEntry>(&mut v4);
            let v5 = 0;
            while (v5 < 0x1::vector::length<LiquidityEntry>(&v4)) {
                let v6 = 0x1::vector::pop_back<LiquidityEntry>(&mut v4);
                let v7 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>>(arg5);
                if (v6.vault_id == 0x2::object::id_to_address(&v7)) {
                    0x1::vector::push_back<LiquidityEntry>(&mut v3, v6);
                };
                v5 = v5 + 1;
            };
            0x1::vector::destroy_empty<LiquidityEntry>(v4);
            0x1::vector::push_back<vector<LiquidityEntry>>(&mut v1, v3);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(arg6);
        let v8 = 0x1::vector::flatten<LiquidityEntry>(v1);
        let v9 = 0;
        0x1::vector::reverse<LiquidityEntry>(&mut v8);
        let v10 = 0;
        while (v10 < 0x1::vector::length<LiquidityEntry>(&v8)) {
            let v11 = 0x1::vector::pop_back<LiquidityEntry>(&mut v8);
            v9 = v9 + v11.liquidity;
            v10 = v10 + 1;
        };
        0x1::vector::destroy_empty<LiquidityEntry>(v8);
        let v12 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T0>(arg1));
        let v13 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T1>(arg1));
        let v14 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset<T1>(arg3, arg1, arg8);
        let v15 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset<T0>(arg3, arg1, arg8);
        let v16 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(v9, v13);
        let v17 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(0x2::coin::value<T0>(&arg7), v12);
        assert!(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::ge(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v16, v14), v15), v17), 13906835140711022591);
        let v18 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v17, v15), v14);
        let v19 = 0x2::coin::split<T0>(&mut arg7, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::round_u64(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v17, arg0.protocol_fee), v12), arg9);
        0x1::vector::reverse<LiquidityEntry>(&mut v8);
        let v20 = 0;
        while (v20 < 0x1::vector::length<LiquidityEntry>(&v8)) {
            let v21 = 0x1::vector::pop_back<LiquidityEntry>(&mut v8);
            let v22 = &mut v18;
            let v23 = &mut arg7;
            let v24 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::add(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_percentage(v21.fee), slippage_percentage(arg0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::total(arg2, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::lp_product(), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T0>(arg1)), v12), v15), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::total(arg2, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::lp_product(), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T1>(arg1)), v13), v14), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(0x2::coin::value<T0>(&arg7), v12), v15)));
            let v25 = use_liquidity_entry<T0, T1>(&v21, arg1, arg3, arg2, v12, v13, v16, v17, v22, v15, v14, arg4, arg5, v23, v24, arg8, arg9);
            0x2::balance::join<T1>(&mut v0, v25);
            v20 = v20 + 1;
        };
        0x1::vector::destroy_empty<LiquidityEntry>(v8);
        if (0x2::coin::value<T0>(&arg7) > 0) {
            0x2::coin::join<T0>(&mut v19, arg7);
        } else {
            0x2::coin::destroy_zero<T0>(arg7);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v19, arg0.protocol_fee_beneficiary);
        0x2::coin::from_balance<T1>(v0, arg9)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidityBook{
            id                       : 0x2::object::new(arg0),
            subscribed_vaults        : 0x2::vec_set::empty<address>(),
            max_slippage             : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_percentage(0),
            protocol_fee_beneficiary : @0x2702be11fe97d7c01e057ace8085dd2a6177dfcdc2e86ddedd4e7d9bc7e23a98,
            fee_models               : vector[1, 5, 30, 100],
            protocol_fee             : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_percentage(0),
            positions_by_id          : 0x2::table::new<address, vector<LiquidityEntry>>(arg0),
        };
        0x2::transfer::public_share_object<LiquidityBook>(v0);
    }

    public entry fun add_asset<T0>(arg0: &mut LiquidityBook, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::liquidity_position::LiquidityPosition) {
        let v0 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::liquidity_position::LiquidityPosition>(arg2);
        let v1 = 0x2::table::borrow_mut<address, vector<LiquidityEntry>>(&mut arg0.positions_by_id, 0x2::object::id_to_address(&v0));
        let v2 = 0;
        while (v2 < 0x1::vector::length<LiquidityEntry>(v1)) {
            0x2::vec_set::insert<u64>(&mut 0x1::vector::borrow_mut<LiquidityEntry>(v1, v2).assets, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T0>(arg1));
            v2 = v2 + 1;
        };
    }

    public fun add_fee_model(arg0: &mut LiquidityBook, arg1: u64, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap) {
        0x1::vector::push_back<u64>(&mut arg0.fee_models, arg1);
    }

    public fun add_liquidity<T0>(arg0: &mut LiquidityBook, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::liquidity_position::LiquidityPosition, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg4: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg5: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_fee_model(arg0, arg7);
        let v0 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>>(arg5);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(0x2::vec_set::contains<address>(&arg0.subscribed_vaults, &v1), 13906834509350830079);
        let v2 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::liquidity_position::LiquidityPosition>(arg1);
        let v3 = 0x2::object::id_to_address(&v2);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::deposit::complete<T0>(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::deposit::deposit<T0>(arg5, arg2, 0x2::coin::into_balance<T0>(arg6), arg4, arg8), arg2, arg3, arg5, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::zero(), v3, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::lp_product(), arg8, arg9);
        if (!0x2::table::contains<address, vector<LiquidityEntry>>(&arg0.positions_by_id, v3)) {
            0x2::table::add<address, vector<LiquidityEntry>>(&mut arg0.positions_by_id, v3, 0x1::vector::empty<LiquidityEntry>());
        };
        let v4 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>>(arg5);
        let v5 = LiquidityEntry{
            position_id : v3,
            liquidity   : 0x2::coin::value<T0>(&arg6),
            vault_id    : 0x2::object::id_to_address(&v4),
            assets      : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::liquidity_position::assets(arg1),
            asset       : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T0>(arg2),
            fee         : arg7,
        };
        0x1::vector::push_back<LiquidityEntry>(0x2::table::borrow_mut<address, vector<LiquidityEntry>>(&mut arg0.positions_by_id, v3), v5);
    }

    fun assert_fee_model(arg0: &LiquidityBook, arg1: u64) {
        assert!(0x1::vector::contains<u64>(&arg0.fee_models, &arg1), 1200);
    }

    public entry fun remove_asset<T0>(arg0: &mut LiquidityBook, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::liquidity_position::LiquidityPosition) {
        let v0 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::liquidity_position::LiquidityPosition>(arg2);
        let v1 = 0x2::table::borrow_mut<address, vector<LiquidityEntry>>(&mut arg0.positions_by_id, 0x2::object::id_to_address(&v0));
        let v2 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T0>(arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<LiquidityEntry>(v1)) {
            0x2::vec_set::remove<u64>(&mut 0x1::vector::borrow_mut<LiquidityEntry>(v1, v3).assets, &v2);
            v3 = v3 + 1;
        };
    }

    public fun remove_liquidity<T0>(arg0: &mut LiquidityBook, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::liquidity_position::LiquidityPosition, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg4: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>>(arg4);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(0x2::vec_set::contains<address>(&arg0.subscribed_vaults, &v1), 13906834848653246463);
        let v2 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::liquidity_position::LiquidityPosition>(arg1);
        let v3 = 0x2::object::id_to_address(&v2);
        let v4 = 0x2::table::borrow_mut<address, vector<LiquidityEntry>>(&mut arg0.positions_by_id, v3);
        let v5 = 0;
        let v6;
        while (v5 < 0x1::vector::length<LiquidityEntry>(v4)) {
            let v7 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>>(arg4);
            if (0x1::vector::borrow<LiquidityEntry>(v4, v5).vault_id == 0x2::object::id_to_address(&v7)) {
                v6 = 0x1::option::some<u64>(v5);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v6), 13906834874423050239);
                0x1::vector::remove<LiquidityEntry>(v4, *0x1::option::borrow<u64>(&v6));
                return 0x2::coin::from_balance<T0>(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::withdraw<T0>(arg4, arg2, arg3, v3, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(arg5, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T0>(arg2))), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::lp_product(), arg6, arg7), arg7)
            };
            v5 = v5 + 1;
        };
        v6 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun set_fee_beneficiary(arg0: &mut LiquidityBook, arg1: address, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap) {
        arg0.protocol_fee_beneficiary = arg1;
    }

    public fun set_protocol_fee(arg0: &mut LiquidityBook, arg1: u64, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap) {
        arg0.protocol_fee = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_percentage(arg1);
    }

    public fun set_slippage(arg0: &mut LiquidityBook, arg1: u64, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap) {
        arg0.max_slippage = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_percentage(arg1);
    }

    fun slippage_percentage(arg0: &LiquidityBook, arg1: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg2: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg3: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::add(arg1, arg3);
        let v1 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(arg2, arg3);
        if (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::lt(v1, v0)) {
            0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v0, v1), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::add(v0, v1)), arg0.max_slippage)
        } else {
            0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::zero()
        }
    }

    public fun subscribe_vault<T0>(arg0: &mut LiquidityBook, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap) {
        let v0 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>>(arg1);
        0x2::vec_set::insert<address>(&mut arg0.subscribed_vaults, 0x2::object::id_to_address(&v0));
    }

    public fun swap_to_repay_debt<T0, T1>(arg0: &mut LiquidityBook, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg4: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg5: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>, arg6: vector<address>, arg7: 0x2::coin::Coin<T0>, arg8: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::borrow::BorrowReceipt, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = if (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::borrow::amount(arg8) == 0x2::coin::value<T0>(&arg7)) {
            let v1 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>>(arg4);
            0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::borrow::vault_id(arg8) == 0x2::object::id_to_address(&v1)
        } else {
            false
        };
        assert!(v0, 1201);
        let v2 = 0x2::balance::zero<T1>();
        let v3 = 0x1::vector::empty<vector<LiquidityEntry>>();
        0x1::vector::reverse<address>(&mut arg6);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg6)) {
            let v5 = 0x1::vector::empty<LiquidityEntry>();
            let v6 = *0x2::table::borrow<address, vector<LiquidityEntry>>(&arg0.positions_by_id, 0x1::vector::pop_back<address>(&mut arg6));
            0x1::vector::reverse<LiquidityEntry>(&mut v6);
            let v7 = 0;
            while (v7 < 0x1::vector::length<LiquidityEntry>(&v6)) {
                let v8 = 0x1::vector::pop_back<LiquidityEntry>(&mut v6);
                let v9 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>>(arg5);
                if (v8.vault_id == 0x2::object::id_to_address(&v9)) {
                    0x1::vector::push_back<LiquidityEntry>(&mut v5, v8);
                };
                v7 = v7 + 1;
            };
            0x1::vector::destroy_empty<LiquidityEntry>(v6);
            0x1::vector::push_back<vector<LiquidityEntry>>(&mut v3, v5);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<address>(arg6);
        let v10 = 0x1::vector::flatten<LiquidityEntry>(v3);
        let v11 = 0;
        0x1::vector::reverse<LiquidityEntry>(&mut v10);
        let v12 = 0;
        while (v12 < 0x1::vector::length<LiquidityEntry>(&v10)) {
            let v13 = 0x1::vector::pop_back<LiquidityEntry>(&mut v10);
            v11 = v11 + v13.liquidity;
            v12 = v12 + 1;
        };
        0x1::vector::destroy_empty<LiquidityEntry>(v10);
        let v14 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T0>(arg1));
        let v15 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T1>(arg1));
        let v16 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset<T1>(arg3, arg1, arg9);
        let v17 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::get_price_by_asset<T0>(arg3, arg1, arg9);
        let v18 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(v11, v15);
        let v19 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(0x2::coin::value<T0>(&arg7), v14);
        assert!(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::ge(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul_div_trunc(v18, v16, v17), v19), 13906835462833569791);
        let v20 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v19, v17), v16);
        0x1::vector::reverse<LiquidityEntry>(&mut v10);
        let v21 = 0;
        while (v21 < 0x1::vector::length<LiquidityEntry>(&v10)) {
            let v22 = 0x1::vector::pop_back<LiquidityEntry>(&mut v10);
            let v23 = &mut v20;
            let v24 = &mut arg7;
            let v25 = use_liquidity_entry<T0, T1>(&v22, arg1, arg3, arg2, v14, v15, v18, v19, v23, v17, v16, arg4, arg5, v24, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::zero(), arg9, arg10);
            0x2::balance::join<T1>(&mut v2, v25);
            v21 = v21 + 1;
        };
        0x1::vector::destroy_empty<LiquidityEntry>(v10);
        let v26 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_u64(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::borrow::value(arg8), v16), v15);
        if (0x2::balance::value<T1>(&v2) < v26) {
            let v27 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(v26 - 0x2::balance::value<T1>(&v2), v15);
            let v28 = &v10;
            let v29 = 0;
            while (v29 < 0x1::vector::length<LiquidityEntry>(v28)) {
                if (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::ge(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::balance_amount<T1>(arg5, arg1, 0x1::vector::borrow<LiquidityEntry>(v28, v29).position_id), v27)) {
                    let v30 = 0x1::option::some<u64>(v29);
                    assert!(0x1::option::is_some<u64>(&v30), 13906835613157425151);
                    let v31 = 0x1::vector::borrow<LiquidityEntry>(&v10, *0x1::option::borrow<u64>(&v30));
                    0x2::balance::join<T1>(&mut v2, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::withdraw_with_round<T1>(arg5, arg1, arg2, v31.position_id, v27, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::lp_product(), arg9, arg10));
                    0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::deposit_product_balance<T0>(arg4, arg1, arg2, v31.position_id, 0x2::coin::into_balance<T0>(arg7), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::lp_product(), arg9, arg10);
                    /* goto 40 */
                } else {
                    /* goto 44 */
                };
            };
        } else if (0x2::coin::value<T0>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, arg0.protocol_fee_beneficiary);
        } else {
            0x2::coin::destroy_zero<T0>(arg7);
        };
        /* label 40 */
        assert!(0x2::balance::value<T1>(&v2) == v26, 1202);
        0x2::coin::from_balance<T1>(v2, arg10)
    }

    fun use_liquidity_entry<T0, T1>(arg0: &LiquidityEntry, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::price_registry::PriceRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg4: u8, arg5: u8, arg6: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg7: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg8: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg9: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg10: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg11: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T0>, arg12: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>, arg13: &mut 0x2::coin::Coin<T0>, arg14: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(arg7, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(arg0.liquidity, arg5), arg6));
        let v1 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v0, arg9), arg10);
        *arg8 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(*arg8, v1);
        let v2 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_u64(v0, arg4);
        let v3 = if (v2 <= 0x2::coin::value<T0>(arg13)) {
            0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg13, v2, arg16))
        } else {
            0x2::balance::withdraw_all<T0>(0x2::coin::balance_mut<T0>(arg13))
        };
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::deposit::complete<T0>(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::deposit::deposit<T0>(arg11, arg1, v3, arg2, arg15), arg1, arg3, arg11, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::zero(), arg0.position_id, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::lp_product(), arg15, arg16);
        0x2::coin::into_balance<T1>(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::withdraw::complete<T1>(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::withdraw::create_receipt<T1>(arg12, arg1, arg2, v1, arg0.position_id, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::lp_product(), arg14, arg15), arg1, arg3, arg12, arg15, arg16))
    }

    // decompiled from Move bytecode v6
}

