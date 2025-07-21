module 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        assets_balance: 0x2::bag::Bag,
        user_depositable_assets: 0x2::table::Table<0x1::type_name::TypeName, UserDepositableAsset<T0>>,
        is_vault_paused: bool,
        allow_self_solvers: bool,
        allow_third_party_solvers: bool,
        excess_to_solver: bool,
        deposit_limit: u64,
        version: u64,
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

    public fun add_address_to_deny_list<T0>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg4)), 4);
        0x2::coin::deny_list_v2_add<T0>(arg2, deny_cap_mut<T0>(arg0), arg3, arg4);
    }

    public fun add_asset_type<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg2)), 4);
        let v0 = 0x1::type_name::get_with_original_ids<T1>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets_balance, v0), 5);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.assets_balance, v0, 0x2::balance::zero<T1>());
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_non_user_depositable_asset_added_event<T0, T1>();
    }

    fun add_deny_cap<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::DenyCapV2<T0>) {
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::DenyCapV2<T0>>(&mut arg0.id, b"deny_cap", arg1);
    }

    fun add_treasury_cap<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::TreasuryCap<T0>) {
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, b"treasury_cap", arg1);
    }

    public fun add_user_depositable_asset_type<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: u16, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg9)), 4);
        let v0 = 0x1::type_name::get_with_original_ids<T1>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&arg0.user_depositable_assets, v0), 5);
        validate_new_user_depositable_asset(arg2, arg3, arg4, arg5, arg6);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets_balance, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.assets_balance, v0, 0x2::balance::zero<T1>());
        };
        let v1 = UserDepositableAsset<T0>{
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
        0x2::table::add<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&mut arg0.user_depositable_assets, v0, v1);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_user_depositable_asset_added_event<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun allow_deposits<T0>(arg0: &UserDepositableAsset<T0>) : bool {
        arg0.allow_deposits
    }

    public fun allow_self_solvers<T0>(arg0: &Vault<T0>) : bool {
        arg0.allow_self_solvers
    }

    public fun allow_third_party_solvers<T0>(arg0: &Vault<T0>) : bool {
        arg0.allow_third_party_solvers
    }

    public fun allow_withdraws<T0>(arg0: &UserDepositableAsset<T0>) : bool {
        arg0.allow_withdraws
    }

    public(friend) fun assert_asset_withdrawal_constraints<T0>(arg0: &mut Vault<T0>, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&mut arg0.user_depositable_assets, arg1);
        assert!(v0.allow_withdraws, 14);
        assert!(arg2 >= v0.min_discount, 12);
        assert!(arg2 <= v0.max_discount, 12);
        assert!(arg3 >= v0.minimum_shares, 2);
        assert!(arg4 >= v0.minimum_ms_to_deadline, 16);
    }

    public(friend) fun assert_vault<T0>(arg0: &Vault<T0>, arg1: &0x2::deny_list::DenyList, arg2: address) {
        assert!(arg0.version == 0, 19);
        assert!(!is_vault_paused<T0>(arg0), 6);
        assert!(!is_global_pause_enabled<T0>(arg1), 1);
        assert!(!is_address_denied<T0>(arg1, arg2), 20);
    }

    public fun asset_exists<T0>(arg0: &Vault<T0>, arg1: 0x1::type_name::TypeName) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets_balance, arg1)
    }

    public fun bulk_withdraw<T0, T1, T2: drop>(arg0: T2, arg1: &mut Vault<T0>, arg2: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::Accountant<T0>, arg3: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::deny_list::DenyList, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::PriceFeedsMap<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_vault<T0>(arg1, arg6, 0x2::tx_context::sender(arg11));
        let v0 = 0x1::type_name::get_with_original_ids<T1>();
        assert!(user_depositable_asset_exists<T0>(arg1, v0), 8);
        assert!(allow_withdraws<T0>(user_depositable_asset_info<T0>(arg1, v0)), 14);
        let v1 = 0x1::type_name::get<T2>();
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::witness_has_bulk_withdraw_cap<T0>(arg3, 0x1::type_name::into_string(v1)), 4);
        let v2 = 0x2::coin::value<T0>(&arg4);
        assert!(!(v2 == 0), 23);
        let v3 = try_from_u256_to_u64((v2 as u256) * (0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::get_rate_safe<T0, T1>(arg2, arg7, arg8, arg9, arg10) as u256) / (0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::get_one_share<T0>(arg2) as u256));
        assert!(v3 >= arg5, 22);
        let v4 = get_balance_mut<T0, T1>(arg1);
        assert!(v3 <= 0x2::balance::value<T1>(v4), 24);
        let v5 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v4, v3), arg11);
        let v6 = treasury_cap_mut<T0>(arg1);
        0x2::coin::burn<T0>(v6, arg4);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::update_total_shares<T0>(arg2, 0x2::coin::total_supply<T0>(v6));
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_bulk_withdraw_event<T0, T1>(v1, v2, v3);
        v5
    }

    public fun claim_fees<T0, T1>(arg0: &mut Vault<T0>, arg1: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::Accountant<T0>, arg2: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::get_base_asset_type<T0>(arg1) == 0x1::type_name::get_with_original_ids<T1>(), 25);
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::ClaimerCap>(arg2, 0x2::tx_context::sender(arg3)), 4);
        assert!(!is_vault_paused<T0>(arg0), 6);
        assert!(arg0.version == 0, 19);
        assert!(!0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::is_paused<T0>(arg1), 17);
        let v0 = 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::get_fees_owed_in_base<T0>(arg1);
        assert!(v0 != 0, 18);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::reset_fees_owed_in_base<T0>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(get_balance_mut<T0, T1>(arg0), v0), arg3), 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::get_payout_address<T0>(arg1));
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_fees_claimed_event<T0>(v0);
    }

    public(friend) fun deny_cap_mut<T0>(arg0: &mut Vault<T0>) : &mut 0x2::coin::DenyCapV2<T0> {
        0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::DenyCapV2<T0>>(&mut arg0.id, b"deny_cap")
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0>, arg1: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::Accountant<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::deny_list::DenyList, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::PriceFeedsMap<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_vault<T0>(arg0, arg4, 0x2::tx_context::sender(arg9));
        let v0 = 0x1::type_name::get_with_original_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&arg0.user_depositable_assets, v0), 8);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&arg0.user_depositable_assets, v0).allow_deposits, 13);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0, 3);
        let v2 = (v1 as u256) * (0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::get_one_share<T0>(arg1) as u256) / (0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::get_rate_safe<T0, T1>(arg1, arg5, arg6, arg7, arg8) as u256);
        let v3 = v2;
        let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&mut arg0.user_depositable_assets, v0);
        if (v4.share_premium > 0) {
            v3 = v2 * (((10000 - v4.share_premium) as u64) as u256) / 10000;
        };
        let v5 = try_from_u256_to_u64(v3);
        assert!(v5 >= arg3, 2);
        let v6 = treasury_cap<T0>(arg0);
        if (arg0.deposit_limit != 18446744073709551615) {
            assert!(0x2::coin::total_supply<T0>(v6) <= 18446744073709551615 - v5, 15);
            assert!(0x2::coin::total_supply<T0>(v6) + v5 <= arg0.deposit_limit, 21);
        };
        let v7 = get_balance_mut<T0, T1>(arg0);
        0x2::balance::join<T1>(v7, 0x2::coin::into_balance<T1>(arg2));
        let v8 = treasury_cap_mut<T0>(arg0);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::update_total_shares<T0>(arg1, 0x2::coin::total_supply<T0>(v8));
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_deposit_event<T0, T1>(0x2::tx_context::sender(arg9), v1, v5);
        0x2::coin::mint<T0>(v8, v5, arg9)
    }

    public fun deposit_and_transfer<T0, T1>(arg0: &mut Vault<T0>, arg1: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::Accountant<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::deny_list::DenyList, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::PriceFeedsMap<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg9));
    }

    public fun disable_global_pause<T0>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: &mut 0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        0x2::coin::deny_list_v2_disable_global_pause<T0>(arg2, deny_cap_mut<T0>(arg0), arg3);
    }

    public fun enable_global_pause<T0>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: &mut 0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        0x2::coin::deny_list_v2_enable_global_pause<T0>(arg2, deny_cap_mut<T0>(arg0), arg3);
    }

    public fun excess_to_solver<T0>(arg0: &Vault<T0>) : bool {
        arg0.excess_to_solver
    }

    public fun get_balance<T0, T1>(arg0: &Vault<T0>) : &0x2::balance::Balance<T1> {
        let v0 = 0x1::type_name::get_with_original_ids<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets_balance, v0), 8);
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.assets_balance, v0)
    }

    public(friend) fun get_balance_mut<T0, T1>(arg0: &mut Vault<T0>) : &mut 0x2::balance::Balance<T1> {
        let v0 = 0x1::type_name::get_with_original_ids<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.assets_balance, v0), 8);
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.assets_balance, v0)
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

    entry fun migrate_vault<T0>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg2)), 4);
        arg0.version = 0;
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_version_vault_updated_event<T0>(0);
    }

    public fun ms_to_maturity<T0>(arg0: &UserDepositableAsset<T0>) : u64 {
        arg0.ms_to_maturity
    }

    public(friend) fun new_vault<T0>(arg0: &mut 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::DenyCapV2<T0>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        let v0 = Vault<T0>{
            id                        : 0x2::object::new(arg7),
            assets_balance            : 0x2::bag::new(arg7),
            user_depositable_assets   : 0x2::table::new<0x1::type_name::TypeName, UserDepositableAsset<T0>>(arg7),
            is_vault_paused           : false,
            allow_self_solvers        : arg3,
            allow_third_party_solvers : arg4,
            excess_to_solver          : arg5,
            deposit_limit             : arg6,
            version                   : 0,
        };
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::add_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg0, 0x2::tx_context::sender(arg7), 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::new_owner_cap());
        let v1 = &mut v0;
        add_treasury_cap<T0>(v1, arg1);
        let v2 = &mut v0;
        add_deny_cap<T0>(v2, arg2);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_vault_created_event<T0>();
        v0
    }

    public fun pause_vault_operations<T0>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        arg0.is_vault_paused = arg2;
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_vault_operations_pause_toggled_event<T0>(arg2);
    }

    public fun remove_address_from_deny_list<T0>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg4)), 4);
        0x2::coin::deny_list_v2_remove<T0>(arg2, deny_cap_mut<T0>(arg0), arg3, arg4);
    }

    public fun remove_user_depositable_asset_type<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg2)), 4);
        let v0 = 0x1::type_name::get_with_original_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&arg0.user_depositable_assets, v0), 8);
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
        } = 0x2::table::remove<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&mut arg0.user_depositable_assets, v0);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_user_depositable_asset_removed_event<T0, T1>();
    }

    public fun set_allow_self_solvers<T0>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        arg0.allow_self_solvers = arg2;
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_self_solver_policy_changed_event<T0>(arg2);
    }

    public fun set_allow_third_party_solvers<T0>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        arg0.allow_third_party_solvers = arg2;
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_third_party_solver_policy_changed_event<T0>(arg2);
    }

    public fun set_deposit_limit<T0>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        arg0.deposit_limit = arg2;
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_deposit_limit_changed_event<T0>(arg2);
    }

    public(friend) fun set_withdraw_capacity<T0, T1>(arg0: &mut UserDepositableAsset<T0>, arg1: u64) {
        arg0.withdraw_capacity = arg1;
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_withdraw_capacity_updated_event<T0, T1>(arg0.withdraw_capacity);
    }

    public(friend) fun set_withdraw_queue<T0, T1: store + key>(arg0: &mut Vault<T0>, arg1: T1) {
        0x2::dynamic_object_field::add<vector<u8>, T1>(&mut arg0.id, b"withdraw_queue", arg1);
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

    public(friend) fun try_from_u256_to_u64(arg0: u256) : u64 {
        let v0 = 0x1::u256::try_as_u64(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 15);
        0x1::option::extract<u64>(&mut v0)
    }

    public fun update_user_depositable_asset_type<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: bool, arg3: bool, arg4: u16, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg11)), 4);
        validate_new_user_depositable_asset(arg4, arg5, arg6, arg7, arg8);
        let v0 = 0x1::type_name::get_with_original_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&arg0.user_depositable_assets, v0), 8);
        let v1 = UserDepositableAsset<T0>{
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
        } = 0x2::table::remove<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&mut arg0.user_depositable_assets, v0);
        0x2::table::add<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&mut arg0.user_depositable_assets, v0, v1);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_user_depositable_asset_updated_event<T0, T1>(arg2, arg3, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun update_withdraw_capacity<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        let v0 = 0x1::type_name::get_with_original_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&arg0.user_depositable_assets, v0), 8);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&mut arg0.user_depositable_assets, v0);
        v1.withdraw_capacity = arg2;
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_withdraw_capacity_updated_event<T0, T1>(v1.withdraw_capacity);
    }

    public fun user_depositable_asset_exists<T0>(arg0: &Vault<T0>, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&arg0.user_depositable_assets, arg1)
    }

    public fun user_depositable_asset_info<T0>(arg0: &Vault<T0>, arg1: 0x1::type_name::TypeName) : &UserDepositableAsset<T0> {
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&arg0.user_depositable_assets, arg1), 8);
        0x2::table::borrow<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&arg0.user_depositable_assets, arg1)
    }

    public(friend) fun user_depositable_asset_info_mut<T0>(arg0: &mut Vault<T0>, arg1: 0x1::type_name::TypeName) : &mut UserDepositableAsset<T0> {
        assert!(0x2::table::contains<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&arg0.user_depositable_assets, arg1), 8);
        0x2::table::borrow_mut<0x1::type_name::TypeName, UserDepositableAsset<T0>>(&mut arg0.user_depositable_assets, arg1)
    }

    fun validate_new_user_depositable_asset(arg0: u16, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0 <= 1000, 7);
        assert!(arg4 <= 3000, 9);
        assert!(arg1 <= 2592000000, 10);
        assert!(arg2 <= 2592000000, 11);
        assert!(arg3 <= arg4, 12);
    }

    public fun withdraw_capacity<T0>(arg0: &UserDepositableAsset<T0>) : u64 {
        arg0.withdraw_capacity
    }

    public(friend) fun withdraw_queue<T0, T1: store + key>(arg0: &Vault<T0>) : &T1 {
        0x2::dynamic_object_field::borrow<vector<u8>, T1>(&arg0.id, b"withdraw_queue")
    }

    public(friend) fun withdraw_queue_mut<T0, T1: store + key>(arg0: &mut Vault<T0>) : &mut T1 {
        0x2::dynamic_object_field::borrow_mut<vector<u8>, T1>(&mut arg0.id, b"withdraw_queue")
    }

    // decompiled from Move bytecode v6
}

