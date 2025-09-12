module 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::maker_vault {
    struct MakerVaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MakerOrderCap has store, key {
        id: 0x2::object::UID,
    }

    struct MakerVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        makers: 0x2::table::Table<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>,
        minimum_stake_amount: u64,
        custom_min_stake_amounts: 0x2::table::Table<0x1::string::String, u64>,
        collateral_balance: 0x2::balance::Balance<T0>,
        ithaca_balance: 0x2::balance::Balance<T1>,
    }

    struct MakerSymbolKey has copy, drop, store {
        maker: address,
        symbol: 0x1::string::String,
    }

    struct MakerRegistered has copy, drop {
        maker: address,
        stake_amount: u64,
    }

    struct MakerUnregistered has copy, drop {
        maker: address,
    }

    struct CollateralDeposited has copy, drop {
        maker: address,
        symbol: 0x1::string::String,
        amount: u64,
    }

    struct CollateralWithdrawn has copy, drop {
        maker: address,
        symbol: 0x1::string::String,
        amount: u64,
    }

    struct MinimumStakeAmountSet has copy, drop {
        amount: u64,
    }

    struct CustomMinStakeAmountSet has copy, drop {
        symbol: 0x1::string::String,
        amount: u64,
    }

    public(friend) fun add_funds<T0, T1>(arg0: &MakerOrderCap, arg1: &mut MakerVault<T0, T1>, arg2: 0x2::coin::Coin<T0>) {
        assert!(arg1.version == 1, 13906836029770366994);
        0x2::balance::join<T0>(&mut arg1.collateral_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public(friend) fun adjust_maker_balance<T0, T1>(arg0: &MakerOrderCap, arg1: &mut MakerVault<T0, T1>, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: bool) {
        assert!(arg1.version == 1, 13906835806432067602);
        let v0 = MakerSymbolKey{
            maker  : arg2,
            symbol : arg3,
        };
        assert!(0x2::table::contains<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&arg1.makers, v0), 13906835832201216008);
        if (arg5) {
            0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::add_maker_collateral(0x2::table::borrow_mut<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&mut arg1.makers, v0), arg4);
        } else {
            0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::subtract_maker_collateral(0x2::table::borrow_mut<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&mut arg1.makers, v0), arg4);
        };
    }

    public fun deposit_collateral<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906835218021548050);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = MakerSymbolKey{
            maker  : v0,
            symbol : arg1,
        };
        assert!(v1 > 0, 13906835256675205122);
        assert!(0x2::table::contains<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&arg0.makers, v2), 13906835260970565640);
        0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::add_maker_collateral(0x2::table::borrow_mut<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&mut arg0.makers, v2), v1);
        0x2::balance::join<T0>(&mut arg0.collateral_balance, 0x2::coin::into_balance<T0>(arg2));
        let v3 = CollateralDeposited{
            maker  : v0,
            symbol : arg1,
            amount : v1,
        };
        0x2::event::emit<CollateralDeposited>(v3);
    }

    public fun get_maker_collateral<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: address, arg2: 0x1::string::String) : u64 {
        let v0 = MakerSymbolKey{
            maker  : arg1,
            symbol : arg2,
        };
        if (0x2::table::contains<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&arg0.makers, v0)) {
            0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::maker_info_collateral(0x2::table::borrow<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&arg0.makers, v0))
        } else {
            0
        }
    }

    public fun get_maker_staked_ithaca<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: address, arg2: 0x1::string::String) : u64 {
        let v0 = MakerSymbolKey{
            maker  : arg1,
            symbol : arg2,
        };
        if (0x2::table::contains<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&arg0.makers, v0)) {
            0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::maker_info_staked_tokens(0x2::table::borrow<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&arg0.makers, v0))
        } else {
            0
        }
    }

    public fun get_min_stake_amount<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.custom_min_stake_amounts, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.custom_min_stake_amounts, arg1)
        } else {
            arg0.minimum_stake_amount
        }
    }

    public fun get_withdrawable_balance_with_locked<T0, T1>(arg0: &MakerOrderCap, arg1: &MakerVault<T0, T1>, arg2: address, arg3: 0x1::string::String, arg4: u64) : u64 {
        assert!(arg1.version == 1, 13906836253108666386);
        let v0 = get_maker_collateral<T0, T1>(arg1, arg2, arg3);
        if (v0 >= arg4) {
            v0 - arg4
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MakerVaultAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MakerVaultAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize<T0, T1>(arg0: &MakerVaultAdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MakerOrderCap {
        assert!(arg1 > 0, 13906834784228802562);
        let v0 = MakerOrderCap{id: 0x2::object::new(arg2)};
        let v1 = MakerVault<T0, T1>{
            id                       : 0x2::object::new(arg2),
            version                  : 1,
            admin                    : 0x2::object::id<MakerVaultAdminCap>(arg0),
            makers                   : 0x2::table::new<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(arg2),
            minimum_stake_amount     : arg1,
            custom_min_stake_amounts : 0x2::table::new<0x1::string::String, u64>(arg2),
            collateral_balance       : 0x2::balance::zero<T0>(),
            ithaca_balance           : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<MakerVault<T0, T1>>(v1);
        v0
    }

    entry fun migrate<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &MakerVaultAdminCap) {
        assert!(arg0.admin == 0x2::object::id<MakerVaultAdminCap>(arg1), 13906835535848865806);
        assert!(arg0.version < 1, 13906835540143964176);
        arg0.version = 1;
    }

    public fun minimum_stake_amount<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        arg0.minimum_stake_amount
    }

    public fun register_maker_symbol<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906834908783902738);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = MakerSymbolKey{
            maker  : v0,
            symbol : arg1,
        };
        assert!(v1 > 0, 13906834951732527106);
        assert!(!0x2::table::contains<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&arg0.makers, v2), 13906834956027756550);
        assert!(v1 >= get_min_stake_amount<T0, T1>(arg0, arg1), 13906834968912527364);
        0x2::table::add<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&mut arg0.makers, v2, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::new_maker_info(v1));
        0x2::balance::join<T1>(&mut arg0.ithaca_balance, 0x2::coin::into_balance<T1>(arg2));
        let v3 = MakerRegistered{
            maker        : v0,
            stake_amount : v1,
        };
        0x2::event::emit<MakerRegistered>(v3);
    }

    public fun set_custom_min_stake_amount<T0, T1>(arg0: &MakerVaultAdminCap, arg1: &mut MakerVault<T0, T1>, arg2: 0x1::string::String, arg3: u64) {
        assert!(arg1.version == 1, 13906835647518277650);
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.custom_min_stake_amounts, arg2)) {
            0x2::table::remove<0x1::string::String, u64>(&mut arg1.custom_min_stake_amounts, arg2);
        };
        0x2::table::add<0x1::string::String, u64>(&mut arg1.custom_min_stake_amounts, arg2, arg3);
        let v0 = CustomMinStakeAmountSet{
            symbol : arg2,
            amount : arg3,
        };
        0x2::event::emit<CustomMinStakeAmountSet>(v0);
    }

    public fun set_minimum_stake_amount<T0, T1>(arg0: &MakerVaultAdminCap, arg1: &mut MakerVault<T0, T1>, arg2: u64) {
        assert!(arg1.version == 1, 13906835583093768210);
        arg1.minimum_stake_amount = arg2;
        let v0 = MinimumStakeAmountSet{amount: arg2};
        0x2::event::emit<MinimumStakeAmountSet>(v0);
    }

    public fun total_asset_available<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral_balance)
    }

    public(friend) fun transfer_fee_to_treasury<T0, T1>(arg0: &MakerOrderCap, arg1: &mut MakerVault<T0, T1>, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.version == 1, 13906835926691151890);
        let v0 = MakerSymbolKey{
            maker  : arg2,
            symbol : arg3,
        };
        assert!(0x2::table::contains<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&arg1.makers, v0), 13906835952460300296);
        0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::subtract_maker_collateral(0x2::table::borrow_mut<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&mut arg1.makers, v0), arg4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collateral_balance, arg4), arg5)
    }

    public(friend) fun transfer_to_taker_vault<T0, T1>(arg0: &MakerOrderCap, arg1: &mut MakerVault<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.version == 1, 13906835746302525458);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collateral_balance, arg2), arg3)
    }

    public fun unregister_maker<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.version == 1, 13906835067697692690);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = MakerSymbolKey{
            maker  : v0,
            symbol : arg1,
        };
        assert!(0x2::table::contains<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&arg0.makers, v1), 13906835097761808392);
        let v2 = 0x2::table::remove<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&mut arg0.makers, v1);
        assert!(0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::maker_info_collateral(&v2) == 0, 13906835119236907020);
        let v3 = MakerUnregistered{maker: v0};
        0x2::event::emit<MakerUnregistered>(v3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.ithaca_balance, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::maker_info_staked_tokens(&v2)), arg2)
    }

    public fun vault_ithaca_balance_value<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.ithaca_balance)
    }

    public fun withdraw_collateral<T0, T1>(arg0: &MakerOrderCap, arg1: &mut MakerVault<T0, T1>, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.version == 1, 13906835385525272594);
        assert!(arg5 > 0, 13906835389819191298);
        let v0 = MakerSymbolKey{
            maker  : arg2,
            symbol : arg3,
        };
        assert!(0x2::table::contains<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&arg1.makers, v0), 13906835415589388296);
        assert!(arg5 <= get_withdrawable_balance_with_locked<T0, T1>(arg0, arg1, arg2, arg3, arg4), 13906835428474421258);
        0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::subtract_maker_collateral(0x2::table::borrow_mut<MakerSymbolKey, 0xf13ff4f6a99bc863c021afbe86d07de8e410bcfa0ef5bb4d89415e21fdb9a94e::types::MakerInfo>(&mut arg1.makers, v0), arg5);
        let v1 = CollateralWithdrawn{
            maker  : arg2,
            symbol : arg3,
            amount : arg5,
        };
        0x2::event::emit<CollateralWithdrawn>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collateral_balance, arg5), arg6)
    }

    // decompiled from Move bytecode v6
}

