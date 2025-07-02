module 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::boring_vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        assets_balance: 0x2::bag::Bag,
        depositable_assets: 0x2::table::Table<0x1::type_name::TypeName, DepositableAsset<T0>>,
        withdrawal_requests: 0x2::linked_table::LinkedTable<QueueKey, WithdrawalRequest<T0>>,
        requests_per_address: 0x2::table::Table<AddressTypeKey, vector<QueueKey>>,
        is_vault_paused: bool,
        allow_self_solvers: bool,
        allow_third_party_solvers: bool,
        excess_to_solver: bool,
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

    struct DepositableAsset<phantom T0> has store {
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
    }

    struct WithdrawCompletedEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        shares: u64,
        assets_returned: u64,
        excess: u64,
        deficit: u64,
    }

    struct NewNonDepositableAssetAddedEvent<phantom T0, phantom T1> has copy, drop {
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

    struct NewDepositableAssetAddedEvent<phantom T0, phantom T1> has copy, drop {
        ms_to_maturity: u64,
        minimum_ms_to_deadline: u64,
        min_discount: u64,
        max_discount: u64,
        minimum_shares: u64,
        withdraw_capacity: u64,
    }

    struct DepositableAssetUpdatedEvent<phantom T0, phantom T1> has copy, drop {
        allow_withdraws: bool,
        allow_deposits: bool,
        ms_to_maturity: u64,
        minimum_ms_to_deadline: u64,
        min_discount: u64,
        max_discount: u64,
        minimum_shares: u64,
        withdraw_capacity: u64,
    }

    struct VersionUpdatedEvent has copy, drop {
        version: u64,
    }

    fun add_deny_cap<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::DenyCapV2<T0>) {
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::DenyCapV2<T0>>(&mut arg0.id, b"deny_cap", arg1);
    }

    public fun add_new_asset_type<T0, T1>(arg0: &mut Vault<T1>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T1, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg2)), 4);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets_balance, v0), 6);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets_balance, v0, 0x2::balance::zero<T0>());
        let v1 = NewNonDepositableAssetAddedEvent<T0, T1>{dummy_field: false};
        0x2::event::emit<NewNonDepositableAssetAddedEvent<T0, T1>>(v1);
    }

    public fun add_new_depositable_asset_type<T0, T1>(arg0: &mut Vault<T1>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T1>, arg2: u16, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T1, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg9)), 4);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets_balance, v0), 6);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.assets_balance, v0, 0x2::balance::zero<T0>());
        assert!(arg2 <= 1000, 12);
        assert!(arg6 <= 3000, 17);
        assert!(arg3 <= 2592000000, 18);
        assert!(arg4 <= 2592000000, 19);
        assert!(arg5 <= arg6, 20);
        let v1 = DepositableAsset<T1>{
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
        0x2::table::add<0x1::type_name::TypeName, DepositableAsset<T1>>(&mut arg0.depositable_assets, v0, v1);
        let v2 = NewDepositableAssetAddedEvent<T0, T1>{
            ms_to_maturity         : arg3,
            minimum_ms_to_deadline : arg4,
            min_discount           : arg5,
            max_discount           : arg6,
            minimum_shares         : arg7,
            withdraw_capacity      : arg8,
        };
        0x2::event::emit<NewDepositableAssetAddedEvent<T0, T1>>(v2);
    }

    fun add_treasury_cap<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::TreasuryCap<T0>) {
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, b"treasury_cap", arg1);
    }

    public fun allow_self_solvers<T0>(arg0: &Vault<T0>) : bool {
        arg0.allow_self_solvers
    }

    public fun allow_third_party_solvers<T0>(arg0: &Vault<T0>) : bool {
        arg0.allow_third_party_solvers
    }

    fun assert_vault<T0>(arg0: &Vault<T0>, arg1: &0x2::deny_list::DenyList) {
        assert!(arg0.version == 0, 32);
        assert!(!is_vault_paused<T0>(arg0), 7);
        assert!(!is_global_pause_enabled<T0>(arg1), 1);
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

    public fun cancel_withdraw_by_req_id<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut QueueKey, arg2: &0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_vault<T1>(arg0, arg2);
        borrow_withdrawal_request_by_key<T1>(arg0, arg1);
        assert!(arg1.account == 0x2::tx_context::sender(arg3), 30);
        assert!(0x2::table::contains<0x1::type_name::TypeName, DepositableAsset<T1>>(&arg0.depositable_assets, 0x1::type_name::get_with_original_ids<T0>()), 15);
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
        let v9 = 0x2::table::borrow_mut<0x1::type_name::TypeName, DepositableAsset<T1>>(&mut arg0.depositable_assets, v6);
        let v10 = 0x2::balance::value<T1>(&v8);
        if (v9.withdraw_capacity < 18446744073709551615) {
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

    public fun claim_fees<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::Accountant<T1>, arg2: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T1, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::ClaimerCap>(arg2, 0x2::tx_context::sender(arg3)), 4);
        assert!(!is_vault_paused<T1>(arg0), 7);
        assert!(arg0.version == 0, 32);
        assert!(!0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::is_paused<T1>(arg1), 27);
        let v0 = 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::get_fees_owed_in_base<T1>(arg1);
        assert!(v0 != 0, 28);
        0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::reset_fees_owed_in_base<T1>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(get_balance_mut<T0, T1>(arg0), v0), arg3), 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::get_payout_address<T1>(arg1));
        let v1 = FeesClaimedEvent<T1>{fees_owed: v0};
        0x2::event::emit<FeesClaimedEvent<T1>>(v1);
    }

    public fun complete_withdraw<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::Accountant<T1>, arg2: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T1>, arg3: address, arg4: &mut 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: &0x2::clock::Clock, arg6: &0x2::deny_list::DenyList, arg7: &mut 0x2::tx_context::TxContext) {
        assert_vault<T1>(arg0, arg6);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, DepositableAsset<T1>>(&arg0.depositable_assets, v0), 15);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, DepositableAsset<T1>>(&arg0.depositable_assets, v0).allow_withdraws, 22);
        let v1 = pop_front_withdrawal_request<T0, T1>(arg0, arg3);
        process_withdrawal_fulfillment<T0, T1>(arg0, arg1, arg2, v1, arg3, arg4, arg5, arg7);
    }

    public fun complete_withdraw_by_request_id<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::Accountant<T1>, arg2: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T1>, arg3: &mut QueueKey, arg4: &mut 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: &0x2::clock::Clock, arg6: &0x2::deny_list::DenyList, arg7: &mut 0x2::tx_context::TxContext) {
        assert_vault<T1>(arg0, arg6);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, DepositableAsset<T1>>(&arg0.depositable_assets, v0), 15);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, DepositableAsset<T1>>(&arg0.depositable_assets, v0).allow_withdraws, 22);
        let v1 = remove_withdrawal_request_by_key<T1>(arg0, *arg3);
        process_withdrawal_fulfillment<T0, T1>(arg0, arg1, arg2, v1, arg3.account, arg4, arg5, arg7);
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

    public fun deposit<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::Accountant<T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::deny_list::DenyList, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_vault<T1>(arg0, arg4);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, DepositableAsset<T1>>(&arg0.depositable_assets, v0), 15);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, DepositableAsset<T1>>(&arg0.depositable_assets, v0).allow_deposits, 21);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 3);
        let v2 = (v1 as u256) * (0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::get_one_share<T1>(arg1) as u256) / (0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::get_rate_safe<T1>(arg1) as u256);
        let v3 = v2;
        let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, DepositableAsset<T1>>(&mut arg0.depositable_assets, v0);
        if (v4.share_premium > 0) {
            v3 = v2 * (((10000 - v4.share_premium) as u64) as u256) / 10000;
        };
        let v5 = 0x1::u256::try_as_u64(v3);
        assert!(0x1::option::is_some<u64>(&v5), 24);
        let v6 = 0x1::option::extract<u64>(&mut v5);
        assert!(v6 >= arg3, 2);
        let v7 = get_balance_mut<T0, T1>(arg0);
        0x2::balance::join<T0>(v7, 0x2::coin::into_balance<T0>(arg2));
        let v8 = treasury_cap_mut<T1>(arg0);
        0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::update_total_shares<T1>(arg1, 0x2::coin::total_supply<T1>(v8));
        let v9 = DepositEvent<T0, T1>{
            user                : 0x2::tx_context::sender(arg5),
            asset_amount        : v1,
            shares_value_minted : v6,
        };
        0x2::event::emit<DepositEvent<T0, T1>>(v9);
        0x2::coin::mint<T1>(v8, v6, arg5)
    }

    public fun deposit_and_transfer<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::Accountant<T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::deny_list::DenyList, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun disable_global_pause<T0>(arg0: &mut Vault<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: &mut 0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        0x2::coin::deny_list_v2_disable_global_pause<T0>(arg2, deny_cap_mut<T0>(arg0), arg3);
    }

    public fun enable_global_pause<T0>(arg0: &mut Vault<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: &mut 0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
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

    public fun is_global_pause_enabled<T0>(arg0: &0x2::deny_list::DenyList) : bool {
        0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<T0>(arg0)
    }

    public fun is_vault_paused<T0>(arg0: &Vault<T0>) : bool {
        arg0.is_vault_paused
    }

    entry fun migrate_vault<T0>(arg0: &mut Vault<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg2)), 4);
        arg0.version = 0;
        let v0 = VersionUpdatedEvent{version: 0};
        0x2::event::emit<VersionUpdatedEvent>(v0);
    }

    public fun ms_to_maturity<T0, T1>(arg0: &Vault<T1>) : u64 {
        0x2::table::borrow<0x1::type_name::TypeName, DepositableAsset<T1>>(&arg0.depositable_assets, 0x1::type_name::get_with_original_ids<T0>()).ms_to_maturity
    }

    public(friend) fun new_vault<T0>(arg0: &mut 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::DenyCapV2<T0>, arg3: bool, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        let v0 = Vault<T0>{
            id                        : 0x2::object::new(arg6),
            assets_balance            : 0x2::bag::new(arg6),
            depositable_assets        : 0x2::table::new<0x1::type_name::TypeName, DepositableAsset<T0>>(arg6),
            withdrawal_requests       : 0x2::linked_table::new<QueueKey, WithdrawalRequest<T0>>(arg6),
            requests_per_address      : 0x2::table::new<AddressTypeKey, vector<QueueKey>>(arg6),
            is_vault_paused           : false,
            allow_self_solvers        : arg3,
            allow_third_party_solvers : arg4,
            excess_to_solver          : arg5,
            version                   : 0,
        };
        0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::add_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg0, 0x2::tx_context::sender(arg6), 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::new_owner_cap());
        let v1 = &mut v0;
        add_treasury_cap<T0>(v1, arg1);
        let v2 = &mut v0;
        add_deny_cap<T0>(v2, arg2);
        let v3 = NewVaultCreatedEvent<T0>{dummy_field: false};
        0x2::event::emit<NewVaultCreatedEvent<T0>>(v3);
        v0
    }

    public fun pause_vault_operations<T0>(arg0: &mut Vault<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
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

    fun process_withdrawal_fulfillment<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::Accountant<T1>, arg2: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T1>, arg3: WithdrawalRequest<T1>, arg4: address, arg5: &mut 0x1::option::Option<0x2::coin::Coin<T0>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.asset_type == 0x1::type_name::get_with_original_ids<T0>(), 29);
        if (arg4 == 0x2::tx_context::sender(arg7)) {
            assert!(arg0.allow_self_solvers, 31);
        } else {
            assert!(arg0.allow_third_party_solvers, 13);
            assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T1, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::SolverCap>(arg2, 0x2::tx_context::sender(arg7)), 4);
        };
        let v0 = 0x2::balance::value<T1>(&arg3.shares);
        assert!(!(v0 == 0), 14);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = arg3.creation_time_ms + arg3.ms_to_maturity;
        assert!(v1 >= v2, 8);
        assert!(v1 < v2 + arg3.ms_to_deadline, 26);
        let v3 = 0x1::u256::try_as_u64((v0 as u256) * (0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::get_rate_safe<T1>(arg1) as u256) / (0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::get_one_share<T1>(arg1) as u256));
        assert!(0x1::option::is_some<u64>(&v3), 24);
        let v4 = 0x1::option::extract<u64>(&mut v3);
        let v5 = arg3.amount_of_assets;
        assert!(v4 <= 0x2::balance::value<T0>(get_balance<T0, T1>(arg0)), 11);
        let v6 = 0;
        let v7 = 0;
        let v8 = if (v4 >= v5) {
            let v9 = get_balance_mut<T0, T1>(arg0);
            let v8 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v9, v5), arg7);
            let v10 = v4 - v5;
            v6 = v10;
            let v11 = if (v10 > 0) {
                if (0x2::tx_context::sender(arg7) != arg4) {
                    arg0.excess_to_solver
                } else {
                    false
                }
            } else {
                false
            };
            if (v11) {
                let v12 = get_balance_mut<T0, T1>(arg0);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v12, v10), arg7), 0x2::tx_context::sender(arg7));
            };
            v8
        } else {
            let v13 = get_balance_mut<T0, T1>(arg0);
            let v8 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v13, v4), arg7);
            let v14 = v5 - v4;
            v7 = v14;
            assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(arg5) && 0x2::coin::value<T0>(0x1::option::borrow<0x2::coin::Coin<T0>>(arg5)) >= v14, 9);
            0x2::coin::join<T0>(&mut v8, 0x2::coin::split<T0>(0x1::option::borrow_mut<0x2::coin::Coin<T0>>(arg5), v14, arg7));
            v8
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, arg4);
        let WithdrawalRequest {
            shares                           : v15,
            amount_of_assets                 : v16,
            creation_time_ms                 : _,
            ms_to_maturity                   : _,
            ms_to_deadline                   : _,
            asset_type                       : _,
            exchange_rate_at_time_of_request : _,
        } = arg3;
        let v22 = treasury_cap_mut<T1>(arg0);
        0x2::coin::burn<T1>(v22, 0x2::coin::from_balance<T1>(v15, arg7));
        0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::update_total_shares<T1>(arg1, 0x2::coin::total_supply<T1>(v22));
        let v23 = WithdrawCompletedEvent<T0, T1>{
            user            : arg4,
            shares          : v0,
            assets_returned : v16,
            excess          : v6,
            deficit         : v7,
        };
        0x2::event::emit<WithdrawCompletedEvent<T0, T1>>(v23);
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

    public fun request_withdraw<T0, T1>(arg0: &mut Vault<T1>, arg1: &mut 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::Accountant<T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::deny_list::DenyList, arg7: &mut 0x2::tx_context::TxContext) : QueueKey {
        assert_vault<T1>(arg0, arg6);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, DepositableAsset<T1>>(&arg0.depositable_assets, v0), 15);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, DepositableAsset<T1>>(&mut arg0.depositable_assets, v0);
        assert!(v1.allow_withdraws, 22);
        assert!(arg3 >= v1.min_discount && arg3 <= v1.max_discount, 20);
        assert!(0x2::coin::value<T1>(&arg2) >= v1.minimum_shares, 2);
        assert!(arg4 >= v1.minimum_ms_to_deadline, 25);
        if (v1.withdraw_capacity < 18446744073709551615) {
            assert!(v1.withdraw_capacity >= 0x2::coin::value<T1>(&arg2), 23);
            v1.withdraw_capacity = v1.withdraw_capacity - 0x2::coin::value<T1>(&arg2);
            let v2 = WithdrawCapacityUpdatedEvent<T0, T1>{withdraw_capacity: v1.withdraw_capacity};
            0x2::event::emit<WithdrawCapacityUpdatedEvent<T0, T1>>(v2);
        };
        let v3 = 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::get_rate_safe<T1>(arg1);
        let v4 = 0x2::coin::value<T1>(&arg2);
        let v5 = 0x2::clock::timestamp_ms(arg5);
        let v6 = 0x1::u256::try_as_u64((v4 as u256) * (v3 as u256) * ((10000 - arg3) as u256) / 10000 / (0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant::get_one_share<T1>(arg1) as u256));
        assert!(0x1::option::is_some<u64>(&v6), 24);
        let v7 = WithdrawalRequest<T1>{
            shares                           : 0x2::coin::into_balance<T1>(arg2),
            amount_of_assets                 : 0x1::option::extract<u64>(&mut v6),
            creation_time_ms                 : v5,
            ms_to_maturity                   : v1.ms_to_maturity,
            ms_to_deadline                   : arg4,
            asset_type                       : v0,
            exchange_rate_at_time_of_request : v3,
        };
        let v8 = WithdrawRequestedEvent<T0, T1>{
            user             : 0x2::tx_context::sender(arg7),
            shares           : v4,
            creation_time_ms : v5,
        };
        0x2::event::emit<WithdrawRequestedEvent<T0, T1>>(v8);
        push_back_withdrawal_request<T0, T1>(arg0, 0x2::tx_context::sender(arg7), v5, v7)
    }

    public fun set_allow_self_solvers<T0>(arg0: &mut Vault<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        arg0.allow_self_solvers = arg2;
        let v0 = SelfSolverPolicyChanged<T0>{allow_self_solvers: arg2};
        0x2::event::emit<SelfSolverPolicyChanged<T0>>(v0);
    }

    public fun set_allow_third_party_solvers<T0>(arg0: &mut Vault<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        arg0.allow_third_party_solvers = arg2;
        let v0 = ThirdPartySolverPolicyChanged<T0>{allow_third_party_solvers: arg2};
        0x2::event::emit<ThirdPartySolverPolicyChanged<T0>>(v0);
    }

    public fun share<T0>(arg0: Vault<T0>) {
        0x2::transfer::share_object<Vault<T0>>(arg0);
    }

    public(friend) fun treasury_cap_mut<T0>(arg0: &mut Vault<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, b"treasury_cap")
    }

    public fun update_depositable_asset_type<T0, T1>(arg0: &mut Vault<T1>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T1>, arg2: bool, arg3: bool, arg4: u16, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T1, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg11)), 4);
        assert!(arg4 <= 1000, 12);
        assert!(arg8 <= 3000, 17);
        assert!(arg5 <= 2592000000, 18);
        assert!(arg6 <= 2592000000, 19);
        assert!(arg7 <= arg8, 20);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets_balance, v0), 15);
        let v1 = DepositableAsset<T1>{
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
        if (0x2::table::contains<0x1::type_name::TypeName, DepositableAsset<T1>>(&arg0.depositable_assets, v0)) {
            let DepositableAsset {
                allow_withdraws        : _,
                allow_deposits         : _,
                share_premium          : _,
                ms_to_maturity         : _,
                minimum_ms_to_deadline : _,
                min_discount           : _,
                max_discount           : _,
                minimum_shares         : _,
                withdraw_capacity      : _,
            } = 0x2::table::remove<0x1::type_name::TypeName, DepositableAsset<T1>>(&mut arg0.depositable_assets, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, DepositableAsset<T1>>(&mut arg0.depositable_assets, v0, v1);
        let v11 = DepositableAssetUpdatedEvent<T0, T1>{
            allow_withdraws        : arg2,
            allow_deposits         : arg3,
            ms_to_maturity         : arg5,
            minimum_ms_to_deadline : arg6,
            min_discount           : arg7,
            max_discount           : arg8,
            minimum_shares         : arg9,
            withdraw_capacity      : arg10,
        };
        0x2::event::emit<DepositableAssetUpdatedEvent<T0, T1>>(v11);
    }

    public fun update_withdraw_capacity<T0, T1>(arg0: &mut Vault<T1>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T1, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, DepositableAsset<T1>>(&arg0.depositable_assets, v0), 15);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, DepositableAsset<T1>>(&mut arg0.depositable_assets, v0);
        v1.withdraw_capacity = arg2;
        let v2 = WithdrawCapacityUpdatedEvent<T0, T1>{withdraw_capacity: v1.withdraw_capacity};
        0x2::event::emit<WithdrawCapacityUpdatedEvent<T0, T1>>(v2);
    }

    public fun withdraw_capacity<T0, T1>(arg0: &Vault<T1>) : u64 {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, DepositableAsset<T1>>(&arg0.depositable_assets, v0), 15);
        0x2::table::borrow<0x1::type_name::TypeName, DepositableAsset<T1>>(&arg0.depositable_assets, v0).withdraw_capacity
    }

    // decompiled from Move bytecode v6
}

