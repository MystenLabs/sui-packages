module 0x1cf59edef2a6b57337493659f824e50f33ae470fd57bd27b2d651dade94f9843::liquidator {
    struct LiquidationReceipt {
        executor: address,
        liquidate_user: address,
        debt_asset_id: u8,
        collateral_asset_id: u8,
        flash_amount: u64,
        collateral_obtained: u64,
        excess_debt_obtained: u64,
        recipient: address,
        min_profit: u64,
    }

    struct LiquidationStarted has copy, drop {
        executor: address,
        liquidate_user: address,
        debt_asset: u8,
        collateral_asset: u8,
        flash_amount: u64,
        collateral_obtained: u64,
        excess_debt: u64,
        recipient: address,
        min_profit: u64,
    }

    struct LiquidationFinished has copy, drop {
        executor: address,
        liquidate_user: address,
        debt_asset: u8,
        collateral_asset: u8,
        flash_amount: u64,
        flash_repay_amount: u64,
        profit: u64,
        recipient: address,
    }

    public fun finish_liquidation<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>, arg4: LiquidationReceipt, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let LiquidationReceipt {
            executor             : v0,
            liquidate_user       : v1,
            debt_asset_id        : v2,
            collateral_asset_id  : v3,
            flash_amount         : v4,
            collateral_obtained  : _,
            excess_debt_obtained : _,
            recipient            : v7,
            min_profit           : v8,
        } = arg4;
        let (_, _, v11, _, v13, v14) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(&arg3);
        let v15 = v11 + v13 + v14;
        assert!(0x2::balance::value<T0>(&arg5) >= v15, 100);
        let v16 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg0, arg1, arg2, arg3, arg5, arg6);
        let v17 = 0x2::balance::value<T0>(&v16);
        assert!(v17 >= v8, 101);
        if (v17 == 0) {
            0x2::balance::destroy_zero<T0>(v16);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg6), v7);
        };
        let v18 = LiquidationFinished{
            executor           : v0,
            liquidate_user     : v1,
            debt_asset         : v2,
            collateral_asset   : v3,
            flash_amount       : v4,
            flash_repay_amount : v15,
            profit             : v17,
            recipient          : v7,
        };
        0x2::event::emit<LiquidationFinished>(v18);
    }

    public fun receipt_collateral_asset_id(arg0: &LiquidationReceipt) : u8 {
        arg0.collateral_asset_id
    }

    public fun receipt_collateral_obtained(arg0: &LiquidationReceipt) : u64 {
        arg0.collateral_obtained
    }

    public fun receipt_debt_asset_id(arg0: &LiquidationReceipt) : u8 {
        arg0.debt_asset_id
    }

    public fun receipt_excess_debt(arg0: &LiquidationReceipt) : u64 {
        arg0.excess_debt_obtained
    }

    public fun receipt_executor(arg0: &LiquidationReceipt) : address {
        arg0.executor
    }

    public fun receipt_flash_amount(arg0: &LiquidationReceipt) : u64 {
        arg0.flash_amount
    }

    public fun receipt_liquidate_user(arg0: &LiquidationReceipt) : address {
        arg0.liquidate_user
    }

    public fun receipt_min_profit(arg0: &LiquidationReceipt) : u64 {
        arg0.min_profit
    }

    public fun receipt_recipient(arg0: &LiquidationReceipt) : address {
        arg0.recipient
    }

    public fun start_liquidation<T0, T1>(arg0: &0x1cf59edef2a6b57337493659f824e50f33ae470fd57bd27b2d651dade94f9843::whitelist::Whitelist, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: u8, arg11: u8, arg12: address, arg13: u64, arg14: address, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>, LiquidationReceipt) {
        let v0 = 0x2::tx_context::sender(arg16);
        0x1cf59edef2a6b57337493659f824e50f33ae470fd57bd27b2d651dade94f9843::whitelist::assert_whitelisted(arg0, v0);
        let (v1, v2) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg4, arg5, arg13, arg9, arg16);
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg1, arg2, arg3, arg10, arg5, v1, arg11, arg6, arg12, arg7, arg8, arg9, arg16);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::balance::value<T1>(&v6);
        let v8 = 0x2::balance::value<T0>(&v5);
        let v9 = LiquidationReceipt{
            executor             : v0,
            liquidate_user       : arg12,
            debt_asset_id        : arg10,
            collateral_asset_id  : arg11,
            flash_amount         : arg13,
            collateral_obtained  : v7,
            excess_debt_obtained : v8,
            recipient            : arg14,
            min_profit           : arg15,
        };
        let v10 = LiquidationStarted{
            executor            : v0,
            liquidate_user      : arg12,
            debt_asset          : arg10,
            collateral_asset    : arg11,
            flash_amount        : arg13,
            collateral_obtained : v7,
            excess_debt         : v8,
            recipient           : arg14,
            min_profit          : arg15,
        };
        0x2::event::emit<LiquidationStarted>(v10);
        (v6, v5, v2, v9)
    }

    // decompiled from Move bytecode v7
}

