module 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::boring_vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        assets_balance: 0x2::bag::Bag,
        user_depositable_assets: 0x2::table::Table<0x1::type_name::TypeName, UserDepositableAsset<T0>>,
        withdrawal_requests: 0x2::linked_table::LinkedTable<QueueKey, WithdrawalRequest<T0>>,
        requests_per_address: 0x2::table::Table<AddressTypeKey, vector<QueueKey>>,
        is_vault_paused: bool,
        allow_self_solvers: bool,
        allow_third_party_solvers: bool,
        excess_to_solver: bool,
        deposit_limit: u64,
        version: u64,
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

    struct UserDepositableAsset<phantom T0> has store {
        allow_withdraws: bool,
        allow_deposits: bool,
        share_premium: u16,
        ms_to_maturity: u64,
        minimum_ms_to_deadline: u64,
        min_discount: u64,
        max_discount: u64,
        minimum_shares: u64,
        withdraw_capacity: u64,
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

    struct DepositEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        asset_amount: u64,
        shares_value_minted: u64,
    }

    struct WithdrawRequestedEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        shares: u64,
        creation_time_ms: u64,
        req_key: QueueKey,
    }

    struct WithdrawCompletedEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        shares: u64,
        assets_returned: u64,
        excess: u64,
        deficit: u64,
    }

    struct BulkWithdrawEvent<phantom T0, phantom T1> has copy, drop {
        witness: 0x1::type_name::TypeName,
        shares: u64,
        assets_returned: u64,
    }

    struct NewNonUserDepositableAssetAddedEvent<phantom T0, phantom T1> has copy, drop {
        dummy_field: bool,
    }

    struct WithdrawCapacityUpdatedEvent<phantom T0, phantom T1> has copy, drop {
        withdraw_capacity: u64,
    }

    struct NewVaultCreatedEvent<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct EnableGlobalPauseEvent<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct DisableGlobalPauseEvent<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct VaultOperationsPauseToggledEvent<phantom T0> has copy, drop {
        new_is_paused: bool,
    }

    struct DepositLimitChanged<phantom T0> has copy, drop {
        deposit_limit: u64,
    }

    struct SelfSolverPolicyChanged<phantom T0> has copy, drop {
        allow_self_solvers: bool,
    }

    struct ThirdPartySolverPolicyChanged<phantom T0> has copy, drop {
        allow_third_party_solvers: bool,
    }

    struct FeesClaimedEvent<phantom T0> has copy, drop {
        fees_owed: u64,
    }

    struct WithdrawRequestCancelledEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        shares: u64,
        request_id: QueueKey,
    }

    struct NewUserDepositableAssetAddedEvent<phantom T0, phantom T1> has copy, drop {
        ms_to_maturity: u64,
        minimum_ms_to_deadline: u64,
        min_discount: u64,
        max_discount: u64,
        minimum_shares: u64,
        withdraw_capacity: u64,
    }

    struct UserDepositableAssetUpdatedEvent<phantom T0, phantom T1> has copy, drop {
        allow_withdraws: bool,
        allow_deposits: bool,
        ms_to_maturity: u64,
        minimum_ms_to_deadline: u64,
        min_discount: u64,
        max_discount: u64,
        minimum_shares: u64,
        withdraw_capacity: u64,
    }

    struct UserDepositableAssetRemoved<phantom T0, phantom T1> has copy, drop {
        dummy_field: bool,
    }

    struct VersionUpdatedEvent has copy, drop {
        version: u64,
    }

    public fun add_address_to_deny_list<T0>(arg0: &mut Vault<T0>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T0>, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T0, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg4)), 4);
        0x2::coin::deny_list_v2_add<T0>(arg2, deny_cap_mut<T0>(arg0), arg3, arg4);
    }

    public fun add_asset_type<T0, T1>(arg0: &mut Vault<T1>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T1, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg2)), 4);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets_balance, v0), 6);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets_balance, v0, 0x2::balance::zero<T0>());
        let v1 = NewNonUserDepositableAssetAddedEvent<T0, T1>{dummy_field: false};
        0x2::event::emit<NewNonUserDepositableAssetAddedEvent<T0, T1>>(v1);
    }

    fun add_deny_cap<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::DenyCapV2<T0>) {
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::DenyCapV2<T0>>(&mut arg0.id, b"deny_cap", arg1);
    }

    fun add_treasury_cap<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::TreasuryCap<T0>) {
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, b"treasury_cap", arg1);
    }

    public fun add_user_depositable_asset_type<T0, T1>(arg0: &mut Vault<T1>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T1>, arg2: u16, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T1, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg9)), 4);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0), 6);
        validate_new_user_depositable_asset(arg2, arg3, arg4, arg5, arg6);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets_balance, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets_balance, v0, 0x2::balance::zero<T0>());
        };
        let v1 = UserDepositableAsset<T1>{
            allow_withdraws        : true,
            allow_deposits         : true,
            share_premium          : arg2,
            ms_to_maturity         : arg3,
            minimum_ms_to_deadline : arg4,
            min_discount           : arg5,
            max_discount           : arg6,
            minimum_shares         : arg7,
            withdraw_capacity      : arg8,
        };
        0x2::table::add<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&mut arg0.user_depositable_assets, v0, v1);
        let v2 = NewUserDepositableAssetAddedEvent<T0, T1>{
            ms_to_maturity         : arg3,
            minimum_ms_to_deadline : arg4,
            min_discount           : arg5,
            max_discount           : arg6,
            minimum_shares         : arg7,
            withdraw_capacity      : arg8,
        };
        0x2::event::emit<NewUserDepositableAssetAddedEvent<T0, T1>>(v2);
    }

    public fun allow_self_solvers<T0>(arg0: &Vault<T0>) : bool {
        arg0.allow_self_solvers
    }

    public fun allow_third_party_solvers<T0>(arg0: &Vault<T0>) : bool {
        arg0.allow_third_party_solvers
    }

    fun assert_vault<T0>(arg0: &Vault<T0>, arg1: &0x2::deny_list::DenyList, arg2: address) {
        assert!(arg0.version == 0, 32);
        assert!(!is_vault_paused<T0>(arg0), 7);
        assert!(!is_global_pause_enabled<T0>(arg1), 1);
        assert!(!is_address_denied<T0>(arg1, arg2), 34);
    }

    public fun asset_exists<T0, T1>(arg0: &Vault<T1>) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets_balance, 0x1::type_name::get_with_original_ids<T0>())
    }

    public(friend) fun borrow_oldest_withdrawal_request<T0, T1>(arg0: &Vault<T1>, arg1: address) : &WithdrawalRequest<T1> {
        let v0 = AddressTypeKey{
            account    : arg1,
            asset_type : 0x1::type_name::get_with_original_ids<T0>(),
        };
        assert!(0x2::table::contains<AddressTypeKey, vector<QueueKey>>(&arg0.requests_per_address, v0), 10);
        0x2::linked_table::borrow<QueueKey, WithdrawalRequest<T1>>(&arg0.withdrawal_requests, *0x1::vector::borrow<QueueKey>(0x2::table::borrow<AddressTypeKey, vector<QueueKey>>(&arg0.requests_per_address, v0), 0))
    }

    public(friend) fun borrow_withdrawal_request_by_key<T0>(arg0: &Vault<T0>, arg1: &QueueKey) : &WithdrawalRequest<T0> {
        assert!(0x2::linked_table::contains<QueueKey, WithdrawalRequest<T0>>(&arg0.withdrawal_requests, *arg1), 10);
        0x2::linked_table::borrow<QueueKey, WithdrawalRequest<T0>>(&arg0.withdrawal_requests, *arg1)
    }

    public fun bulk_withdraw<T0, T1, T2: drop>(arg0: T2, arg1: &mut Vault<T1>, arg2: &mut 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::Accountant<T1>, arg3: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T1>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::deny_list::DenyList, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::oracle::PriceFeedsMap<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_vault<T1>(arg1, arg6, 0x2::tx_context::sender(arg11));
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg1.user_depositable_assets, v0), 15);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg1.user_depositable_assets, v0).allow_withdraws, 22);
        let v1 = 0x1::type_name::get<T2>();
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::witness_has_bulk_withdraw_cap<T1>(arg3, 0x1::type_name::into_string(v1)), 4);
        let v2 = 0x2::coin::value<T1>(&arg4);
        assert!(!(v2 == 0), 14);
        let v3 = try_from_u256_to_u64((v2 as u256) * (0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::get_rate_safe<T0, T1>(arg2, arg7, arg8, arg9, arg10) as u256) / (0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::get_one_share<T1>(arg2) as u256));
        assert!(v3 >= arg5, 33);
        let v4 = get_balance_mut<T0, T1>(arg1);
        assert!(v3 <= 0x2::balance::value<T0>(v4), 11);
        let v5 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v4, v3), arg11);
        let v6 = treasury_cap_mut<T1>(arg1);
        0x2::coin::burn<T1>(v6, arg4);
        0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::update_total_shares<T1>(arg2, 0x2::coin::total_supply<T1>(v6));
        let v7 = BulkWithdrawEvent<T0, T1>{
            witness         : v1,
            shares          : v2,
            assets_returned : v3,
        };
        0x2::event::emit<BulkWithdrawEvent<T0, T1>>(v7);
        v5
    }

    public fun cancel_withdraw_by_req_id<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut QueueKey, arg2: &0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_vault<T1>(arg0, arg2, arg1.account);
        borrow_withdrawal_request_by_key<T1>(arg0, arg1);
        assert!(arg1.account == 0x2::tx_context::sender(arg3), 30);
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, 0x1::type_name::get_with_original_ids<T0>()), 15);
        let v0 = remove_withdrawal_request_by_key<T1>(arg0, *arg1);
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
        let v9 = 0x2::table::borrow_mut<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&mut arg0.user_depositable_assets, v6);
        let v10 = 0x2::balance::value<T1>(&v8);
        if (v9.withdraw_capacity < 18446744073709551615) {
            assert!(v9.withdraw_capacity <= 18446744073709551615 - v10, 24);
            v9.withdraw_capacity = v9.withdraw_capacity + v10;
            let v11 = WithdrawCapacityUpdatedEvent<T0, T1>{withdraw_capacity: v9.withdraw_capacity};
            0x2::event::emit<WithdrawCapacityUpdatedEvent<T0, T1>>(v11);
        };
        let v12 = WithdrawRequestCancelledEvent<T0, T1>{
            user       : arg1.account,
            shares     : v10,
            request_id : *arg1,
        };
        0x2::event::emit<WithdrawRequestCancelledEvent<T0, T1>>(v12);
        0x2::coin::from_balance<T1>(v8, arg3)
    }

    public fun cancel_withdraw_by_req_id_and_transfer<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut QueueKey, arg2: &0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = cancel_withdraw_by_req_id<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun claim_fees<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::Accountant<T1>, arg2: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T1, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::ClaimerCap>(arg2, 0x2::tx_context::sender(arg3)), 4);
        assert!(!is_vault_paused<T1>(arg0), 7);
        assert!(arg0.version == 0, 32);
        assert!(!0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::is_paused<T1>(arg1), 27);
        let v0 = 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::get_fees_owed_in_base<T1>(arg1);
        assert!(v0 != 0, 28);
        0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::reset_fees_owed_in_base<T1>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(get_balance_mut<T0, T1>(arg0), v0), arg3), 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::get_payout_address<T1>(arg1));
        let v1 = FeesClaimedEvent<T1>{fees_owed: v0};
        0x2::event::emit<FeesClaimedEvent<T1>>(v1);
    }

    public fun complete_withdraw<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::Accountant<T1>, arg2: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T1>, arg3: address, arg4: &mut 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: &0x2::clock::Clock, arg6: &0x2::deny_list::DenyList, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::oracle::PriceFeedsMap<T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert_vault<T1>(arg0, arg6, arg3);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0), 15);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0).allow_withdraws, 22);
        let v1 = pop_front_withdrawal_request<T0, T1>(arg0, arg3);
        process_withdrawal_fulfillment<T0, T1>(arg0, arg1, arg2, v1, arg3, arg4, arg5, arg7, arg8, arg9, arg10);
    }

    public fun complete_withdraw_by_request_id<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::Accountant<T1>, arg2: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T1>, arg3: &mut QueueKey, arg4: &mut 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: &0x2::clock::Clock, arg6: &0x2::deny_list::DenyList, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::oracle::PriceFeedsMap<T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert_vault<T1>(arg0, arg6, arg3.account);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0), 15);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0).allow_withdraws, 22);
        let v1 = remove_withdrawal_request_by_key<T1>(arg0, *arg3);
        process_withdrawal_fulfillment<T0, T1>(arg0, arg1, arg2, v1, arg3.account, arg4, arg5, arg7, arg8, arg9, arg10);
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

    public(friend) fun deny_cap_mut<T0>(arg0: &mut Vault<T0>) : &mut 0x2::coin::DenyCapV2<T0> {
        0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::DenyCapV2<T0>>(&mut arg0.id, b"deny_cap")
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::Accountant<T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::deny_list::DenyList, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::oracle::PriceFeedsMap<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_vault<T1>(arg0, arg4, 0x2::tx_context::sender(arg9));
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0), 15);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0).allow_deposits, 21);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 3);
        let v2 = (v1 as u256) * (0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::get_one_share<T1>(arg1) as u256) / (0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::get_rate_safe<T0, T1>(arg1, arg5, arg6, arg7, arg8) as u256);
        let v3 = v2;
        let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&mut arg0.user_depositable_assets, v0);
        if (v4.share_premium > 0) {
            v3 = v2 * (((10000 - v4.share_premium) as u64) as u256) / 10000;
        };
        let v5 = try_from_u256_to_u64(v3);
        assert!(v5 >= arg3, 2);
        let v6 = treasury_cap<T1>(arg0);
        if (arg0.deposit_limit != 18446744073709551615) {
            assert!(0x2::coin::total_supply<T1>(v6) <= 18446744073709551615 - v5, 24);
            assert!(0x2::coin::total_supply<T1>(v6) + v5 <= arg0.deposit_limit, 35);
        };
        let v7 = get_balance_mut<T0, T1>(arg0);
        0x2::balance::join<T0>(v7, 0x2::coin::into_balance<T0>(arg2));
        let v8 = treasury_cap_mut<T1>(arg0);
        0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::update_total_shares<T1>(arg1, 0x2::coin::total_supply<T1>(v8));
        let v9 = DepositEvent<T0, T1>{
            user                : 0x2::tx_context::sender(arg9),
            asset_amount        : v1,
            shares_value_minted : v5,
        };
        0x2::event::emit<DepositEvent<T0, T1>>(v9);
        0x2::coin::mint<T1>(v8, v5, arg9)
    }

    public fun deposit_and_transfer<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::Accountant<T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::deny_list::DenyList, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::oracle::PriceFeedsMap<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg9));
    }

    public fun disable_global_pause<T0>(arg0: &mut Vault<T0>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T0>, arg2: &mut 0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T0, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        0x2::coin::deny_list_v2_disable_global_pause<T0>(arg2, deny_cap_mut<T0>(arg0), arg3);
    }

    public fun enable_global_pause<T0>(arg0: &mut Vault<T0>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T0>, arg2: &mut 0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T0, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        0x2::coin::deny_list_v2_enable_global_pause<T0>(arg2, deny_cap_mut<T0>(arg0), arg3);
    }

    public fun get_balance<T0, T1>(arg0: &Vault<T1>) : &0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets_balance, v0), 15);
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.assets_balance, v0)
    }

    public(friend) fun get_balance_mut<T0, T1>(arg0: &mut Vault<T1>) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets_balance, v0), 15);
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets_balance, v0)
    }

    public(friend) fun id<T0>(arg0: &Vault<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun is_address_denied<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1)
    }

    public fun is_global_pause_enabled<T0>(arg0: &0x2::deny_list::DenyList) : bool {
        0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<T0>(arg0)
    }

    public fun is_vault_paused<T0>(arg0: &Vault<T0>) : bool {
        arg0.is_vault_paused
    }

    entry fun migrate_vault<T0>(arg0: &mut Vault<T0>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T0, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg2)), 4);
        arg0.version = 0;
        let v0 = VersionUpdatedEvent{version: 0};
        0x2::event::emit<VersionUpdatedEvent>(v0);
    }

    public fun ms_to_maturity<T0, T1>(arg0: &Vault<T1>) : u64 {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0), 15);
        0x2::table::borrow<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0).ms_to_maturity
    }

    public(friend) fun new_vault<T0>(arg0: &mut 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T0>, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::DenyCapV2<T0>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        let v0 = Vault<T0>{
            id                        : 0x2::object::new(arg7),
            assets_balance            : 0x2::bag::new(arg7),
            user_depositable_assets   : 0x2::table::new<0x1::type_name::TypeName, UserDepositableAsset<T0>>(arg7),
            withdrawal_requests       : 0x2::linked_table::new<QueueKey, WithdrawalRequest<T0>>(arg7),
            requests_per_address      : 0x2::table::new<AddressTypeKey, vector<QueueKey>>(arg7),
            is_vault_paused           : false,
            allow_self_solvers        : arg3,
            allow_third_party_solvers : arg4,
            excess_to_solver          : arg5,
            deposit_limit             : arg6,
            version                   : 0,
        };
        0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::add_cap<T0, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::OwnerCap>(arg0, 0x2::tx_context::sender(arg7), 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::new_owner_cap());
        let v1 = &mut v0;
        add_treasury_cap<T0>(v1, arg1);
        let v2 = &mut v0;
        add_deny_cap<T0>(v2, arg2);
        let v3 = NewVaultCreatedEvent<T0>{dummy_field: false};
        0x2::event::emit<NewVaultCreatedEvent<T0>>(v3);
        v0
    }

    public fun pause_vault_operations<T0>(arg0: &mut Vault<T0>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T0, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        arg0.is_vault_paused = arg2;
        let v0 = VaultOperationsPauseToggledEvent<T0>{new_is_paused: arg2};
        0x2::event::emit<VaultOperationsPauseToggledEvent<T0>>(v0);
    }

    public(friend) fun pop_front_withdrawal_request<T0, T1>(arg0: &mut Vault<T1>, arg1: address) : WithdrawalRequest<T1> {
        let v0 = AddressTypeKey{
            account    : arg1,
            asset_type : 0x1::type_name::get_with_original_ids<T0>(),
        };
        assert!(0x2::table::contains<AddressTypeKey, vector<QueueKey>>(&arg0.requests_per_address, v0), 10);
        let v1 = 0x2::table::borrow_mut<AddressTypeKey, vector<QueueKey>>(&mut arg0.requests_per_address, v0);
        if (0x1::vector::is_empty<QueueKey>(v1)) {
            0x2::table::remove<AddressTypeKey, vector<QueueKey>>(&mut arg0.requests_per_address, v0);
        };
        0x2::linked_table::remove<QueueKey, WithdrawalRequest<T1>>(&mut arg0.withdrawal_requests, 0x1::vector::remove<QueueKey>(v1, 0))
    }

    fun process_withdrawal_fulfillment<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::Accountant<T1>, arg2: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T1>, arg3: WithdrawalRequest<T1>, arg4: address, arg5: &mut 0x1::option::Option<0x2::coin::Coin<T0>>, arg6: &0x2::clock::Clock, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::oracle::PriceFeedsMap<T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.asset_type == 0x1::type_name::get_with_original_ids<T0>(), 29);
        if (arg4 == 0x2::tx_context::sender(arg10)) {
            assert!(arg0.allow_self_solvers, 31);
        } else {
            assert!(arg0.allow_third_party_solvers, 13);
            assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T1, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::SolverCap>(arg2, 0x2::tx_context::sender(arg10)), 4);
        };
        let v0 = 0x2::balance::value<T1>(&arg3.shares);
        assert!(!(v0 == 0), 14);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = arg3.creation_time_ms + arg3.ms_to_maturity;
        assert!(v1 >= v2, 8);
        assert!(v1 < v2 + arg3.ms_to_deadline, 26);
        let v3 = try_from_u256_to_u64((v0 as u256) * (0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::get_rate_safe<T0, T1>(arg1, arg7, arg8, arg9, arg6) as u256) / (0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::get_one_share<T1>(arg1) as u256));
        let v4 = arg3.amount_of_assets;
        let v5 = arg0.excess_to_solver;
        let v6 = get_balance_mut<T0, T1>(arg0);
        assert!(v3 <= 0x2::balance::value<T0>(v6), 11);
        let v7 = 0;
        let v8 = 0;
        let v9 = if (v3 >= v4) {
            let v9 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, v4), arg10);
            let v10 = v3 - v4;
            v7 = v10;
            let v11 = if (v10 > 0) {
                if (0x2::tx_context::sender(arg10) != arg4) {
                    v5
                } else {
                    false
                }
            } else {
                false
            };
            if (v11) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, v10), arg10), 0x2::tx_context::sender(arg10));
            };
            v9
        } else {
            let v9 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, v3), arg10);
            let v12 = v4 - v3;
            v8 = v12;
            assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(arg5) && 0x2::coin::value<T0>(0x1::option::borrow<0x2::coin::Coin<T0>>(arg5)) >= v12, 9);
            0x2::coin::join<T0>(&mut v9, 0x2::coin::split<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(arg5), v12, arg10));
            v9
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, arg4);
        let WithdrawalRequest {
            shares                           : v13,
            amount_of_assets                 : v14,
            creation_time_ms                 : _,
            ms_to_maturity                   : _,
            ms_to_deadline                   : _,
            asset_type                       : _,
            exchange_rate_at_time_of_request : _,
        } = arg3;
        let v20 = treasury_cap_mut<T1>(arg0);
        0x2::coin::burn<T1>(v20, 0x2::coin::from_balance<T1>(v13, arg10));
        0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::update_total_shares<T1>(arg1, 0x2::coin::total_supply<T1>(v20));
        let v21 = WithdrawCompletedEvent<T0, T1>{
            user            : arg4,
            shares          : v0,
            assets_returned : v14,
            excess          : v7,
            deficit         : v8,
        };
        0x2::event::emit<WithdrawCompletedEvent<T0, T1>>(v21);
    }

    fun push_back_withdrawal_request<T0, T1>(arg0: &mut Vault<T1>, arg1: address, arg2: u64, arg3: WithdrawalRequest<T1>) : QueueKey {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        let v1 = QueueKey{
            account    : arg1,
            asset_type : v0,
            timestamp  : arg2,
        };
        assert!(!0x2::linked_table::contains<QueueKey, WithdrawalRequest<T1>>(&arg0.withdrawal_requests, v1), 16);
        0x2::linked_table::push_back<QueueKey, WithdrawalRequest<T1>>(&mut arg0.withdrawal_requests, v1, arg3);
        let v2 = AddressTypeKey{
            account    : arg1,
            asset_type : v0,
        };
        if (!0x2::table::contains<AddressTypeKey, vector<QueueKey>>(&arg0.requests_per_address, v2)) {
            0x2::table::add<AddressTypeKey, vector<QueueKey>>(&mut arg0.requests_per_address, v2, 0x1::vector::empty<QueueKey>());
        };
        0x1::vector::push_back<QueueKey>(0x2::table::borrow_mut<AddressTypeKey, vector<QueueKey>>(&mut arg0.requests_per_address, v2), v1);
        v1
    }

    public fun remove_address_from_deny_list<T0>(arg0: &mut Vault<T0>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T0>, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T0, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg4)), 4);
        0x2::coin::deny_list_v2_remove<T0>(arg2, deny_cap_mut<T0>(arg0), arg3, arg4);
    }

    public fun remove_user_depositable_asset_type<T0, T1>(arg0: &mut Vault<T1>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T1, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg2)), 4);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0), 15);
        let UserDepositableAsset {
            allow_withdraws        : _,
            allow_deposits         : _,
            share_premium          : _,
            ms_to_maturity         : _,
            minimum_ms_to_deadline : _,
            min_discount           : _,
            max_discount           : _,
            minimum_shares         : _,
            withdraw_capacity      : _,
        } = 0x2::table::remove<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&mut arg0.user_depositable_assets, v0);
        let v10 = UserDepositableAssetRemoved<T0, T1>{dummy_field: false};
        0x2::event::emit<UserDepositableAssetRemoved<T0, T1>>(v10);
    }

    public(friend) fun remove_withdrawal_request_by_key<T0>(arg0: &mut Vault<T0>, arg1: QueueKey) : WithdrawalRequest<T0> {
        assert!(0x2::linked_table::contains<QueueKey, WithdrawalRequest<T0>>(&arg0.withdrawal_requests, arg1), 10);
        let v0 = AddressTypeKey{
            account    : arg1.account,
            asset_type : arg1.asset_type,
        };
        assert!(0x2::table::contains<AddressTypeKey, vector<QueueKey>>(&arg0.requests_per_address, v0), 15);
        let v1 = 0x2::table::borrow_mut<AddressTypeKey, vector<QueueKey>>(&mut arg0.requests_per_address, v0);
        let (v2, v3) = 0x1::vector::index_of<QueueKey>(v1, &arg1);
        assert!(v2, 15);
        0x1::vector::remove<QueueKey>(v1, v3);
        if (0x1::vector::is_empty<QueueKey>(v1)) {
            0x2::table::remove<AddressTypeKey, vector<QueueKey>>(&mut arg0.requests_per_address, v0);
        };
        0x2::linked_table::remove<QueueKey, WithdrawalRequest<T0>>(&mut arg0.withdrawal_requests, arg1)
    }

    public fun request_withdraw<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::Accountant<T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::deny_list::DenyList, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::oracle::PriceFeedsMap<T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert_vault<T1>(arg0, arg6, 0x2::tx_context::sender(arg10));
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0), 15);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&mut arg0.user_depositable_assets, v0);
        assert!(v1.allow_withdraws, 22);
        assert!(arg3 >= v1.min_discount, 20);
        assert!(arg3 <= v1.max_discount, 20);
        assert!(0x2::coin::value<T1>(&arg2) >= v1.minimum_shares, 2);
        assert!(arg4 >= v1.minimum_ms_to_deadline, 25);
        if (v1.withdraw_capacity < 18446744073709551615) {
            assert!(v1.withdraw_capacity >= 0x2::coin::value<T1>(&arg2), 23);
            v1.withdraw_capacity = v1.withdraw_capacity - 0x2::coin::value<T1>(&arg2);
            let v2 = WithdrawCapacityUpdatedEvent<T0, T1>{withdraw_capacity: v1.withdraw_capacity};
            0x2::event::emit<WithdrawCapacityUpdatedEvent<T0, T1>>(v2);
        };
        let v3 = 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::get_rate_safe<T0, T1>(arg1, arg7, arg8, arg9, arg5);
        let v4 = 0x2::coin::value<T1>(&arg2);
        let v5 = 0x2::clock::timestamp_ms(arg5);
        let v6 = WithdrawalRequest<T1>{
            shares                           : 0x2::coin::into_balance<T1>(arg2),
            amount_of_assets                 : try_from_u256_to_u64((v4 as u256) * (v3 as u256) * ((10000 - arg3) as u256) / 10000 / (0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::get_one_share<T1>(arg1) as u256)),
            creation_time_ms                 : v5,
            ms_to_maturity                   : v1.ms_to_maturity,
            ms_to_deadline                   : arg4,
            asset_type                       : v0,
            exchange_rate_at_time_of_request : v3,
        };
        let v7 = WithdrawRequestedEvent<T0, T1>{
            user             : 0x2::tx_context::sender(arg10),
            shares           : v4,
            creation_time_ms : v5,
            req_key          : push_back_withdrawal_request<T0, T1>(arg0, 0x2::tx_context::sender(arg10), v5, v6),
        };
        0x2::event::emit<WithdrawRequestedEvent<T0, T1>>(v7);
    }

    public fun set_allow_self_solvers<T0>(arg0: &mut Vault<T0>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T0, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        arg0.allow_self_solvers = arg2;
        let v0 = SelfSolverPolicyChanged<T0>{allow_self_solvers: arg2};
        0x2::event::emit<SelfSolverPolicyChanged<T0>>(v0);
    }

    public fun set_allow_third_party_solvers<T0>(arg0: &mut Vault<T0>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T0, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        arg0.allow_third_party_solvers = arg2;
        let v0 = ThirdPartySolverPolicyChanged<T0>{allow_third_party_solvers: arg2};
        0x2::event::emit<ThirdPartySolverPolicyChanged<T0>>(v0);
    }

    public fun set_deposit_limit<T0>(arg0: &mut Vault<T0>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T0, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        arg0.deposit_limit = arg2;
        let v0 = DepositLimitChanged<T0>{deposit_limit: arg2};
        0x2::event::emit<DepositLimitChanged<T0>>(v0);
    }

    public fun share<T0>(arg0: Vault<T0>) {
        0x2::transfer::share_object<Vault<T0>>(arg0);
    }

    public(friend) fun treasury_cap<T0>(arg0: &Vault<T0>) : &0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_object_field::borrow<vector<u8>, 0x2::coin::TreasuryCap<T0>>(&arg0.id, b"treasury_cap")
    }

    public(friend) fun treasury_cap_mut<T0>(arg0: &mut Vault<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, b"treasury_cap")
    }

    fun try_from_u256_to_u64(arg0: u256) : u64 {
        let v0 = 0x1::u256::try_as_u64(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 24);
        0x1::option::extract<u64>(&mut v0)
    }

    public fun update_user_depositable_asset_type<T0, T1>(arg0: &mut Vault<T1>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T1>, arg2: bool, arg3: bool, arg4: u16, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T1, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg11)), 4);
        validate_new_user_depositable_asset(arg4, arg5, arg6, arg7, arg8);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0), 15);
        let v1 = UserDepositableAsset<T1>{
            allow_withdraws        : arg2,
            allow_deposits         : arg3,
            share_premium          : arg4,
            ms_to_maturity         : arg5,
            minimum_ms_to_deadline : arg6,
            min_discount           : arg7,
            max_discount           : arg8,
            minimum_shares         : arg9,
            withdraw_capacity      : arg10,
        };
        let UserDepositableAsset {
            allow_withdraws        : _,
            allow_deposits         : _,
            share_premium          : _,
            ms_to_maturity         : _,
            minimum_ms_to_deadline : _,
            min_discount           : _,
            max_discount           : _,
            minimum_shares         : _,
            withdraw_capacity      : _,
        } = 0x2::table::remove<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&mut arg0.user_depositable_assets, v0);
        0x2::table::add<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&mut arg0.user_depositable_assets, v0, v1);
        let v11 = UserDepositableAssetUpdatedEvent<T0, T1>{
            allow_withdraws        : arg2,
            allow_deposits         : arg3,
            ms_to_maturity         : arg5,
            minimum_ms_to_deadline : arg6,
            min_discount           : arg7,
            max_discount           : arg8,
            minimum_shares         : arg9,
            withdraw_capacity      : arg10,
        };
        0x2::event::emit<UserDepositableAssetUpdatedEvent<T0, T1>>(v11);
    }

    public fun update_withdraw_capacity<T0, T1>(arg0: &mut Vault<T1>, arg1: &0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::Auth<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::has_cap<T1, 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0), 15);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&mut arg0.user_depositable_assets, v0);
        v1.withdraw_capacity = arg2;
        let v2 = WithdrawCapacityUpdatedEvent<T0, T1>{withdraw_capacity: v1.withdraw_capacity};
        0x2::event::emit<WithdrawCapacityUpdatedEvent<T0, T1>>(v2);
    }

    public fun user_depositable_asset_exists<T0, T1>(arg0: &Vault<T1>) : bool {
        0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, 0x1::type_name::get_with_original_ids<T0>())
    }

    fun validate_new_user_depositable_asset(arg0: u16, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0 <= 1000, 12);
        assert!(arg4 <= 3000, 17);
        assert!(arg1 <= 2592000000, 18);
        assert!(arg2 <= 2592000000, 19);
        assert!(arg3 <= arg4, 20);
    }

    public fun withdraw_capacity<T0, T1>(arg0: &Vault<T1>) : u64 {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0), 15);
        0x2::table::borrow<0x1::type_name::TypeName, UserDepositableAsset<T1>>(&arg0.user_depositable_assets, v0).withdraw_capacity
    }

    // decompiled from Move bytecode v6
}

