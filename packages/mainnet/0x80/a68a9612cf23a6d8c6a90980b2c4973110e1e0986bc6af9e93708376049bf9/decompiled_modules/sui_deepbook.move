module 0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_deepbook {
    struct AssetVault<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
        asset_type: 0x1::type_name::TypeName,
        total_deposited: u64,
        total_withdrawn: u64,
    }

    struct SwapAuthorization has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        input_amount: u64,
        min_output: u64,
        is_buy: bool,
        expires_at: u64,
        used: bool,
    }

    struct TradingObligation {
        vault_id: 0x2::object::ID,
        amount_extracted: u64,
    }

    struct AssetVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        asset_vault_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
    }

    struct SwapAuthorized has copy, drop {
        vault_id: 0x2::object::ID,
        authorization_id: 0x2::object::ID,
        input_amount: u64,
        min_output: u64,
        is_buy: bool,
    }

    struct SwapExecuted has copy, drop {
        vault_id: 0x2::object::ID,
        input_amount: u64,
        output_amount: u64,
        is_buy: bool,
    }

    struct AssetDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct AssetWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun asset_balance<T0>(arg0: &AssetVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun asset_type<T0>(arg0: &AssetVault<T0>) : 0x1::type_name::TypeName {
        arg0.asset_type
    }

    public fun asset_vault_id<T0>(arg0: &AssetVault<T0>) : 0x2::object::ID {
        0x2::object::id<AssetVault<T0>>(arg0)
    }

    public fun asset_vault_vault_id<T0>(arg0: &AssetVault<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun authorize_swap<T0>(arg0: &0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiVault<T0>, arg1: &0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiLeaderCap, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : SwapAuthorization {
        assert!(0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::leader_cap_vault_id(arg1) == 0x2::object::id<0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiVault<T0>>(arg0), 1);
        assert!(arg2 > 0, 3);
        let v0 = 0x2::object::id<0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiVault<T0>>(arg0);
        let v1 = SwapAuthorization{
            id           : 0x2::object::new(arg7),
            vault_id     : v0,
            input_amount : arg2,
            min_output   : arg3,
            is_buy       : arg4,
            expires_at   : 0x2::clock::timestamp_ms(arg6) / 1000 + arg5,
            used         : false,
        };
        let v2 = SwapAuthorized{
            vault_id         : v0,
            authorization_id : 0x2::object::id<SwapAuthorization>(&v1),
            input_amount     : arg2,
            min_output       : arg3,
            is_buy           : arg4,
        };
        0x2::event::emit<SwapAuthorized>(v2);
        v1
    }

    public fun calculate_asset_value_usdc<T0>(arg0: &AssetVault<T0>, arg1: u64, arg2: u8) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 == 0) {
            return 0
        };
        (((v0 as u128) * (arg1 as u128) / (pow10(arg2) as u128)) as u64)
    }

    public fun consume_swap_for_buy<T0>(arg0: SwapAuthorization, arg1: &mut 0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiVault<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, TradingObligation) {
        let SwapAuthorization {
            id           : v0,
            vault_id     : v1,
            input_amount : v2,
            min_output   : _,
            is_buy       : v4,
            expires_at   : v5,
            used         : v6,
        } = arg0;
        assert!(!v6, 7);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 < v5, 4);
        assert!(v1 == 0x2::object::id<0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiVault<T0>>(arg1), 1);
        assert!(v4, 3);
        0x2::object::delete(v0);
        let v7 = TradingObligation{
            vault_id         : v1,
            amount_extracted : v2,
        };
        (0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::extract_usdc_for_trading<T0>(arg1, v2, arg3), v7)
    }

    public fun consume_swap_for_sell<T0>(arg0: SwapAuthorization, arg1: &mut AssetVault<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, TradingObligation) {
        let SwapAuthorization {
            id           : v0,
            vault_id     : v1,
            input_amount : v2,
            min_output   : _,
            is_buy       : v4,
            expires_at   : v5,
            used         : v6,
        } = arg0;
        assert!(!v6, 7);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 < v5, 4);
        assert!(v1 == arg1.vault_id, 1);
        assert!(!v4, 3);
        assert!(arg2 <= v2, 3);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 2);
        0x2::object::delete(v0);
        arg1.total_withdrawn = arg1.total_withdrawn + arg2;
        let v7 = AssetWithdrawn{
            vault_id   : arg1.vault_id,
            asset_type : arg1.asset_type,
            amount     : arg2,
        };
        0x2::event::emit<AssetWithdrawn>(v7);
        let v8 = TradingObligation{
            vault_id         : v1,
            amount_extracted : arg2,
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), v8)
    }

    public fun create_asset_vault<T0, T1>(arg0: &0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiVault<T0>, arg1: &0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiLeaderCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::leader_cap_vault_id(arg1) == 0x2::object::id<0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiVault<T0>>(arg0), 1);
        let v0 = 0x2::object::id<0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiVault<T0>>(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = AssetVault<T1>{
            id              : 0x2::object::new(arg2),
            vault_id        : v0,
            balance         : 0x2::balance::zero<T1>(),
            asset_type      : v1,
            total_deposited : 0,
            total_withdrawn : 0,
        };
        let v3 = AssetVaultCreated{
            vault_id       : v0,
            asset_vault_id : 0x2::object::id<AssetVault<T1>>(&v2),
            asset_type     : v1,
        };
        0x2::event::emit<AssetVaultCreated>(v3);
        0x2::transfer::share_object<AssetVault<T1>>(v2);
    }

    public fun deposit_swap_output<T0>(arg0: &mut AssetVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2, 5);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_deposited = arg0.total_deposited + v0;
        let v1 = AssetDeposited{
            vault_id   : arg0.vault_id,
            asset_type : arg0.asset_type,
            amount     : v0,
        };
        0x2::event::emit<AssetDeposited>(v1);
    }

    public fun deposit_usdc_from_sell<T0>(arg0: &mut 0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2, 5);
        0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::deposit_usdc_from_trading<T0>(arg0, arg1);
        let v1 = SwapExecuted{
            vault_id      : 0x2::object::id<0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiVault<T0>>(arg0),
            input_amount  : 0,
            output_amount : v0,
            is_buy        : false,
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    fun pow10(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun repay_obligation_with_base<T0>(arg0: TradingObligation, arg1: &mut AssetVault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64) {
        let TradingObligation {
            vault_id         : v0,
            amount_extracted : _,
        } = arg0;
        assert!(arg1.vault_id == v0, 1);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 >= arg3, 5);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
        arg1.total_deposited = arg1.total_deposited + v2;
        let v3 = AssetDeposited{
            vault_id   : v0,
            asset_type : arg1.asset_type,
            amount     : v2,
        };
        0x2::event::emit<AssetDeposited>(v3);
    }

    public fun repay_obligation_with_usdc<T0>(arg0: TradingObligation, arg1: &mut 0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiVault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64) {
        let TradingObligation {
            vault_id         : v0,
            amount_extracted : _,
        } = arg0;
        assert!(v0 == 0x2::object::id<0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::SuiVault<T0>>(arg1), 1);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 >= arg3, 5);
        0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_vault::deposit_usdc_from_trading<T0>(arg1, arg2);
        let v3 = SwapExecuted{
            vault_id      : v0,
            input_amount  : 0,
            output_amount : v2,
            is_buy        : false,
        };
        0x2::event::emit<SwapExecuted>(v3);
    }

    public fun total_deposited<T0>(arg0: &AssetVault<T0>) : u64 {
        arg0.total_deposited
    }

    public fun total_withdrawn<T0>(arg0: &AssetVault<T0>) : u64 {
        arg0.total_withdrawn
    }

    // decompiled from Move bytecode v6
}

