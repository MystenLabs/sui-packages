module 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::withdraw_queue {
    struct WithdrawQueue<phantom T0> has store, key {
        id: 0x2::object::UID,
        withdrawal_requests: 0x2::linked_table::LinkedTable<QueueKey, WithdrawalRequest<T0>>,
        requests_per_address: 0x2::table::Table<AddressTypeKey, vector<QueueKey>>,
    }

    struct WithdrawalRequest<phantom T0> has store {
        shares: 0x2::balance::Balance<T0>,
        amount_of_assets: u64,
        creation_time_ms: u64,
        ms_to_maturity: u64,
        ms_to_deadline: u64,
        asset_type: 0x1::type_name::TypeName,
        exchange_rate_at_time_of_request: u64,
    }

    struct AddressTypeKey has copy, drop, store {
        account: address,
        asset_type: 0x1::type_name::TypeName,
    }

    struct QueueKey has copy, drop, store {
        account: address,
        asset_type: 0x1::type_name::TypeName,
        timestamp: u64,
    }

    struct WithdrawRequestedEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        shares: u64,
        creation_time_ms: u64,
        req_key: QueueKey,
    }

    struct WithdrawRequestCancelledEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        shares: u64,
        request_id: QueueKey,
    }

    struct WithdrawCompletedEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        shares: u64,
        assets_returned: u64,
        excess: u64,
        deficit: u64,
    }

    public(friend) fun borrow_withdrawal_request_by_key<T0>(arg0: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg1: &QueueKey) : &WithdrawalRequest<T0> {
        assert!(0x2::linked_table::contains<QueueKey, WithdrawalRequest<T0>>(&0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue<T0, WithdrawQueue<T0>>(arg0).withdrawal_requests, *arg1), 4);
        0x2::linked_table::borrow<QueueKey, WithdrawalRequest<T0>>(&0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue<T0, WithdrawQueue<T0>>(arg0).withdrawal_requests, *arg1)
    }

    public fun cancel_withdraw_by_req_id<T0, T1>(arg0: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg1: &mut QueueKey, arg2: &0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::assert_vault<T0>(arg0, arg2, arg1.account);
        assert!(arg1.account == 0x2::tx_context::sender(arg3), 12);
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::user_depositable_asset_exists<T0>(arg0, 0x1::type_name::get_with_original_ids<T1>()), 6);
        let v0 = remove_withdrawal_request_by_key<T0>(arg0, *arg1);
        let WithdrawalRequest {
            shares                           : v1,
            amount_of_assets                 : _,
            creation_time_ms                 : _,
            ms_to_maturity                   : _,
            ms_to_deadline                   : _,
            asset_type                       : v6,
            exchange_rate_at_time_of_request : _,
        } = v0;
        let v8 = v1;
        let v9 = 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::user_depositable_asset_info_mut<T0>(arg0, v6);
        let v10 = 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_capacity<T0>(v9);
        let v11 = 0x2::balance::value<T0>(&v8);
        if (v10 < 18446744073709551615) {
            assert!(v10 <= 18446744073709551615 - v11, 10);
            0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::set_withdraw_capacity<T0, T1>(v9, v10 + v11);
        };
        emit_withdraw_request_cancelled_event<T0, T1>(arg1.account, v11, *arg1);
        0x2::coin::from_balance<T0>(v8, arg3)
    }

    public fun cancel_withdraw_by_req_id_and_transfer<T0, T1>(arg0: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg1: &mut QueueKey, arg2: &0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = cancel_withdraw_by_req_id<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun complete_withdraw<T0, T1>(arg0: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg1: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::Accountant<T0>, arg2: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg3: address, arg4: &mut 0x1::option::Option<0x2::coin::Coin<T1>>, arg5: &0x2::clock::Clock, arg6: &0x2::deny_list::DenyList, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::PriceFeedsMap<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::assert_vault<T0>(arg0, arg6, arg3);
        let v0 = 0x1::type_name::get_with_original_ids<T1>();
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::user_depositable_asset_exists<T0>(arg0, v0), 6);
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::allow_withdraws<T0>(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::user_depositable_asset_info<T0>(arg0, v0)), 8);
        let v1 = pop_front_withdrawal_request<T0, T1>(arg0, arg3);
        internal_fulfill_withdraw_request<T0, T1>(arg0, arg1, arg2, v1, arg3, arg4, arg5, arg7, arg8, arg9, arg10);
    }

    public fun complete_withdraw_by_request_id<T0, T1>(arg0: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg1: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::Accountant<T0>, arg2: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg3: &mut QueueKey, arg4: &mut 0x1::option::Option<0x2::coin::Coin<T1>>, arg5: &0x2::clock::Clock, arg6: &0x2::deny_list::DenyList, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::PriceFeedsMap<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::assert_vault<T0>(arg0, arg6, arg3.account);
        let v0 = 0x1::type_name::get_with_original_ids<T1>();
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::user_depositable_asset_exists<T0>(arg0, v0), 6);
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::allow_withdraws<T0>(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::user_depositable_asset_info<T0>(arg0, v0)), 8);
        let v1 = remove_withdrawal_request_by_key<T0>(arg0, *arg3);
        internal_fulfill_withdraw_request<T0, T1>(arg0, arg1, arg2, v1, arg3.account, arg4, arg5, arg7, arg8, arg9, arg10);
    }

    public fun create_address_type_key<T0>(arg0: address) : AddressTypeKey {
        AddressTypeKey{
            account    : arg0,
            asset_type : 0x1::type_name::get_with_original_ids<T0>(),
        }
    }

    public fun create_queue_key<T0>(arg0: address, arg1: u64) : QueueKey {
        QueueKey{
            account    : arg0,
            asset_type : 0x1::type_name::get_with_original_ids<T0>(),
            timestamp  : arg1,
        }
    }

    public(friend) fun emit_withdraw_completed_event<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = WithdrawCompletedEvent<T0, T1>{
            user            : arg0,
            shares          : arg1,
            assets_returned : arg2,
            excess          : arg3,
            deficit         : arg4,
        };
        0x2::event::emit<WithdrawCompletedEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_withdraw_request_cancelled_event<T0, T1>(arg0: address, arg1: u64, arg2: QueueKey) {
        let v0 = WithdrawRequestCancelledEvent<T0, T1>{
            user       : arg0,
            shares     : arg1,
            request_id : arg2,
        };
        0x2::event::emit<WithdrawRequestCancelledEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_withdraw_requested_event<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: QueueKey) {
        let v0 = WithdrawRequestedEvent<T0, T1>{
            user             : arg0,
            shares           : arg1,
            creation_time_ms : arg2,
            req_key          : arg3,
        };
        0x2::event::emit<WithdrawRequestedEvent<T0, T1>>(v0);
    }

    fun internal_fulfill_withdraw_request<T0, T1>(arg0: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg1: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::Accountant<T0>, arg2: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg3: WithdrawalRequest<T0>, arg4: address, arg5: &mut 0x1::option::Option<0x2::coin::Coin<T1>>, arg6: &0x2::clock::Clock, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::PriceFeedsMap<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.asset_type == 0x1::type_name::get_with_original_ids<T1>(), 15);
        if (arg4 == 0x2::tx_context::sender(arg10)) {
            assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::allow_self_solvers<T0>(arg0), 13);
        } else {
            assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::allow_third_party_solvers<T0>(arg0), 5);
            assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::SolverCap>(arg2, 0x2::tx_context::sender(arg10)), 1);
        };
        let v0 = 0x2::balance::value<T0>(&arg3.shares);
        assert!(!(v0 == 0), 16);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = arg3.creation_time_ms + arg3.ms_to_maturity;
        assert!(v1 >= v2, 2);
        assert!(v1 < v2 + arg3.ms_to_deadline, 11);
        let v3 = 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::try_from_u256_to_u64((v0 as u256) * (0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::get_rate_safe<T0, T1>(arg1, arg7, arg8, arg9, arg6) as u256) / (0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::get_one_share<T0>(arg1) as u256));
        let v4 = arg3.amount_of_assets;
        let v5 = 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::get_balance_mut<T0, T1>(arg0);
        assert!(v3 <= 0x2::balance::value<T1>(v5), 14);
        let v6 = 0;
        let v7 = 0;
        let v8 = if (v3 >= v4) {
            let v8 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v5, v4), arg10);
            let v9 = v3 - v4;
            v6 = v9;
            let v10 = if (v9 > 0) {
                if (0x2::tx_context::sender(arg10) != arg4) {
                    0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::excess_to_solver<T0>(arg0)
                } else {
                    false
                }
            } else {
                false
            };
            if (v10) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v5, v9), arg10), 0x2::tx_context::sender(arg10));
            };
            v8
        } else {
            let v8 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v5, v3), arg10);
            let v11 = v4 - v3;
            v7 = v11;
            assert!(0x1::option::is_some<0x2::coin::Coin<T1>>(arg5) && 0x2::coin::value<T1>(0x1::option::borrow<0x2::coin::Coin<T1>>(arg5)) >= v11, 3);
            0x2::coin::join<T1>(&mut v8, 0x2::coin::split<T1>(0x1::option::borrow_mut<0x2::coin::Coin<T1>>(arg5), v11, arg10));
            v8
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v8, arg4);
        let WithdrawalRequest {
            shares                           : v12,
            amount_of_assets                 : v13,
            creation_time_ms                 : _,
            ms_to_maturity                   : _,
            ms_to_deadline                   : _,
            asset_type                       : _,
            exchange_rate_at_time_of_request : _,
        } = arg3;
        let v19 = 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::treasury_cap_mut<T0>(arg0);
        0x2::coin::burn<T0>(v19, 0x2::coin::from_balance<T0>(v12, arg10));
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::update_total_shares<T0>(arg1, 0x2::coin::total_supply<T0>(v19));
        emit_withdraw_completed_event<T0, T1>(arg4, v0, v13, v6, v7);
    }

    public(friend) fun new_withdraw_queue<T0>(arg0: &mut 0x2::tx_context::TxContext) : WithdrawQueue<T0> {
        WithdrawQueue<T0>{
            id                   : 0x2::object::new(arg0),
            withdrawal_requests  : 0x2::linked_table::new<QueueKey, WithdrawalRequest<T0>>(arg0),
            requests_per_address : 0x2::table::new<AddressTypeKey, vector<QueueKey>>(arg0),
        }
    }

    public(friend) fun pop_front_withdrawal_request<T0, T1>(arg0: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg1: address) : WithdrawalRequest<T0> {
        let v0 = AddressTypeKey{
            account    : arg1,
            asset_type : 0x1::type_name::get_with_original_ids<T1>(),
        };
        assert!(0x2::table::contains<AddressTypeKey, vector<QueueKey>>(&0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue<T0, WithdrawQueue<T0>>(arg0).requests_per_address, v0), 4);
        let v1 = 0x2::table::borrow_mut<AddressTypeKey, vector<QueueKey>>(&mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue_mut<T0, WithdrawQueue<T0>>(arg0).requests_per_address, v0);
        if (0x1::vector::is_empty<QueueKey>(v1)) {
            0x2::table::remove<AddressTypeKey, vector<QueueKey>>(&mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue_mut<T0, WithdrawQueue<T0>>(arg0).requests_per_address, v0);
        };
        0x2::linked_table::remove<QueueKey, WithdrawalRequest<T0>>(&mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue_mut<T0, WithdrawQueue<T0>>(arg0).withdrawal_requests, 0x1::vector::remove<QueueKey>(v1, 0))
    }

    fun push_back_withdrawal_request<T0, T1>(arg0: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg1: address, arg2: u64, arg3: WithdrawalRequest<T0>) : QueueKey {
        let v0 = 0x1::type_name::get_with_original_ids<T1>();
        let v1 = QueueKey{
            account    : arg1,
            asset_type : v0,
            timestamp  : arg2,
        };
        assert!(!0x2::linked_table::contains<QueueKey, WithdrawalRequest<T0>>(&0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue<T0, WithdrawQueue<T0>>(arg0).withdrawal_requests, v1), 7);
        0x2::linked_table::push_back<QueueKey, WithdrawalRequest<T0>>(&mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue_mut<T0, WithdrawQueue<T0>>(arg0).withdrawal_requests, v1, arg3);
        let v2 = AddressTypeKey{
            account    : arg1,
            asset_type : v0,
        };
        if (!0x2::table::contains<AddressTypeKey, vector<QueueKey>>(&0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue<T0, WithdrawQueue<T0>>(arg0).requests_per_address, v2)) {
            0x2::table::add<AddressTypeKey, vector<QueueKey>>(&mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue_mut<T0, WithdrawQueue<T0>>(arg0).requests_per_address, v2, 0x1::vector::empty<QueueKey>());
        };
        0x1::vector::push_back<QueueKey>(0x2::table::borrow_mut<AddressTypeKey, vector<QueueKey>>(&mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue_mut<T0, WithdrawQueue<T0>>(arg0).requests_per_address, v2), v1);
        v1
    }

    public(friend) fun remove_withdrawal_request_by_key<T0>(arg0: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg1: QueueKey) : WithdrawalRequest<T0> {
        assert!(0x2::linked_table::contains<QueueKey, WithdrawalRequest<T0>>(&0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue<T0, WithdrawQueue<T0>>(arg0).withdrawal_requests, arg1), 4);
        let v0 = AddressTypeKey{
            account    : arg1.account,
            asset_type : arg1.asset_type,
        };
        assert!(0x2::table::contains<AddressTypeKey, vector<QueueKey>>(&0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue<T0, WithdrawQueue<T0>>(arg0).requests_per_address, v0), 6);
        let v1 = 0x2::table::borrow_mut<AddressTypeKey, vector<QueueKey>>(&mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue_mut<T0, WithdrawQueue<T0>>(arg0).requests_per_address, v0);
        let (v2, v3) = 0x1::vector::index_of<QueueKey>(v1, &arg1);
        assert!(v2, 6);
        0x1::vector::remove<QueueKey>(v1, v3);
        if (0x1::vector::is_empty<QueueKey>(v1)) {
            0x2::table::remove<AddressTypeKey, vector<QueueKey>>(&mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue_mut<T0, WithdrawQueue<T0>>(arg0).requests_per_address, v0);
        };
        0x2::linked_table::remove<QueueKey, WithdrawalRequest<T0>>(&mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_queue_mut<T0, WithdrawQueue<T0>>(arg0).withdrawal_requests, arg1)
    }

    public fun request_withdraw<T0, T1>(arg0: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::Vault<T0>, arg1: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::Accountant<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::deny_list::DenyList, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::PriceFeedsMap<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::assert_vault<T0>(arg0, arg6, 0x2::tx_context::sender(arg10));
        let v0 = 0x1::type_name::get_with_original_ids<T1>();
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::user_depositable_asset_exists<T0>(arg0, v0), 6);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::assert_asset_withdrawal_constraints<T0>(arg0, v0, arg3, 0x2::coin::value<T0>(&arg2), arg4);
        let v1 = 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::user_depositable_asset_info_mut<T0>(arg0, v0);
        let v2 = 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::withdraw_capacity<T0>(v1);
        if (v2 < 18446744073709551615) {
            assert!(v2 >= 0x2::coin::value<T0>(&arg2), 9);
            0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::set_withdraw_capacity<T0, T1>(v1, v2 - 0x2::coin::value<T0>(&arg2));
        };
        let v3 = 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::get_rate_safe<T0, T1>(arg1, arg7, arg8, arg9, arg5);
        let v4 = 0x2::coin::value<T0>(&arg2);
        let v5 = 0x2::clock::timestamp_ms(arg5);
        let v6 = WithdrawalRequest<T0>{
            shares                           : 0x2::coin::into_balance<T0>(arg2),
            amount_of_assets                 : 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::try_from_u256_to_u64((v4 as u256) * (v3 as u256) * ((10000 - arg3) as u256) / 10000 / (0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::get_one_share<T0>(arg1) as u256)),
            creation_time_ms                 : v5,
            ms_to_maturity                   : 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::ms_to_maturity<T0>(v1),
            ms_to_deadline                   : arg4,
            asset_type                       : v0,
            exchange_rate_at_time_of_request : v3,
        };
        emit_withdraw_requested_event<T0, T1>(0x2::tx_context::sender(arg10), v4, v5, push_back_withdrawal_request<T0, T1>(arg0, 0x2::tx_context::sender(arg10), v5, v6));
    }

    // decompiled from Move bytecode v6
}

