module 0xf9110419ecbc7abf1f6b81ac1a5ee64b16b47f8dc9e0d2c0cd6ea420232980a3::global_config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        is_alternative_payment: bool,
        alternative_payment_amount: u64,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        deep_fee_vault: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        whitelist: 0x2::table::Table<0x2::object::ID, bool>,
        package_version: u64,
    }

    struct SponsorFeeRecord has store, key {
        id: 0x2::object::UID,
        sponsor_fee_records: 0x2::table::Table<address, SponsorSpend>,
        epoch_sponsor_fee_limit: u64,
        whitelist: 0x2::table::Table<address, bool>,
    }

    struct SponsorSpend has copy, drop, store {
        epoch: u64,
        spent: u64,
    }

    struct InitGlobalConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        trade_cap_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        global_config_id: 0x2::object::ID,
    }

    struct BalanceCaps has store, key {
        id: 0x2::object::UID,
        deposit_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
        withdraw_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    struct SetAdvanceAmount has copy, drop {
        new_amount: u64,
        old_amount: u64,
    }

    struct SetReferralEvent has copy, drop {
        pool_id: 0x2::object::ID,
        is_set: bool,
    }

    struct MintBalanceCaps has copy, drop {
        deposit_cap_id: 0x2::object::ID,
        withdraw_cap_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
    }

    public fun deposit<T0>(arg0: &mut GlobalConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(&mut arg0.balance_manager, arg1, arg2);
    }

    public(friend) fun generate_proof_as_trader(arg0: &mut GlobalConfig, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg2: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, arg1, arg2)
    }

    public(friend) fun withdraw<T0>(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(&mut arg0.balance_manager, arg1, arg2)
    }

    public(friend) fun withdraw_all<T0>(arg0: &mut GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(&mut arg0.balance_manager, arg1)
    }

    public(friend) fun add_sponsor_record(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::epoch(arg2);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, SponsorFeeRecord>(&mut arg0.id, 0x1::string::utf8(b"sponsor_fee_record"));
        if (!0x2::table::contains<address, SponsorSpend>(&v2.sponsor_fee_records, v0)) {
            if (!0x2::table::contains<address, bool>(&v2.whitelist, v0) && arg1 > v2.epoch_sponsor_fee_limit) {
                return false
            };
            let v3 = SponsorSpend{
                epoch : v1,
                spent : arg1,
            };
            0x2::table::add<address, SponsorSpend>(&mut v2.sponsor_fee_records, v0, v3);
            return true
        };
        let v4 = 0x2::table::borrow_mut<address, SponsorSpend>(&mut v2.sponsor_fee_records, v0);
        if (v4.epoch != v1) {
            if (!0x2::table::contains<address, bool>(&v2.whitelist, v0) && arg1 > v2.epoch_sponsor_fee_limit) {
                return false
            };
            v4.epoch = v1;
            v4.spent = arg1;
            return true
        };
        if (!0x2::table::contains<address, bool>(&v2.whitelist, v0) && v4.spent + arg1 > v2.epoch_sponsor_fee_limit) {
            return false
        };
        v4.spent = v4.spent + arg1;
        true
    }

    public fun add_sponsor_whitelist_address(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, SponsorFeeRecord>(&mut arg0.id, 0x1::string::utf8(b"sponsor_fee_record"));
        if (!0x2::table::contains<address, bool>(&v0.whitelist, arg2)) {
            0x2::table::add<address, bool>(&mut v0.whitelist, arg2, true);
        };
    }

    public fun add_whitelist(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: 0x2::object::ID, arg3: bool) {
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.whitelist, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg1.whitelist, arg2) = arg3;
        } else {
            0x2::table::add<0x2::object::ID, bool>(&mut arg1.whitelist, arg2, arg3);
        };
    }

    public fun alternative_payment_amount(arg0: &GlobalConfig) : u64 {
        arg0.alternative_payment_amount
    }

    public(friend) fun alternative_payment_deep(arg0: &mut GlobalConfig, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        if (!is_alternative_payment(arg0)) {
            return arg1
        };
        if (0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_fee_vault) < arg2) {
            return arg1
        };
        let v0 = add_sponsor_record(arg0, arg2, arg3);
        if (!v0) {
            return arg1
        };
        let v1 = 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v1, 0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_fee_vault, arg2));
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v1, arg3)
    }

    public fun balance_manager_id(arg0: &GlobalConfig) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg0.balance_manager)
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(1 >= arg0.package_version, 2);
    }

    public fun deep_fee_amount(arg0: &GlobalConfig) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_fee_vault)
    }

    public fun deposit_deep_fee(arg0: &mut GlobalConfig, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_fee_vault, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    public(friend) fun deposit_proxy_deep(arg0: &mut GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_advance_deep(arg0, arg1);
        deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, v0, arg1);
    }

    public(friend) fun get_config_trade_cap(arg0: &GlobalConfig) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        &arg0.trade_cap
    }

    public(friend) fun get_deposit_and_withdraw_caps(arg0: &BalanceCaps) : (&0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap) {
        (&arg0.deposit_cap, &arg0.withdraw_cap)
    }

    public(friend) fun get_mut_balance_manager_and_trade_cap(arg0: &mut GlobalConfig) : (&mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap) {
        (&mut arg0.balance_manager, &arg0.trade_cap)
    }

    public(friend) fun get_mut_config_balance_manager(arg0: &mut GlobalConfig) : &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager {
        &mut arg0.balance_manager
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v0, arg0);
        let v2 = GlobalConfig{
            id                         : 0x2::object::new(arg0),
            is_alternative_payment     : true,
            alternative_payment_amount : 100000000,
            trade_cap                  : v1,
            balance_manager            : v0,
            deep_fee_vault             : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            whitelist                  : 0x2::table::new<0x2::object::ID, bool>(arg0),
            package_version            : 1,
        };
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v2);
        let v4 = InitGlobalConfigEvent{
            admin_cap_id       : 0x2::object::id<AdminCap>(&v3),
            trade_cap_id       : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&v1),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&v0),
            global_config_id   : 0x2::object::id<GlobalConfig>(&v2),
        };
        0x2::event::emit<InitGlobalConfigEvent>(v4);
    }

    public fun init_sponsor_fee_record(arg0: &mut GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_object_field::exists_with_type<0x1::string::String, SponsorFeeRecord>(&arg0.id, 0x1::string::utf8(b"sponsor_fee_record"))) {
            return
        };
        let v0 = SponsorFeeRecord{
            id                      : 0x2::object::new(arg1),
            sponsor_fee_records     : 0x2::table::new<address, SponsorSpend>(arg1),
            epoch_sponsor_fee_limit : 10000000000,
            whitelist               : 0x2::table::new<address, bool>(arg1),
        };
        0x2::dynamic_object_field::add<0x1::string::String, SponsorFeeRecord>(&mut arg0.id, 0x1::string::utf8(b"sponsor_fee_record"), v0);
    }

    public fun is_alternative_payment(arg0: &GlobalConfig) : bool {
        arg0.is_alternative_payment
    }

    public fun is_whitelisted(arg0: &GlobalConfig, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.whitelist, arg1) && *0x2::table::borrow<0x2::object::ID, bool>(&arg0.whitelist, arg1)
    }

    public fun mint_balance_caps(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = get_mut_balance_manager_and_trade_cap(arg1);
        let v2 = BalanceCaps{
            id           : 0x2::object::new(arg2),
            deposit_cap  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_deposit_cap(v0, arg2),
            withdraw_cap : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_withdraw_cap(v0, arg2),
        };
        let v3 = MintBalanceCaps{
            deposit_cap_id     : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&v2.deposit_cap),
            withdraw_cap_id    : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&v2.withdraw_cap),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg1.balance_manager),
        };
        0x2::event::emit<MintBalanceCaps>(v3);
        0x2::transfer::share_object<BalanceCaps>(v2);
    }

    public(friend) fun place_market_order_by_trader<T0, T1>(arg0: &mut GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u8, arg4: u64, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg1, &mut arg0.balance_manager, &v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun place_market_order_by_user_bm<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u8, arg4: u64, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg0, arg8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg1, arg0, &v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun remove_sponsor_whitelist_address(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, SponsorFeeRecord>(&mut arg0.id, 0x1::string::utf8(b"sponsor_fee_record"));
        if (0x2::table::contains<address, bool>(&v0.whitelist, arg2)) {
            0x2::table::remove<address, bool>(&mut v0.whitelist, arg2);
        };
    }

    public fun remove_whitelist(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg1.whitelist, arg2)) {
            return
        };
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.whitelist, arg2);
    }

    public fun set_alternative_payment_amount(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.alternative_payment_amount = arg2;
        let v0 = SetAdvanceAmount{
            new_amount : arg2,
            old_amount : arg1.alternative_payment_amount,
        };
        0x2::event::emit<SetAdvanceAmount>(v0);
    }

    public fun set_is_alternative_payment(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.is_alternative_payment = arg2;
    }

    public fun set_referral(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg3: 0x2::object::ID) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::set_balance_manager_referral(&mut arg1.balance_manager, arg2, &arg1.trade_cap);
        let v0 = SetReferralEvent{
            pool_id : arg3,
            is_set  : true,
        };
        0x2::event::emit<SetReferralEvent>(v0);
    }

    public fun trade_cap_id(arg0: &GlobalConfig) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.trade_cap)
    }

    public fun unset_referral<T0, T1>(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::unset_balance_manager_referral(&mut arg1.balance_manager, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2), &arg1.trade_cap);
        let v0 = SetReferralEvent{
            pool_id : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg2),
            is_set  : false,
        };
        0x2::event::emit<SetReferralEvent>(v0);
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 <= 1, 4);
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    public fun update_sponsor_fee_limit(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, SponsorFeeRecord>(&mut arg0.id, 0x1::string::utf8(b"sponsor_fee_record")).epoch_sponsor_fee_limit = arg2;
    }

    public(friend) fun withdraw_advance_deep(arg0: &mut GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        let v0 = arg0.alternative_payment_amount;
        assert!(deep_fee_amount(arg0) >= v0, 0);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_fee_vault, v0), arg1)
    }

    public fun withdraw_deep_fee(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(deep_fee_amount(arg1) >= arg2, 0);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.deep_fee_vault, arg2), arg3)
    }

    public(friend) fun withdraw_refund_deep(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance_manager, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

