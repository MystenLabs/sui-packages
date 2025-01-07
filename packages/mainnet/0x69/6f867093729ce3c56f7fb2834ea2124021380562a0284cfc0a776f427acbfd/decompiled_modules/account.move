module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account {
    struct Account<phantom T0> has store {
        id: 0x2::object::ID,
        account_cap: 0xdee9::custodian_v2::AccountCap,
        info: 0x2::table::Table<0x1::type_name::TypeName, AccountInfo<T0>>,
    }

    struct PnlInfo has store {
        matched_orders_history: 0x2::linked_table::LinkedTable<u64, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>,
        realised_pnl: u64,
        is_pnl_positive: bool,
    }

    struct AccountInfo<phantom T0> has store {
        usd_liability: u64,
        iou_liability: u64,
        total_withdrawals: u64,
        total_deposits: u64,
        limit_order_notional_bid: u64,
        limit_order_notional_ask: u64,
        last_funding_deduction_timestamp: u64,
        last_deposit_timestamp: u64,
        pnl_info: PnlInfo,
        processed_withdrawals: 0x2::balance::Balance<T0>,
    }

    struct KriyaAccountCap has store, key {
        id: 0x2::object::UID,
        access_to: 0x2::object::ID,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : (KriyaAccountCap, Account<T0>, 0x2::object::ID, 0x2::object::ID) {
        let v0 = 0xdee9::clob_v2::create_account(arg0);
        let v1 = 0x2::object::id<0xdee9::custodian_v2::AccountCap>(&v0);
        let v2 = KriyaAccountCap{
            id        : 0x2::object::new(arg0),
            access_to : v1,
        };
        let v3 = Account<T0>{
            id          : v1,
            account_cap : v0,
            info        : 0x2::table::new<0x1::type_name::TypeName, AccountInfo<T0>>(arg0),
        };
        (v2, v3, v1, v1)
    }

    public fun id<T0>(arg0: &Account<T0>) : 0x2::object::ID {
        arg0.id
    }

    public fun access_to(arg0: &KriyaAccountCap) : 0x2::object::ID {
        arg0.access_to
    }

    public(friend) fun account_cap<T0>(arg0: &Account<T0>) : &0xdee9::custodian_v2::AccountCap {
        &arg0.account_cap
    }

    public(friend) fun account_cap_id<T0>(arg0: &Account<T0>) : 0x2::object::ID {
        0x2::object::id<0xdee9::custodian_v2::AccountCap>(&arg0.account_cap)
    }

    public(friend) fun account_cap_mut<T0>(arg0: &mut Account<T0>) : &mut 0xdee9::custodian_v2::AccountCap {
        &mut arg0.account_cap
    }

    public fun account_info<T0, T1>(arg0: &Account<T1>) : (u64, u64, u64, u64, u64, u64, u64) {
        assert!(info_exists<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::info_not_found());
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, AccountInfo<T1>>(&arg0.info, 0x1::type_name::get<T0>());
        (v0.usd_liability, v0.iou_liability, v0.total_withdrawals, v0.total_deposits, v0.limit_order_notional_bid, v0.last_funding_deduction_timestamp, 0x2::balance::value<T1>(&v0.processed_withdrawals))
    }

    public(friend) fun dec_liability<T0, T1>(arg0: &mut Account<T1>, arg1: u64, arg2: bool) {
        if (arg1 == 0) {
            return
        };
        assert!(info_exists<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::liability_not_found());
        let v0 = if (arg2) {
            &mut 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>()).usd_liability
        } else {
            &mut 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>()).iou_liability
        };
        assert!(*v0 > 0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::liability_not_found());
        assert!(*v0 >= arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::cannot_dec_liability());
        *v0 = *v0 - arg1;
    }

    public(friend) fun dec_open_order_notional<T0, T1>(arg0: &mut Account<T1>, arg1: u64, arg2: bool) {
        if (arg1 == 0) {
            return
        };
        assert!(info_exists<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::info_not_found());
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>());
        if (arg2) {
            assert!(v0.limit_order_notional_bid + 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::dust_amount() >= arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::cannot_dec_open_order_notional());
            let v1 = if (v0.limit_order_notional_bid > arg1) {
                v0.limit_order_notional_bid - arg1
            } else {
                0
            };
            v0.limit_order_notional_bid = v1;
        } else {
            assert!(v0.limit_order_notional_ask >= arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::cannot_dec_open_order_notional());
            v0.limit_order_notional_ask = v0.limit_order_notional_ask - arg1;
        };
    }

    public fun get_last_deposit_timestamp<T0, T1>(arg0: &Account<T1>) : u64 {
        assert!(info_exists<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::acc_config_not_found());
        0x2::table::borrow<0x1::type_name::TypeName, AccountInfo<T1>>(&arg0.info, 0x1::type_name::get<T0>()).last_deposit_timestamp
    }

    public(friend) fun inc_deposits<T0, T1>(arg0: &mut Account<T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        if (info_exists<T0, T1>(arg0)) {
            let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>());
            v0.total_deposits = v0.total_deposits + arg1;
        } else {
            let v1 = PnlInfo{
                matched_orders_history : 0x2::linked_table::new<u64, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>(arg2),
                realised_pnl           : 0,
                is_pnl_positive        : true,
            };
            let v2 = AccountInfo<T1>{
                usd_liability                    : 0,
                iou_liability                    : 0,
                total_withdrawals                : 0,
                total_deposits                   : arg1,
                limit_order_notional_bid         : 0,
                limit_order_notional_ask         : 0,
                last_funding_deduction_timestamp : 0,
                last_deposit_timestamp           : 0,
                pnl_info                         : v1,
                processed_withdrawals            : 0x2::balance::zero<T1>(),
            };
            0x2::table::add<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>(), v2);
        };
    }

    public(friend) fun inc_liability<T0, T1>(arg0: &mut Account<T1>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        if (info_exists<T0, T1>(arg0)) {
            let v0 = if (arg2) {
                &mut 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>()).usd_liability
            } else {
                &mut 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>()).iou_liability
            };
            *v0 = *v0 + arg1;
        } else {
            let v1 = if (arg2) {
                arg1
            } else {
                0
            };
            let v2 = if (!arg2) {
                arg1
            } else {
                0
            };
            let v3 = PnlInfo{
                matched_orders_history : 0x2::linked_table::new<u64, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>(arg3),
                realised_pnl           : 0,
                is_pnl_positive        : true,
            };
            let v4 = AccountInfo<T1>{
                usd_liability                    : v1,
                iou_liability                    : v2,
                total_withdrawals                : 0,
                total_deposits                   : 0,
                limit_order_notional_bid         : 0,
                limit_order_notional_ask         : 0,
                last_funding_deduction_timestamp : 0,
                last_deposit_timestamp           : 0,
                pnl_info                         : v3,
                processed_withdrawals            : 0x2::balance::zero<T1>(),
            };
            0x2::table::add<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>(), v4);
        };
    }

    public(friend) fun inc_open_order_notional<T0, T1>(arg0: &mut Account<T1>, arg1: u64, arg2: bool) {
        if (arg1 == 0) {
            return
        };
        assert!(info_exists<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::info_not_found());
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>());
        if (arg2) {
            v0.limit_order_notional_bid = v0.limit_order_notional_bid + arg1;
        } else {
            v0.limit_order_notional_ask = v0.limit_order_notional_ask + arg1;
        };
    }

    public(friend) fun inc_processed_withdrawals<T0, T1>(arg0: &mut Account<T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>()).processed_withdrawals, arg1);
    }

    public(friend) fun inc_withdrawals<T0, T1>(arg0: &mut Account<T1>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        assert!(info_exists<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::withdrawal_info_not_found());
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>());
        v0.total_withdrawals = v0.total_withdrawals + arg1;
    }

    public fun info_exists<T0, T1>(arg0: &Account<T1>) : bool {
        0x2::table::contains<0x1::type_name::TypeName, AccountInfo<T1>>(&arg0.info, 0x1::type_name::get<T0>())
    }

    public fun last_funding_deduction_timestamp<T0, T1>(arg0: &Account<T1>) : u64 {
        if (info_exists<T0, T1>(arg0)) {
            0x2::table::borrow<0x1::type_name::TypeName, AccountInfo<T1>>(&arg0.info, 0x1::type_name::get<T0>()).last_funding_deduction_timestamp
        } else {
            0
        }
    }

    public fun liabilities<T0, T1>(arg0: &Account<T1>) : (u64, u64) {
        (liability<T0, T1>(arg0, true), liability<T0, T1>(arg0, false))
    }

    public fun liability<T0, T1>(arg0: &Account<T1>, arg1: bool) : u64 {
        if (info_exists<T0, T1>(arg0)) {
            if (arg1) {
                0x2::table::borrow<0x1::type_name::TypeName, AccountInfo<T1>>(&arg0.info, 0x1::type_name::get<T0>()).usd_liability
            } else {
                0x2::table::borrow<0x1::type_name::TypeName, AccountInfo<T1>>(&arg0.info, 0x1::type_name::get<T0>()).iou_liability
            }
        } else {
            0
        }
    }

    public fun limit_order_notional<T0, T1>(arg0: &Account<T1>) : (u64, u64) {
        (limit_order_notional_bid<T0, T1>(arg0), limit_order_notional_ask<T0, T1>(arg0))
    }

    public fun limit_order_notional_ask<T0, T1>(arg0: &Account<T1>) : u64 {
        if (info_exists<T0, T1>(arg0)) {
            0x2::table::borrow<0x1::type_name::TypeName, AccountInfo<T1>>(&arg0.info, 0x1::type_name::get<T0>()).limit_order_notional_ask
        } else {
            0
        }
    }

    public fun limit_order_notional_bid<T0, T1>(arg0: &Account<T1>) : u64 {
        if (info_exists<T0, T1>(arg0)) {
            0x2::table::borrow<0x1::type_name::TypeName, AccountInfo<T1>>(&arg0.info, 0x1::type_name::get<T0>()).limit_order_notional_bid
        } else {
            0
        }
    }

    public(friend) fun mo_history_mut<T0, T1>(arg0: &mut Account<T1>) : &mut 0x2::linked_table::LinkedTable<u64, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder> {
        &mut 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>()).pnl_info.matched_orders_history
    }

    public fun pnl_info<T0, T1>(arg0: &Account<T1>) : (u64, bool) {
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, AccountInfo<T1>>(&arg0.info, 0x1::type_name::get<T0>());
        (v0.pnl_info.realised_pnl, v0.pnl_info.is_pnl_positive)
    }

    public(friend) fun set_last_deposit_timestamp<T0, T1>(arg0: &mut Account<T1>, arg1: u64) {
        assert!(info_exists<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::acc_config_not_found());
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>());
        assert!(v0.last_deposit_timestamp <= arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::invalid_deposit_timestamp());
        v0.last_deposit_timestamp = arg1;
    }

    public(friend) fun set_last_funding_deduction_timestamp<T0, T1>(arg0: &mut Account<T1>, arg1: u64) {
        assert!(info_exists<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::acc_config_not_found());
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>());
        assert!(v0.last_funding_deduction_timestamp <= arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::invalid_funding_timestamp());
        v0.last_funding_deduction_timestamp = arg1;
    }

    public(friend) fun set_pnl_info<T0, T1>(arg0: &mut Account<T1>, arg1: u64, arg2: bool) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>());
        if (v0.pnl_info.is_pnl_positive == arg2) {
            v0.pnl_info.realised_pnl = v0.pnl_info.realised_pnl + arg1;
        } else if (v0.pnl_info.realised_pnl >= arg1) {
            v0.pnl_info.realised_pnl = v0.pnl_info.realised_pnl - arg1;
        } else {
            v0.pnl_info.realised_pnl = arg1 - v0.pnl_info.realised_pnl;
            v0.pnl_info.is_pnl_positive = arg2;
        };
    }

    public fun total_deposits<T0, T1>(arg0: &Account<T1>) : u64 {
        if (info_exists<T0, T1>(arg0)) {
            0x2::table::borrow<0x1::type_name::TypeName, AccountInfo<T1>>(&arg0.info, 0x1::type_name::get<T0>()).total_deposits
        } else {
            0
        }
    }

    public fun total_withdrawals<T0, T1>(arg0: &Account<T1>) : u64 {
        if (info_exists<T0, T1>(arg0)) {
            0x2::table::borrow<0x1::type_name::TypeName, AccountInfo<T1>>(&arg0.info, 0x1::type_name::get<T0>()).total_withdrawals
        } else {
            0
        }
    }

    public(friend) fun withdraw_processed<T0, T1>(arg0: &mut Account<T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountInfo<T1>>(&mut arg0.info, 0x1::type_name::get<T0>());
        assert!(0x2::balance::value<T1>(&v0.processed_withdrawals) >= arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::insufficient_processed_funds_for_with());
        0x2::balance::split<T1>(&mut v0.processed_withdrawals, arg1)
    }

    // decompiled from Move bytecode v6
}

