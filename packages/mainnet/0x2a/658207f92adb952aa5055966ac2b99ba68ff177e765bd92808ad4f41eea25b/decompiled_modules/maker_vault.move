module 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::maker_vault {
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
        makers: 0x2::table::Table<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>,
        minimum_stake_amount: u64,
        custom_min_stake_amounts: 0x2::table::Table<0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset, u64>,
        collateral_balance: 0x2::balance::Balance<T0>,
        ithaca_balance: 0x2::balance::Balance<T1>,
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
        tradable_asset: 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset,
        amount: u64,
    }

    struct CollateralWithdrawn has copy, drop {
        maker: address,
        tradable_asset: 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset,
        amount: u64,
    }

    struct IthacaStaked has copy, drop {
        maker: address,
        amount: u64,
    }

    struct MinimumStakeAmountSet has copy, drop {
        amount: u64,
    }

    struct CustomMinStakeAmountSet has copy, drop {
        tradable_asset: 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset,
        amount: u64,
    }

    public fun add_funds<T0, T1>(arg0: &MakerOrderCap, arg1: &mut MakerVault<T0, T1>, arg2: 0x2::coin::Coin<T0>) {
        assert!(arg1.version == 1, 13906836038360301586);
        0x2::balance::join<T0>(&mut arg1.collateral_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun adjust_maker_balance<T0, T1>(arg0: &MakerOrderCap, arg1: &mut MakerVault<T0, T1>, arg2: address, arg3: 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset, arg4: u64, arg5: bool) {
        assert!(arg1.version == 1, 13906835857971675154);
        assert!(0x2::table::contains<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg1.makers, arg2), 13906835862265987080);
        if (arg5) {
            0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::add_maker_collateral(0x2::table::borrow_mut<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&mut arg1.makers, arg2), &arg3, arg4);
        } else {
            0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::subtract_maker_collateral(0x2::table::borrow_mut<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&mut arg1.makers, arg2), &arg3, arg4);
        };
    }

    public fun can_deposit_collateral<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: address, arg2: &0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset) : bool {
        if (0x2::table::contains<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg0.makers, arg1)) {
            let v1 = 0x2::table::borrow<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg0.makers, arg1);
            let v2 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_staked_tokens(v1);
            let v3 = v2;
            if (0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_collateral(v1, arg2) > 0) {
                true
            } else {
                let v4 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_btc();
                let v5 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_eth();
                let v6 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_sol();
                let v7 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_xau();
                let v8 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_mstr();
                if (0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_collateral(v1, &v4) > 0) {
                    let v9 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_btc();
                    v3 = v2 - get_min_stake_amount<T0, T1>(arg0, &v9);
                };
                if (0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_collateral(v1, &v5) > 0) {
                    let v10 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_eth();
                    v3 = v3 - get_min_stake_amount<T0, T1>(arg0, &v10);
                };
                if (0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_collateral(v1, &v6) > 0) {
                    let v11 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_sol();
                    v3 = v3 - get_min_stake_amount<T0, T1>(arg0, &v11);
                };
                if (0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_collateral(v1, &v7) > 0) {
                    let v12 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_xau();
                    v3 = v3 - get_min_stake_amount<T0, T1>(arg0, &v12);
                };
                if (0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_collateral(v1, &v8) > 0) {
                    let v13 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_mstr();
                    v3 = v3 - get_min_stake_amount<T0, T1>(arg0, &v13);
                };
                v3 >= get_min_stake_amount<T0, T1>(arg0, arg2)
            }
        } else {
            false
        }
    }

    public fun deposit_collateral<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906835175071875090);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 13906835196545662978);
        assert!(0x2::table::contains<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg0.makers, v0), 13906835200841023496);
        assert!(can_deposit_collateral<T0, T1>(arg0, v0, &arg1), 13906835213725663236);
        0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::add_maker_collateral(0x2::table::borrow_mut<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&mut arg0.makers, v0), &arg1, v1);
        0x2::balance::join<T0>(&mut arg0.collateral_balance, 0x2::coin::into_balance<T0>(arg2));
        let v2 = CollateralDeposited{
            maker          : v0,
            tradable_asset : arg1,
            amount         : v1,
        };
        0x2::event::emit<CollateralDeposited>(v2);
    }

    public fun get_maker_collateral<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: address, arg2: &0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset) : u64 {
        if (0x2::table::contains<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg0.makers, arg1)) {
            0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_collateral(0x2::table::borrow<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg0.makers, arg1), arg2)
        } else {
            0
        }
    }

    public fun get_maker_collaterals<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: address) : 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo {
        if (0x2::table::contains<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg0.makers, arg1)) {
            *0x2::table::borrow<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg0.makers, arg1)
        } else {
            0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::new_maker_info(0)
        }
    }

    public fun get_maker_info<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg0.makers, arg1)) {
            0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_staked_tokens(0x2::table::borrow<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg0.makers, arg1))
        } else {
            0
        }
    }

    public fun get_min_stake_amount<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset) : u64 {
        if (0x2::table::contains<0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset, u64>(&arg0.custom_min_stake_amounts, *arg1)) {
            *0x2::table::borrow<0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset, u64>(&arg0.custom_min_stake_amounts, *arg1)
        } else {
            arg0.minimum_stake_amount
        }
    }

    public fun get_withdrawable_balance_with_locked<T0, T1>(arg0: &MakerOrderCap, arg1: &MakerVault<T0, T1>, arg2: address, arg3: &0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset, arg4: u64) : u64 {
        assert!(arg1.version == 1, 13906836502216769554);
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
        assert!(arg1 > 0, 13906834775638867970);
        let v0 = MakerOrderCap{id: 0x2::object::new(arg2)};
        let v1 = MakerVault<T0, T1>{
            id                       : 0x2::object::new(arg2),
            version                  : 1,
            admin                    : 0x2::object::id<MakerVaultAdminCap>(arg0),
            makers                   : 0x2::table::new<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(arg2),
            minimum_stake_amount     : arg1,
            custom_min_stake_amounts : 0x2::table::new<0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset, u64>(arg2),
            collateral_balance       : 0x2::balance::zero<T0>(),
            ithaca_balance           : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<MakerVault<T0, T1>>(v1);
        v0
    }

    entry fun migrate<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &MakerVaultAdminCap) {
        assert!(arg0.admin == 0x2::object::id<MakerVaultAdminCap>(arg1), 13906835587388473358);
        assert!(arg0.version < 1, 13906835591683571728);
        arg0.version = 1;
    }

    public fun minimum_stake_amount<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        arg0.minimum_stake_amount
    }

    public fun register_maker<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906834895899000850);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v1 > 0, 13906834917372788738);
        assert!(!0x2::table::contains<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg0.makers, v0), 13906834921668018182);
        assert!(v1 >= arg0.minimum_stake_amount, 13906834925962854404);
        0x2::table::add<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&mut arg0.makers, v0, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::new_maker_info(v1));
        0x2::balance::join<T1>(&mut arg0.ithaca_balance, 0x2::coin::into_balance<T1>(arg1));
        let v2 = MakerRegistered{
            maker        : v0,
            stake_amount : v1,
        };
        0x2::event::emit<MakerRegistered>(v2);
    }

    public fun set_custom_min_stake_amount<T0, T1>(arg0: &MakerVaultAdminCap, arg1: &mut MakerVault<T0, T1>, arg2: 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset, arg3: u64) {
        assert!(arg1.version == 1, 13906835699057885202);
        if (0x2::table::contains<0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset, u64>(&arg1.custom_min_stake_amounts, arg2)) {
            0x2::table::remove<0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset, u64>(&mut arg1.custom_min_stake_amounts, arg2);
        };
        0x2::table::add<0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset, u64>(&mut arg1.custom_min_stake_amounts, arg2, arg3);
        let v0 = CustomMinStakeAmountSet{
            tradable_asset : arg2,
            amount         : arg3,
        };
        0x2::event::emit<CustomMinStakeAmountSet>(v0);
    }

    public fun set_minimum_stake_amount<T0, T1>(arg0: &MakerVaultAdminCap, arg1: &mut MakerVault<T0, T1>, arg2: u64) {
        assert!(arg1.version == 1, 13906835634633375762);
        arg1.minimum_stake_amount = arg2;
        let v0 = MinimumStakeAmountSet{amount: arg2};
        0x2::event::emit<MinimumStakeAmountSet>(v0);
    }

    public fun stake_ithaca<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906835475719585810);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v1 > 0, 13906835497193373698);
        assert!(0x2::table::contains<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg0.makers, v0), 13906835501488734216);
        0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::add_staked_tokens(0x2::table::borrow_mut<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&mut arg0.makers, v0), v1);
        0x2::balance::join<T1>(&mut arg0.ithaca_balance, 0x2::coin::into_balance<T1>(arg1));
        let v2 = IthacaStaked{
            maker  : v0,
            amount : v1,
        };
        0x2::event::emit<IthacaStaked>(v2);
    }

    public fun total_asset_available<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral_balance)
    }

    public fun transfer_fee_to_treasury<T0, T1>(arg0: &MakerOrderCap, arg1: &mut MakerVault<T0, T1>, arg2: address, arg3: 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.version == 1, 13906835956755922962);
        assert!(0x2::table::contains<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg1.makers, arg2), 13906835961050234888);
        0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::subtract_maker_collateral(0x2::table::borrow_mut<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&mut arg1.makers, arg2), &arg3, arg4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collateral_balance, arg4), arg5)
    }

    public fun transfer_to_taker_vault<T0, T1>(arg0: &MakerOrderCap, arg1: &mut MakerVault<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.version == 1, 13906835797842133010);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collateral_balance, arg2), arg3)
    }

    public fun unregister_maker<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.version == 1, 13906835020453052434);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg0.makers, v0), 13906835037632266248);
        let v1 = 0x2::table::remove<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&mut arg0.makers, v0);
        let v2 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_btc();
        assert!(0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_collateral(&v1, &v2) == 0, 13906835059107364876);
        let v3 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_eth();
        assert!(0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_collateral(&v1, &v3) == 0, 13906835063402332172);
        let v4 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_sol();
        assert!(0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_collateral(&v1, &v4) == 0, 13906835067697299468);
        let v5 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_xau();
        assert!(0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_collateral(&v1, &v5) == 0, 13906835071992266764);
        let v6 = 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::tradable_asset_mstr();
        assert!(0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_collateral(&v1, &v6) == 0, 13906835076287234060);
        let v7 = MakerUnregistered{maker: v0};
        0x2::event::emit<MakerUnregistered>(v7);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.ithaca_balance, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::maker_info_staked_tokens(&v1)), arg1)
    }

    public fun vault_collateral_balance_value<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral_balance)
    }

    public fun vault_ithaca_balance_value<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.ithaca_balance)
    }

    public fun withdraw_collateral<T0, T1>(arg0: &MakerOrderCap, arg1: &mut MakerVault<T0, T1>, arg2: address, arg3: 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::TradableAsset, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.version == 1, 13906835338280632338);
        assert!(arg5 > 0, 13906835342574551042);
        assert!(0x2::table::contains<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&arg1.makers, arg2), 13906835346869911560);
        assert!(arg5 <= get_withdrawable_balance_with_locked<T0, T1>(arg0, arg1, arg2, &arg3, arg4), 13906835359754944522);
        0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::subtract_maker_collateral(0x2::table::borrow_mut<address, 0x2a658207f92adb952aa5055966ac2b99ba68ff177e765bd92808ad4f41eea25b::types::MakerInfo>(&mut arg1.makers, arg2), &arg3, arg5);
        let v0 = CollateralWithdrawn{
            maker          : arg2,
            tradable_asset : arg3,
            amount         : arg5,
        };
        0x2::event::emit<CollateralWithdrawn>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collateral_balance, arg5), arg6)
    }

    // decompiled from Move bytecode v6
}

