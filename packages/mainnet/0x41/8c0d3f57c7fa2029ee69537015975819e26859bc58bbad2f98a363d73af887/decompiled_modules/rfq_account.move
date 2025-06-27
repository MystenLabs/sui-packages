module 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::rfq_account {
    struct EventSwapExecuted<phantom T0, phantom T1> has copy, drop {
        rfq_account_id: 0x2::object::ID,
        nonce_lane_id: 0x2::object::ID,
        nonce_value: u64,
        input: u64,
        output: u64,
    }

    struct EventNewRfqAccount has copy, drop {
        rfq_account_id: 0x2::object::ID,
        rfq_account_cap_id: 0x2::object::ID,
    }

    struct Rfq<phantom T0, phantom T1> has copy, drop {
        base_type: 0x1::type_name::TypeName,
        quote_type: 0x1::type_name::TypeName,
        nonce_lane_id: 0x2::object::ID,
        nonce: u64,
        quote_in: u64,
        base_out: u64,
        expiry_time_ms: u64,
    }

    struct NonceLane has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct Account has key {
        id: 0x2::object::UID,
        margin_account_cap: 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::MarginAccountCap,
        public_key: vector<u8>,
        nonce_lanes: 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::table_set::TableSet<0x2::object::ID>,
    }

    struct AccountCap has store, key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
    }

    public fun borrow_margin_account(arg0: &Account, arg1: &AccountCap, arg2: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::ProtectedMarginAccount) : (0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::MarginAccount, 0x2::borrow::Borrow) {
        assert_cap_for_account(arg1, arg0);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::borrow_margin_account(arg2, &arg0.margin_account_cap)
    }

    public fun account_cap_rfq_account_id(arg0: &AccountCap) : 0x2::object::ID {
        arg0.account_id
    }

    public fun add_nonce_lane(arg0: &mut Account, arg1: &AccountCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_cap_for_account(arg1, arg0);
        let v0 = NonceLane{
            id    : 0x2::object::new(arg2),
            value : 0,
        };
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::table_set::add<0x2::object::ID>(&mut arg0.nonce_lanes, 0x2::object::uid_to_inner(&v0.id));
        0x2::transfer::share_object<NonceLane>(v0);
    }

    fun assert_cap_for_account(arg0: &AccountCap, arg1: &Account) {
        assert!(arg0.account_id == 0x2::object::uid_to_inner(&arg1.id), 0);
    }

    public(friend) fun borrow_margin_account_from_rfq<T0, T1>(arg0: &Account, arg1: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::ProtectedMarginAccount, arg2: &mut NonceLane, arg3: u64, arg4: &0x2::balance::Balance<T1>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock) : (0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::MarginAccount, 0x2::borrow::Borrow) {
        validate<T0, T1>(arg0, arg2, arg3, 0x2::balance::value<T1>(arg4), arg5, arg6, arg7);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::borrow_margin_account(arg1, &arg0.margin_account_cap)
    }

    public fun create_rfq_account(arg0: vector<u8>, arg1: &0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::risk_params::RiskParams, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : AccountCap {
        let v0 = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::create_margin_account(arg1, arg2, arg3);
        margin_account_into_rfq_account(v0, arg0, arg3)
    }

    public fun destroy_rfq_account(arg0: Account, arg1: AccountCap) : 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::MarginAccountCap {
        assert_cap_for_account(&arg1, &arg0);
        let AccountCap {
            id         : v0,
            account_id : _,
        } = arg1;
        0x2::object::delete(v0);
        let Account {
            id                 : v2,
            margin_account_cap : v3,
            public_key         : _,
            nonce_lanes        : v5,
        } = arg0;
        0x2::object::delete(v2);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::table_set::drop<0x2::object::ID>(v5);
        v3
    }

    public fun margin_account_into_rfq_account(arg0: 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::MarginAccountCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : AccountCap {
        let v0 = Account{
            id                 : 0x2::object::new(arg2),
            margin_account_cap : arg0,
            public_key         : arg1,
            nonce_lanes        : 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::table_set::new<0x2::object::ID>(arg2),
        };
        let v1 = AccountCap{
            id         : 0x2::object::new(arg2),
            account_id : 0x2::object::uid_to_inner(&v0.id),
        };
        let v2 = EventNewRfqAccount{
            rfq_account_id     : 0x2::object::uid_to_inner(&v0.id),
            rfq_account_cap_id : 0x2::object::uid_to_inner(&v1.id),
        };
        0x2::event::emit<EventNewRfqAccount>(v2);
        let v3 = &mut v0;
        add_nonce_lane(v3, &v1, arg2);
        0x2::transfer::share_object<Account>(v0);
        v1
    }

    public fun remove_nonce_lane(arg0: &mut Account, arg1: NonceLane, arg2: &AccountCap) {
        assert_cap_for_account(arg2, arg0);
        let NonceLane {
            id    : v0,
            value : _,
        } = arg1;
        let v2 = v0;
        assert!(0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::table_set::contains<0x2::object::ID>(&arg0.nonce_lanes, 0x2::object::uid_to_inner(&v2)), 0);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::table_set::remove<0x2::object::ID>(&mut arg0.nonce_lanes, 0x2::object::uid_to_inner(&v2));
        0x2::object::delete(v2);
    }

    public fun swap_with_future_token_and_lending_pool<T0, T1, T2>(arg0: &Account, arg1: &mut NonceLane, arg2: u64, arg3: vector<u8>, arg4: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::ProtectedMarginAccount, arg5: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::future_token::Pool<T0, T1>, arg6: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::lending_pool::LendingPool<T2>, arg7: u64, arg8: 0x2::balance::Balance<T2>, arg9: &0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::risk_params::RiskParams, arg10: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::trusted_prices::TrustedPriceData, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = borrow_margin_account_from_rfq<T0, T2>(arg0, arg4, arg1, arg7, &arg8, arg2, arg3, arg11);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::open_debt<T2>(v3);
        if (v4 > 0) {
            0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::lending_pool::internal_swap_repay_for_margin_account<T2>(arg6, v3, 0x2::balance::split<T2>(&mut arg8, 0x1::u64::min(0x2::balance::value<T2>(&arg8), v4)), arg9, arg11, arg12);
        };
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::deposit_collateral<T2>(v3, arg8, arg9);
        let v5 = 0x1::u64::min(arg7, 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::collateral_value<T0>(v3));
        let v6 = arg7 - v5;
        let v7 = 0x2::balance::zero<T0>();
        let (v8, v9) = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::borrow_collateral<T0>(v3, v5);
        let v10 = v9;
        0x2::balance::join<T0>(&mut v7, v8);
        if (v6 > 0) {
            let (v11, _, v13) = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::future_token::internal_swap_borrow_and_check_later<T0, T1>(arg5, v3, v6, arg9, arg11, arg12);
            0x2::balance::join<T0>(&mut v7, v11);
            0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::join_must_check_borrow_limits(&v10, v13);
        };
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::check_borrow_limits(&v2, arg10, arg9, v10);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::return_margin_account(arg4, v2, v1);
        let v14 = EventSwapExecuted<T0, T2>{
            rfq_account_id : 0x2::object::uid_to_inner(&arg0.id),
            nonce_lane_id  : 0x2::object::uid_to_inner(&arg1.id),
            nonce_value    : arg1.value,
            input          : 0x2::balance::value<T2>(&arg8),
            output         : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<EventSwapExecuted<T0, T2>>(v14);
        v7
    }

    public fun swap_with_future_tokens<T0, T1, T2, T3>(arg0: &Account, arg1: &mut NonceLane, arg2: u64, arg3: vector<u8>, arg4: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::ProtectedMarginAccount, arg5: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::future_token::Pool<T0, T1>, arg6: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::future_token::Pool<T2, T3>, arg7: u64, arg8: 0x2::balance::Balance<T2>, arg9: &0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::risk_params::RiskParams, arg10: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::trusted_prices::TrustedPriceData, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = borrow_margin_account_from_rfq<T0, T2>(arg0, arg4, arg1, arg7, &arg8, arg2, arg3, arg11);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::open_debt<T2>(v3);
        if (v4 > 0) {
            0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::future_token::internal_swap_repay_for_margin_account<T2, T3>(arg6, v3, 0x2::balance::split<T2>(&mut arg8, 0x1::u64::min(0x2::balance::value<T2>(&arg8), v4)), arg9, arg11, arg12);
        };
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::deposit_collateral<T2>(v3, arg8, arg9);
        let v5 = 0x1::u64::min(arg7, 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::collateral_value<T0>(v3));
        let v6 = arg7 - v5;
        let v7 = 0x2::balance::zero<T0>();
        let (v8, v9) = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::borrow_collateral<T0>(v3, v5);
        let v10 = v9;
        0x2::balance::join<T0>(&mut v7, v8);
        if (v6 > 0) {
            let (v11, _, v13) = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::future_token::internal_swap_borrow_and_check_later<T0, T1>(arg5, v3, v6, arg9, arg11, arg12);
            0x2::balance::join<T0>(&mut v7, v11);
            0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::join_must_check_borrow_limits(&v10, v13);
        };
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::check_borrow_limits(&v2, arg10, arg9, v10);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::return_margin_account(arg4, v2, v1);
        let v14 = EventSwapExecuted<T0, T2>{
            rfq_account_id : 0x2::object::uid_to_inner(&arg0.id),
            nonce_lane_id  : 0x2::object::uid_to_inner(&arg1.id),
            nonce_value    : arg1.value,
            input          : 0x2::balance::value<T2>(&arg8),
            output         : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<EventSwapExecuted<T0, T2>>(v14);
        v7
    }

    public fun swap_with_lending_pool_and_future_token<T0, T1, T2>(arg0: &Account, arg1: &mut NonceLane, arg2: u64, arg3: vector<u8>, arg4: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::ProtectedMarginAccount, arg5: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::lending_pool::LendingPool<T0>, arg6: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::future_token::Pool<T1, T2>, arg7: u64, arg8: 0x2::balance::Balance<T1>, arg9: &0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::risk_params::RiskParams, arg10: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::trusted_prices::TrustedPriceData, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = borrow_margin_account_from_rfq<T0, T1>(arg0, arg4, arg1, arg7, &arg8, arg2, arg3, arg11);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::open_debt<T1>(v3);
        if (v4 > 0) {
            0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::future_token::internal_swap_repay_for_margin_account<T1, T2>(arg6, v3, 0x2::balance::split<T1>(&mut arg8, 0x1::u64::min(0x2::balance::value<T1>(&arg8), v4)), arg9, arg11, arg12);
        };
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::deposit_collateral<T1>(v3, arg8, arg9);
        let v5 = 0x1::u64::min(arg7, 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::collateral_value<T0>(v3));
        let v6 = arg7 - v5;
        let v7 = 0x2::balance::zero<T0>();
        let (v8, v9) = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::borrow_collateral<T0>(v3, v5);
        let v10 = v9;
        0x2::balance::join<T0>(&mut v7, v8);
        if (v6 > 0) {
            let (v11, _, v13) = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::lending_pool::internal_swap_borrow_and_check_later<T0>(arg5, v3, v6, arg9, arg11, arg12);
            0x2::balance::join<T0>(&mut v7, v11);
            0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::join_must_check_borrow_limits(&v10, v13);
        };
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::check_borrow_limits(&v2, arg10, arg9, v10);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::return_margin_account(arg4, v2, v1);
        let v14 = EventSwapExecuted<T0, T1>{
            rfq_account_id : 0x2::object::uid_to_inner(&arg0.id),
            nonce_lane_id  : 0x2::object::uid_to_inner(&arg1.id),
            nonce_value    : arg1.value,
            input          : 0x2::balance::value<T1>(&arg8),
            output         : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<EventSwapExecuted<T0, T1>>(v14);
        v7
    }

    public fun swap_with_lending_pools<T0, T1>(arg0: &Account, arg1: &mut NonceLane, arg2: u64, arg3: vector<u8>, arg4: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::ProtectedMarginAccount, arg5: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::lending_pool::LendingPool<T0>, arg6: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::lending_pool::LendingPool<T1>, arg7: u64, arg8: 0x2::balance::Balance<T1>, arg9: &0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::risk_params::RiskParams, arg10: &mut 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::trusted_prices::TrustedPriceData, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = borrow_margin_account_from_rfq<T0, T1>(arg0, arg4, arg1, arg7, &arg8, arg2, arg3, arg11);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::open_debt<T1>(v3);
        if (v4 > 0) {
            0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::lending_pool::internal_swap_repay_for_margin_account<T1>(arg6, v3, 0x2::balance::split<T1>(&mut arg8, 0x1::u64::min(0x2::balance::value<T1>(&arg8), v4)), arg9, arg11, arg12);
        };
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::deposit_collateral<T1>(v3, arg8, arg9);
        let v5 = 0x1::u64::min(arg7, 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::collateral_value<T0>(v3));
        let v6 = arg7 - v5;
        let v7 = 0x2::balance::zero<T0>();
        let (v8, v9) = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::borrow_collateral<T0>(v3, v5);
        let v10 = v9;
        0x2::balance::join<T0>(&mut v7, v8);
        if (v6 > 0) {
            let (v11, _, v13) = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::lending_pool::internal_swap_borrow_and_check_later<T0>(arg5, v3, v6, arg9, arg11, arg12);
            0x2::balance::join<T0>(&mut v7, v11);
            0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::join_must_check_borrow_limits(&v10, v13);
        };
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::check_borrow_limits(&v2, arg10, arg9, v10);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::margin_account::return_margin_account(arg4, v2, v1);
        let v14 = EventSwapExecuted<T0, T1>{
            rfq_account_id : 0x2::object::uid_to_inner(&arg0.id),
            nonce_lane_id  : 0x2::object::uid_to_inner(&arg1.id),
            nonce_value    : arg1.value,
            input          : 0x2::balance::value<T1>(&arg8),
            output         : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<EventSwapExecuted<T0, T1>>(v14);
        v7
    }

    public(friend) fun validate<T0, T1>(arg0: &Account, arg1: &mut NonceLane, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        let v0 = Rfq<T0, T1>{
            base_type      : 0x1::type_name::get<T0>(),
            quote_type     : 0x1::type_name::get<T1>(),
            nonce_lane_id  : 0x2::object::uid_to_inner(&arg1.id),
            nonce          : arg1.value,
            quote_in       : arg3,
            base_out       : arg2,
            expiry_time_ms : arg4,
        };
        assert!(v0.expiry_time_ms > 0x2::clock::timestamp_ms(arg6), 1);
        let v1 = 0x1::bcs::to_bytes<Rfq<T0, T1>>(&v0);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.public_key, &v1), 2);
        arg1.value = arg1.value + 1;
    }

    // decompiled from Move bytecode v6
}

