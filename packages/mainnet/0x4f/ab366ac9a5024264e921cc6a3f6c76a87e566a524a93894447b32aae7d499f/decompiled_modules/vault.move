module 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::vault {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        version: u64,
        lp_supply: 0x2::balance::Supply<T0>,
        total_deposited_collateral: u64,
        ch_ids: vector<0x2::object::ID>,
        paused: 0x1::option::Option<u64>,
        last_paused_timestamp_ms: u64,
        vault_params: VaultParams,
    }

    struct VaultParams has store {
        lock_period: u64,
        owner_fee_rate: u256,
        force_withdraw_delay: u64,
        min_pause_vault_for_force_withdraw_frequency_ms: u64,
        collateral_pfs_id: 0x2::object::ID,
        collateral_pfs_source_id: 0x2::object::ID,
        collateral_pfs_tolerance: u64,
        max_force_withdraw_mr_tolerance: u256,
        min_mr_tolerance_ratio: u256,
        min_force_withdraw_position_usd: u256,
        scaling_factor: u256,
        max_markets_in_vault: u64,
        max_pending_orders_per_position: u64,
        max_total_deposited_collateral: u64,
    }

    struct DepositSession<phantom T0, phantom T1> {
        vault: Vault<T0, T1>,
        account: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>,
        sender: address,
        timestamp_ms: u64,
        collateral_price: u256,
        ch_ids: vector<0x2::object::ID>,
        vault_balance_value: u256,
        provided_balance: 0x2::balance::Balance<T1>,
    }

    struct WithdrawRequest<phantom T0> has store {
        user_lp_coin: UserLpCoin<T0>,
        request_timestamp_ms: u64,
        min_expected_balance_out: u64,
    }

    struct WithdrawSession<phantom T0, phantom T1> {
        vault: Vault<T0, T1>,
        account: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>,
        sender: address,
        collateral_price: u256,
        ch_ids: vector<0x2::object::ID>,
        user_lp_coin: UserLpCoin<T0>,
        vault_balance_value: u256,
        accumulated_slippage: u256,
        can_force_process: bool,
        min_expected_balance_out: u64,
    }

    struct VaultOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct UserLpCoin<phantom T0> has store, key {
        id: 0x2::object::UID,
        lp_balance: 0x2::balance::Balance<T0>,
        start_timestamp_ms: u64,
        provided_value_usd: u256,
    }

    struct VAULT has drop {
        dummy_field: bool,
    }

    public fun id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun max_markets_in_vault<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.vault_params.max_markets_in_vault
    }

    public fun max_pending_orders_per_position<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.vault_params.max_pending_orders_per_position
    }

    public fun version<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.version
    }

    public(friend) fun account_cap<T0, T1>(arg0: &Vault<T0, T1>) : &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::AccountCap<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN> {
        0x2::dynamic_object_field::borrow<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::AccountCapKey, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::AccountCap<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>>(&arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::account_cap_key())
    }

    public(friend) fun account_cap_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::AccountCap<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN> {
        0x2::dynamic_object_field::borrow_mut<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::AccountCapKey, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::AccountCap<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>>(&mut arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::account_cap_key())
    }

    public(friend) fun add_stop_order_ticket_dof<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::StopOrderTicket<T1>) {
        0x2::dynamic_object_field::add<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::StopOrderTicketKey, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::StopOrderTicket<T1>>(&mut arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::stop_order_ticket(0x2::object::id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::StopOrderTicket<T1>>(&arg1)), arg1);
    }

    public(friend) fun add_yield<T0, T1>(arg0: &Vault<T0, T1>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: 0x2::coin::Coin<T1>) {
        assert!(arg0.version == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        let v0 = account_cap<T0, T1>(arg0);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::check_valid_account_cap<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(arg1, v0);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::deposit_collateral<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(v0, arg1, arg2);
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_add_yield_event(id<T0, T1>(arg0), 0x2::coin::value<T1>(&arg2), arg0.total_deposited_collateral);
    }

    public(friend) fun admin_pause_vault_for_force_withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: address) {
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert_withdraw_request_exists<T0, T1>(arg0, arg2);
        assert!(0x2::dynamic_field::borrow<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::withdraw_request(arg2)).request_timestamp_ms + arg0.vault_params.force_withdraw_delay <= 0x2::clock::timestamp_ms(arg1), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::force_withdraw_delay_not_passed());
        arg0.paused = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1) + 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::force_withdraw_pause_ms());
    }

    fun assert_base_price_feed_storage_is_correct(arg0: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg1: &0x2::object::ID) {
        let v0 = 0x2::object::id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage>(arg0);
        assert!(arg1 == &v0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::wrong_base_oracle());
    }

    fun assert_collateral_price_feed_storage_is_correct(arg0: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg1: &0x2::object::ID) {
        let v0 = 0x2::object::id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage>(arg0);
        assert!(arg1 == &v0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::wrong_collateral_oracle());
    }

    fun assert_minimum_owner_locked_liquidity(arg0: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg1: 0x2::object::ID, arg2: u64, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock, arg5: u64, arg6: u256) {
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(arg5, arg6), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::oracle::get_price(arg0, arg3, arg4, arg1, arg2)), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::min_owner_lock_usd()), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::owner_locked_amount_not_enough());
    }

    fun assert_minimum_user_deposit<T0, T1>(arg0: &Vault<T0, T1>, arg1: u256, arg2: u64) {
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(arg2, arg0.vault_params.scaling_factor), arg1), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::min_deposit_usd()), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::user_deposit_amount_not_enough());
    }

    fun assert_vault_creation_parameters_are_valid(arg0: u64, arg1: u256, arg2: u64) {
        assert!(arg0 <= 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::max_lock_period(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_lock_period());
        assert!(arg2 <= 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::max_force_withdraw_delay(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_force_withdraw_delay());
        assert!(!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg1) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg1, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::max_owner_fee_rate()), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_owner_fee_rate());
    }

    public(friend) fun assert_vault_is_not_paused<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        if (0x1::option::is_some<u64>(&arg0.paused)) {
            assert!(*0x1::option::borrow<u64>(&arg0.paused) <= 0x2::clock::timestamp_ms(arg1), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::vault_temporarily_paused());
        };
    }

    fun assert_withdraw_request_does_not_already_exist<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) {
        assert!(!0x2::dynamic_field::exists_<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::WithdrawRequestKey>(&arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::withdraw_request(arg1)), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::withdraw_request_already_exists());
    }

    fun assert_withdraw_request_exists<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) {
        assert!(0x2::dynamic_field::exists_<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::WithdrawRequestKey>(&arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::withdraw_request(arg1)), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::withdraw_request_does_not_exist());
    }

    fun burn_lp_balance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::decrease_supply<T0>(&mut arg0.lp_supply, arg1);
    }

    public fun ch_ids<T0, T1>(arg0: &Vault<T0, T1>) : vector<0x2::object::ID> {
        arg0.ch_ids
    }

    public(friend) fun ch_ids_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut vector<0x2::object::ID> {
        &mut arg0.ch_ids
    }

    fun create_deposit_session<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: address, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u256) : DepositSession<T0, T1> {
        DepositSession<T0, T1>{
            vault               : arg0,
            account             : arg1,
            sender              : arg2,
            timestamp_ms        : arg4,
            collateral_price    : arg5,
            ch_ids              : ch_ids<T0, T1>(&arg0),
            vault_balance_value : 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_collateral_value<T1>(&arg1), arg0.vault_params.scaling_factor), arg5),
            provided_balance    : arg3,
        }
    }

    public(friend) fun create_vault<T0, T1>(arg0: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::registry::Registry, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: u64, arg6: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg7: &0x2::clock::Clock, arg8: u64, arg9: u256, arg10: u64, arg11: 0x2::coin::Coin<T1>, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: 0x1::option::Option<0x1::ascii::String>, arg15: 0x1::option::Option<0x1::ascii::String>, arg16: 0x1::option::Option<0x1::ascii::String>, arg17: 0x1::option::Option<vector<0x1::ascii::String>>, arg18: 0x1::option::Option<vector<0x1::ascii::String>>, arg19: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::non_zero_total_supply());
        assert!(0x2::coin::get_decimals<T0>(arg3) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::lp_decimals(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_lp_decimals());
        assert_vault_creation_parameters_are_valid(arg8, arg9, arg10);
        let (v0, v1, v2) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::registry::get_collateral_info<T1>(arg0);
        assert!(v0 == 0x2::object::id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage>(arg4), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::wrong_collateral_oracle());
        assert_minimum_owner_locked_liquidity(arg4, v1, arg5, arg6, arg7, 0x2::coin::value<T1>(&arg11), v2);
        let v3 = VaultParams{
            lock_period                                     : arg8,
            owner_fee_rate                                  : arg9,
            force_withdraw_delay                            : arg10,
            min_pause_vault_for_force_withdraw_frequency_ms : 1800000,
            collateral_pfs_id                               : v0,
            collateral_pfs_source_id                        : v1,
            collateral_pfs_tolerance                        : arg5,
            max_force_withdraw_mr_tolerance                 : 5000000000000000,
            min_mr_tolerance_ratio                          : 50000000000000,
            min_force_withdraw_position_usd                 : 5000000000000000000,
            scaling_factor                                  : v2,
            max_markets_in_vault                            : 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::max_markets_in_vault(),
            max_pending_orders_per_position                 : 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::max_pending_orders_per_position(),
            max_total_deposited_collateral                  : 18446744073709551615,
        };
        let v4 = Vault<T0, T1>{
            id                         : 0x2::object::new(arg19),
            version                    : 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(),
            lp_supply                  : 0x2::coin::treasury_into_supply<T0>(arg2),
            total_deposited_collateral : 0x2::coin::value<T1>(&arg11),
            ch_ids                     : 0x1::vector::empty<0x2::object::ID>(),
            paused                     : 0x1::option::none<u64>(),
            last_paused_timestamp_ms   : 0,
            vault_params               : v3,
        };
        let v5 = 0x2::tx_context::sender(arg19);
        let v6 = id<T0, T1>(&v4);
        let v7 = give_vault_owner_capability<T0>(v6, v5, arg19);
        let (v8, v9, v10) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::create_and_return_account<T1>(arg0, arg19);
        let v11 = v10;
        let v12 = v8;
        let v13 = 0x2::coin::value<T1>(&arg11);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::deposit_collateral<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&v11, &mut v12, arg11);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::consume_policy_and_share_account<T1>(v12, v9);
        0x2::dynamic_object_field::add<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::AccountCapKey, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::AccountCap<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>>(&mut v4.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::account_cap_key(), v11);
        0x2::dynamic_field::add<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::OwnerFeesKey, 0x2::balance::Balance<T1>>(&mut v4.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::owner_fees_key(), 0x2::balance::zero<T1>());
        let v14 = &mut v4;
        0x2::dynamic_field::add<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::OwnerLockedLpCoinKey, 0x2::balance::Balance<T0>>(&mut v4.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::owner_user_lp_coin_key(), mint_lp_balance<T0, T1>(v14, v13));
        let v15 = 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::metadata::new<T0>(&mut v4.id, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        0x2::coin_registry::migrate_legacy_metadata<T0>(arg1, arg3, arg19);
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_created_vault_event(v6, 0x2::object::id<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::metadata::VaultMetadata<T0>>(&v15), v7, v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())), v13, v5, arg8);
        0x2::transfer::share_object<Vault<T0, T1>>(v4);
        0x2::transfer::public_share_object<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::metadata::VaultMetadata<T0>>(v15);
    }

    public(friend) fun create_withdraw_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: UserLpCoin<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(arg3 != 0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::withdraw_amount_zero());
        assert!(0x2::balance::value<T0>(&arg1.lp_balance) >= arg3, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::withdraw_amount_too_big());
        let v0 = 0x2::tx_context::sender(arg5);
        assert_withdraw_request_does_not_already_exist<T0, T1>(arg0, v0);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.start_timestamp_ms + arg0.vault_params.lock_period <= v1, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::lock_period_not_passed());
        let v2 = if (0x2::balance::value<T0>(&arg1.lp_balance) == arg3) {
            WithdrawRequest<T0>{user_lp_coin: arg1, request_timestamp_ms: v1, min_expected_balance_out: arg4}
        } else {
            let v3 = &mut arg1;
            0x2::transfer::public_transfer<UserLpCoin<T0>>(arg1, v0);
            WithdrawRequest<T0>{user_lp_coin: split_user_lp_coin<T0>(v3, arg3, arg5), request_timestamp_ms: v1, min_expected_balance_out: arg4}
        };
        0x2::dynamic_field::add<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::withdraw_request(v0), v2);
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_create_withdraw_request(id<T0, T1>(arg0), v0, arg3, arg4);
    }

    fun create_withdraw_session<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: address, arg3: UserLpCoin<T0>, arg4: u256, arg5: bool, arg6: u64) : WithdrawSession<T0, T1> {
        WithdrawSession<T0, T1>{
            vault                    : arg0,
            account                  : arg1,
            sender                   : arg2,
            collateral_price         : arg4,
            ch_ids                   : ch_ids<T0, T1>(&arg0),
            user_lp_coin             : arg3,
            vault_balance_value      : 0,
            accumulated_slippage     : 0,
            can_force_process        : arg5,
            min_expected_balance_out : arg6,
        }
    }

    public(friend) fun end_deposit_session<T0, T1>(arg0: DepositSession<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : UserLpCoin<T0> {
        let DepositSession {
            vault               : v0,
            account             : v1,
            sender              : v2,
            timestamp_ms        : v3,
            collateral_price    : v4,
            ch_ids              : v5,
            vault_balance_value : v6,
            provided_balance    : v7,
        } = arg0;
        let v8 = v7;
        let v9 = v5;
        let v10 = v1;
        let v11 = v0;
        assert!(version<T0, T1>(&v11) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(0x1::vector::length<0x2::object::ID>(&v9) == 0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::not_all_chs_processed());
        let v12 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(0x2::balance::value<T1>(&v8), v11.vault_params.scaling_factor), v4);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::deposit_collateral<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(account_cap<T0, T1>(&v11), &mut v10, 0x2::coin::from_balance<T1>(v8, arg2));
        let v13 = multiply_by_rational_ifixed(v12, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(lp_supply_value<T0, T1>(&v11), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling()), v6);
        assert!(!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v13), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::user_lp_calculation_negative());
        let v14 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(v13, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling());
        assert!(v14 != 0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::user_lp_calculation_zero());
        let v15 = &mut v11;
        let v16 = mint_lp_balance<T0, T1>(v15, v14);
        let v17 = 0x2::balance::value<T0>(&v16);
        assert!(v17 >= arg1, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::slippage_check());
        let v18 = UserLpCoin<T0>{
            id                 : 0x2::object::new(arg2),
            lp_balance         : v16,
            start_timestamp_ms : v3,
            provided_value_usd : v12,
        };
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_user_deposit(id<T0, T1>(&v11), v2, 0x2::balance::value<T1>(&v8), v17, v6);
        0x2::transfer::public_share_object<Vault<T0, T1>>(v11);
        0x2::transfer::public_share_object<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>>(v10);
        v18
    }

    public(friend) fun end_withdraw_session<T0, T1>(arg0: WithdrawSession<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.sender == 0x2::tx_context::sender(arg1), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_sender());
        let WithdrawSession {
            vault                    : v0,
            account                  : v1,
            sender                   : v2,
            collateral_price         : v3,
            ch_ids                   : v4,
            user_lp_coin             : v5,
            vault_balance_value      : v6,
            accumulated_slippage     : v7,
            can_force_process        : v8,
            min_expected_balance_out : v9,
        } = arg0;
        let v10 = v4;
        let v11 = v1;
        let v12 = v0;
        let UserLpCoin {
            id                 : v13,
            lp_balance         : v14,
            start_timestamp_ms : _,
            provided_value_usd : v16,
        } = v5;
        let v17 = v14;
        0x2::object::delete(v13);
        assert!(0x1::vector::length<0x2::object::ID>(&v10) == 0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::not_all_chs_processed());
        assert!(version<T0, T1>(&v12) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        let v18 = v12.vault_params.scaling_factor;
        let v19 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(multiply_by_rational_ifixed(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(0x2::balance::value<T0>(&v17), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling()), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_collateral_value<T1>(&v11), v18), v3), v6), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::neg(v7)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(lp_supply_value<T0, T1>(&v12), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling())), v7);
        assert!(!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v19), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::slippage_check());
        let v20 = &mut v12;
        burn_lp_balance<T0, T1>(v20, v17);
        let v21 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::withdraw_collateral<T1>(account_cap<T0, T1>(&v12), &mut v11, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v19, v3), v18), arg1);
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(v12.vault_params.owner_fee_rate, 0) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(v19, v16)) {
            let v22 = &mut v12;
            0x2::balance::join<T1>(owner_fees_mut<T0, T1>(v22), 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut v21), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v19, v16), v12.vault_params.owner_fee_rate), v3), v18)));
        };
        let v23 = 0x2::coin::value<T1>(&v21);
        assert!(v23 >= v9, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::slippage_check());
        v12.total_deposited_collateral = v12.total_deposited_collateral - 0x1::u64::min(v12.total_deposited_collateral, v23);
        0x2::transfer::public_share_object<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>>(v11);
        if (v8) {
            0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_user_force_withdraw(id<T0, T1>(&v12), v2, 0x2::balance::value<T0>(&v17), v23, v6);
            v12.paused = 0x1::option::none<u64>();
        } else {
            0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_owner_withdraw(id<T0, T1>(&v12), v2, 0x2::balance::value<T0>(&v17), v23, v6);
        };
        0x2::transfer::public_share_object<Vault<T0, T1>>(v12);
        v21
    }

    public(friend) fun end_withdraw_session_and_transfer_to_recipient<T0, T1>(arg0: WithdrawSession<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let WithdrawSession {
            vault                    : v0,
            account                  : v1,
            sender                   : v2,
            collateral_price         : v3,
            ch_ids                   : v4,
            user_lp_coin             : v5,
            vault_balance_value      : v6,
            accumulated_slippage     : v7,
            can_force_process        : v8,
            min_expected_balance_out : v9,
        } = arg0;
        let v10 = v4;
        let v11 = v1;
        let v12 = v0;
        let UserLpCoin {
            id                 : v13,
            lp_balance         : v14,
            start_timestamp_ms : _,
            provided_value_usd : v16,
        } = v5;
        let v17 = v14;
        0x2::object::delete(v13);
        assert!(0x1::vector::length<0x2::object::ID>(&v10) == 0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::not_all_chs_processed());
        assert!(version<T0, T1>(&v12) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        let v18 = v12.vault_params.scaling_factor;
        let v19 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(multiply_by_rational_ifixed(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(0x2::balance::value<T0>(&v17), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling()), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_collateral_value<T1>(&v11), v18), v3), v6), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::neg(v7)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(lp_supply_value<T0, T1>(&v12), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling())), v7);
        assert!(!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v19), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::slippage_check());
        let v20 = &mut v12;
        burn_lp_balance<T0, T1>(v20, v17);
        let v21 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::withdraw_collateral<T1>(account_cap<T0, T1>(&v12), &mut v11, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v19, v3), v18), arg1);
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(v12.vault_params.owner_fee_rate, 0) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(v19, v16)) {
            let v22 = &mut v12;
            0x2::balance::join<T1>(owner_fees_mut<T0, T1>(v22), 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut v21), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v19, v16), v12.vault_params.owner_fee_rate), v3), v18)));
        };
        let v23 = 0x2::coin::value<T1>(&v21);
        assert!(v23 >= v9, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::slippage_check());
        v12.total_deposited_collateral = v12.total_deposited_collateral - 0x1::u64::min(v12.total_deposited_collateral, v23);
        0x2::transfer::public_share_object<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>>(v11);
        if (v8) {
            0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_user_force_withdraw(id<T0, T1>(&v12), v2, 0x2::balance::value<T0>(&v17), v23, v6);
            v12.paused = 0x1::option::none<u64>();
        } else {
            0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_owner_withdraw(id<T0, T1>(&v12), v2, 0x2::balance::value<T0>(&v17), v23, v6);
        };
        0x2::transfer::public_share_object<Vault<T0, T1>>(v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v21, arg0.sender);
    }

    public fun force_withdraw_delay<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.vault_params.force_withdraw_delay
    }

    public(friend) fun get_mut_stop_order_ticket_dof<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID) : &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::StopOrderTicket<T1> {
        0x2::dynamic_object_field::borrow_mut<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::StopOrderTicketKey, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::StopOrderTicket<T1>>(&mut arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::stop_order_ticket(arg1))
    }

    public fun get_vault_margin_in_market<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : (u256, u256) {
        let (v0, v1) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_cum_funding_rates(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_market_state<T1>(arg1));
        let (v2, v3) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::compute_margin_with_fundings(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_position<T1>(arg1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(account_cap<T0, T1>(arg0))), arg3, arg2, arg4, v0, v1, arg5);
        let v4 = if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v2)) {
            0
        } else {
            v2
        };
        (v4, v3)
    }

    fun give_vault_owner_capability<T0>(arg0: 0x2::object::ID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = VaultOwnerCap<T0>{
            id       : v0,
            vault_id : arg0,
        };
        0x2::transfer::transfer<VaultOwnerCap<T0>>(v1, arg1);
        0x2::object::uid_to_inner(&v0)
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<VAULT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public(friend) fun join_user_lp_coin<T0>(arg0: &mut UserLpCoin<T0>, arg1: UserLpCoin<T0>) {
        let UserLpCoin {
            id                 : v0,
            lp_balance         : v1,
            start_timestamp_ms : v2,
            provided_value_usd : v3,
        } = arg1;
        0x2::balance::join<T0>(&mut arg0.lp_balance, v1);
        if (v2 > arg0.start_timestamp_ms) {
            arg0.start_timestamp_ms = v2;
        };
        arg0.provided_value_usd = arg0.provided_value_usd + v3;
        0x2::object::delete(v0);
    }

    public fun last_paused_timestamp_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.last_paused_timestamp_ms
    }

    public fun lock_period<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.vault_params.lock_period
    }

    public fun lp_supply_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.lp_supply)
    }

    public fun min_force_withdraw_position_usd<T0, T1>(arg0: &Vault<T0, T1>) : u256 {
        arg0.vault_params.min_force_withdraw_position_usd
    }

    public fun min_pause_vault_for_force_withdraw_frequency_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.vault_params.min_pause_vault_for_force_withdraw_frequency_ms
    }

    fun mint_lp_balance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, arg1)
    }

    fun multiply_by_rational_ifixed(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg2 != 0) {
            0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0, arg1), arg2)
        } else {
            0
        }
    }

    public fun owner_fee_rate<T0, T1>(arg0: &Vault<T0, T1>) : u256 {
        arg0.vault_params.owner_fee_rate
    }

    public fun owner_fees<T0, T1>(arg0: &Vault<T0, T1>) : &0x2::balance::Balance<T1> {
        0x2::dynamic_field::borrow<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::OwnerFeesKey, 0x2::balance::Balance<T1>>(&arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::owner_fees_key())
    }

    public(friend) fun owner_fees_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x2::balance::Balance<T1> {
        0x2::dynamic_field::borrow_mut<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::OwnerFeesKey, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::owner_fees_key())
    }

    public(friend) fun pause_vault_for_force_withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: address) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert_withdraw_request_exists<T0, T1>(arg0, arg2);
        assert!(0x2::dynamic_field::borrow<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::withdraw_request(arg2)).request_timestamp_ms + arg0.vault_params.force_withdraw_delay <= v0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::force_withdraw_delay_not_passed());
        arg0.paused = 0x1::option::some<u64>(v0 + 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::force_withdraw_pause_ms());
        assert!(arg0.last_paused_timestamp_ms + arg0.vault_params.min_pause_vault_for_force_withdraw_frequency_ms <= v0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::pause_vault_for_force_withdraw_too_frequent());
        arg0.last_paused_timestamp_ms = v0;
    }

    public(friend) fun process_clearing_house_for_deposit<T0, T1>(arg0: &mut DepositSession<T0, T1>, arg1: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock) {
        assert!(version<T0, T1>(&arg0.vault) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_market_params<T1>(&arg1);
        let v1 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_pfs_id(v0);
        assert_base_price_feed_storage_is_correct(arg2, &v1);
        let v2 = &mut arg0.ch_ids;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x2::object::ID>(v2)) {
            let v5 = 0x2::object::id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>>(&arg1);
            if (0x1::vector::borrow<0x2::object::ID>(v2, v3) == &v5) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 7 */
                if (0x1::option::is_none<u64>(&v4)) {
                    abort 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::clearing_house_id_not_found()
                };
                0x1::vector::remove<0x2::object::ID>(v2, 0x1::option::extract<u64>(&mut v4));
                let (v6, _) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::oracle::get_price(arg2, arg3, arg4, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_pfs_source_id(v0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_pfs_tolerance(v0)), arg0.collateral_price, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(1), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(1));
                arg0.vault_balance_value = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.vault_balance_value, v6);
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::share_clearing_house<T1>(arg1);
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 7 */
    }

    public(friend) fun process_clearing_house_for_force_withdraw<T0, T1>(arg0: &mut WithdrawSession<T0, T1>, arg1: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock, arg6: u64, arg7: &vector<u128>, arg8: &0x2::tx_context::TxContext) {
        assert!(version<T0, T1>(&arg0.vault) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(arg0.can_force_process, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::cannot_force_withdraw());
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_market_params<T1>(&arg1);
        let v1 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_pfs_id(v0);
        assert_base_price_feed_storage_is_correct(arg2, &v1);
        let v2 = &mut arg0.ch_ids;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x2::object::ID>(v2)) {
            let v5 = 0x2::object::id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>>(&arg1);
            if (0x1::vector::borrow<0x2::object::ID>(v2, v3) == &v5) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 10 */
                if (0x1::option::is_none<u64>(&v4)) {
                    abort 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::clearing_house_id_not_found()
                };
                0x1::vector::remove<0x2::object::ID>(v2, 0x1::option::extract<u64>(&mut v4));
                let v6 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_cap_account_id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(account_cap<T0, T1>(&arg0.vault));
                let v7 = arg0.vault.vault_params.max_force_withdraw_mr_tolerance;
                let v8 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_collateral_haircut(v0);
                let v9 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::oracle::get_price(arg2, arg4, arg5, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_pfs_source_id(v0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_pfs_tolerance(v0));
                let v10 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_margin_ratio_initial(v0);
                let (_, v12) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_maker_taker_fees(v0);
                let v13 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_market_state<T1>(&arg1);
                let (v14, v15) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_cum_funding_rates(v13);
                let (v16, _) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, v9, arg0.collateral_price, v10, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(1));
                let (v18, _) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, v9, arg0.collateral_price, v10, v8);
                let v20 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v16, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(0x2::balance::value<T0>(&arg0.user_lp_coin.lp_balance), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling()), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(lp_supply_value<T0, T1>(&arg0.vault), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling())));
                let v21 = v20;
                let v22 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_position<T1>(&arg1, v6);
                let (v23, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v22);
                let v25 = if (v23 != 0) {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v18, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::abs_net_base(v22), v9)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_position_upnl(v22, v9), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::calculate_position_funding_internal(v22, v14, v15)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v23), v9)), v10), v10))
                } else {
                    v10
                };
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::set_position_initial_margin_ratio<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &arg0.account, v10);
                if (0x1::vector::length<u128>(arg7) != 0) {
                    0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::cancel_orders<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &arg0.account, arg7);
                };
                let v26 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_position<T1>(&arg1, v6);
                let (v27, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v26);
                let (v29, v30) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_pending_amounts(v26);
                let v31 = if (v29 == 0) {
                    if (v30 == 0) {
                        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_pending_orders_counter(v26) == 0
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v31, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::wrong_order_ids_in_force_withdraw());
                let v32 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v27), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling());
                let v33 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v27), v9), arg0.vault.vault_params.min_force_withdraw_position_usd);
                let v34 = if (v33) {
                    v32
                } else {
                    0x1::u64::min(arg6, v32)
                };
                if (v34 != 0) {
                    let v35 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v27);
                    let v36 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::start_session<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(arg1, account_cap<T0, T1>(&arg0.vault), &arg0.account, arg2, arg3, arg4, arg5, arg8);
                    0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::place_market_order<T1>(&mut v36, !v35, v34, true);
                    let (v37, v38) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::end_session<T1>(v36, &mut arg0.account, false, 0x1::option::none<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::IntegratorInfo>());
                    let v39 = v38;
                    arg1 = v37;
                    let v40 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(v34, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling()), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_session_execution_price(&v39, !v35));
                    let v41 = if (v35) {
                        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(v34, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling()), v9), v40)
                    } else {
                        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v40, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(v34, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling()), v9))
                    };
                    let (v42, _, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::calculate_taker_fees<T1>(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_position<T1>(&arg1, v6), &arg0.account, v40, v12, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_additional_gas_price_taker_fee(v13, v0, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x2::tx_context::gas_price(arg8))), 0x1::option::none<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::IntegratorInfo>());
                    let v45 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v41, v42);
                    arg0.accumulated_slippage = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.accumulated_slippage, v45);
                    v21 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v20, v45);
                };
                assert!(!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v21), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::negative_amount_to_withdraw());
                if (v33) {
                    0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::deallocate_free_collateral<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &mut arg0.account, arg2, arg3, arg4, arg5);
                    let v46 = &arg0.vault.ch_ids;
                    let v47 = 0;
                    let v48;
                    while (v47 < 0x1::vector::length<0x2::object::ID>(v46)) {
                        if (*0x1::vector::borrow<0x2::object::ID>(v46, v47) == 0x2::object::id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>>(&arg1)) {
                            v48 = 0x1::option::some<u64>(v47);
                            /* label 44 */
                            if (0x1::option::is_some<u64>(&v48)) {
                                0x1::vector::remove<0x2::object::ID>(&mut arg0.vault.ch_ids, 0x1::option::destroy_some<u64>(v48));
                            } else {
                                0x1::option::destroy_none<u64>(v48);
                            };
                            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::set_position_initial_margin_ratio<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &arg0.account, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_imr_for_position(v22, v10));
                            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::share_clearing_house<T1>(arg1);
                            return
                        };
                        v47 = v47 + 1;
                    };
                    v48 = 0x1::option::none<u64>();
                    /* goto 44 */
                } else {
                    0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::deallocate_collateral<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &mut arg0.account, arg2, arg3, arg4, arg5, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v21, arg0.collateral_price), arg0.vault.vault_params.scaling_factor));
                    let (v49, _) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, v9, arg0.collateral_price, v25, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(1));
                    let (v51, v52) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, v9, arg0.collateral_price, v25, v8);
                    let v53 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_position<T1>(&arg1, v6);
                    let (v54, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v53);
                    if (v34 != 0) {
                        if (v34 == v32) {
                            assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_collateral(v53), arg0.collateral_price) <= arg0.vault.vault_params.min_force_withdraw_position_usd, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::force_withdraw_collateral_leftover());
                        } else {
                            assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(v51, v52), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::force_withdraw_below_margin_ratio());
                            assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v25, v7), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v51, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v54), v9))), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::force_withdraw_above_margin_ratio_tolerance());
                        };
                    } else if (v27 != 0 && !0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div_up(v7, v25), arg0.vault.vault_params.min_mr_tolerance_ratio)) {
                        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(v51, v52), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::force_withdraw_below_margin_ratio());
                    };
                    if (v54 == 0) {
                        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::deallocate_free_collateral<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &mut arg0.account, arg2, arg3, arg4, arg5);
                        let v56 = &arg0.vault.ch_ids;
                        let v57 = 0;
                        let v58;
                        while (v57 < 0x1::vector::length<0x2::object::ID>(v56)) {
                            if (*0x1::vector::borrow<0x2::object::ID>(v56, v57) == 0x2::object::id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>>(&arg1)) {
                                v58 = 0x1::option::some<u64>(v57);
                                /* label 78 */
                                if (0x1::option::is_some<u64>(&v58)) {
                                    0x1::vector::remove<0x2::object::ID>(&mut arg0.vault.ch_ids, 0x1::option::destroy_some<u64>(v58));
                                } else {
                                    0x1::option::destroy_none<u64>(v58);
                                };
                                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::set_position_initial_margin_ratio<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &arg0.account, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_imr_for_position(v22, v10));
                                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::share_clearing_house<T1>(arg1);
                                return
                            };
                            v57 = v57 + 1;
                        };
                        v58 = 0x1::option::none<u64>();
                        /* goto 78 */
                    } else {
                        arg0.vault_balance_value = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.vault_balance_value, v49);
                        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::set_position_initial_margin_ratio<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &arg0.account, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_imr_for_position(v22, v10));
                        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::share_clearing_house<T1>(arg1);
                        return
                    };
                };
            } else {
                v3 = v3 + 1;
            };
        };
        v4 = 0x1::option::none<u64>();
        /* goto 10 */
    }

    public(friend) fun process_clearing_house_for_withdraw<T0, T1>(arg0: &mut WithdrawSession<T0, T1>, arg1: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock) {
        assert!(version<T0, T1>(&arg0.vault) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(!arg0.can_force_process, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::must_force_withdraw());
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::get_market_params<T1>(&arg1);
        let v1 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_pfs_id(v0);
        assert_base_price_feed_storage_is_correct(arg2, &v1);
        let v2 = &mut arg0.ch_ids;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x2::object::ID>(v2)) {
            let v5 = 0x2::object::id<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house::ClearingHouse<T1>>(&arg1);
            if (0x1::vector::borrow<0x2::object::ID>(v2, v3) == &v5) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 9 */
                if (0x1::option::is_none<u64>(&v4)) {
                    abort 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::clearing_house_id_not_found()
                };
                0x1::vector::remove<0x2::object::ID>(v2, 0x1::option::extract<u64>(&mut v4));
                let (v6, _) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::oracle::get_price(arg2, arg3, arg4, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_pfs_source_id(v0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_pfs_tolerance(v0)), arg0.collateral_price, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_margin_ratio_initial(v0), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(1));
                arg0.vault_balance_value = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.vault_balance_value, v6);
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::interface::share_clearing_house<T1>(arg1);
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    public(friend) fun remove_stop_order_ticket_dof<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID) : 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::StopOrderTicket<T1> {
        0x2::dynamic_object_field::remove<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::StopOrderTicketKey, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::StopOrderTicket<T1>>(&mut arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::stop_order_ticket(arg1))
    }

    public(friend) fun remove_withdraw_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) : UserLpCoin<T0> {
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        let v0 = 0x2::tx_context::sender(arg1);
        assert_withdraw_request_exists<T0, T1>(arg0, v0);
        let WithdrawRequest {
            user_lp_coin             : v1,
            request_timestamp_ms     : _,
            min_expected_balance_out : _,
        } = 0x2::dynamic_field::remove<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::withdraw_request(v0));
        let v4 = v1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_remove_withdraw_request(id<T0, T1>(arg0), v0, 0x2::balance::value<T0>(&v4.lp_balance));
        v4
    }

    public(friend) fun resume_vault_for_force_withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        let v0 = &arg0.paused;
        if (0x1::option::is_some<u64>(v0) && 0x2::clock::timestamp_ms(arg1) < *0x1::option::borrow<u64>(v0)) {
            return
        };
        arg0.paused = 0x1::option::none<u64>();
    }

    public(friend) fun set_deposit_session_sender<T0, T1>(arg0: &mut DepositSession<T0, T1>, arg1: address) {
        arg0.sender = arg1;
    }

    public(friend) fun set_new_withdraw_request_slippage<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        let v0 = 0x2::tx_context::sender(arg2);
        assert_withdraw_request_exists<T0, T1>(arg0, v0);
        let v1 = withdraw_request_mut<T0, T1>(arg0, v0);
        v1.min_expected_balance_out = arg1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_user_withdraw_request_set_slippage(id<T0, T1>(arg0), v0, arg1);
    }

    public(friend) fun set_vault_total_deposited_collateral<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        arg0.total_deposited_collateral = arg1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_update_vault_total_deposited_collateral(id<T0, T1>(arg0), arg1, lp_supply_value<T0, T1>(arg0));
    }

    public(friend) fun split_user_lp_coin<T0>(arg0: &mut UserLpCoin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : UserLpCoin<T0> {
        let v0 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0.provided_value_usd, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(arg1, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling()), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(0x2::balance::value<T0>(&arg0.lp_balance), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::b9_scaling())));
        assert!(v0 > 0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_split_amount());
        arg0.provided_value_usd = arg0.provided_value_usd - v0;
        UserLpCoin<T0>{
            id                 : 0x2::object::new(arg2),
            lp_balance         : 0x2::balance::split<T0>(&mut arg0.lp_balance, arg1),
            start_timestamp_ms : arg0.start_timestamp_ms,
            provided_value_usd : v0,
        }
    }

    public(friend) fun start_deposit_session<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::tx_context::TxContext) : DepositSession<T0, T1> {
        assert!(version<T0, T1>(&arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::check_valid_account_cap<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&arg1, account_cap<T0, T1>(&arg0));
        assert_collateral_price_feed_storage_is_correct(arg2, &arg0.vault_params.collateral_pfs_id);
        let v0 = 0x2::coin::value<T1>(&arg5);
        arg0.total_deposited_collateral = arg0.total_deposited_collateral + v0;
        assert!(arg0.total_deposited_collateral <= arg0.vault_params.max_total_deposited_collateral, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::exceeding_max_total_deposited_collateral());
        let v1 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::oracle::get_price(arg2, arg3, arg4, arg0.vault_params.collateral_pfs_source_id, arg0.vault_params.collateral_pfs_tolerance);
        assert_minimum_user_deposit<T0, T1>(&arg0, v1, v0);
        create_deposit_session<T0, T1>(arg0, arg1, 0x2::tx_context::sender(arg6), 0x2::coin::into_balance<T1>(arg5), 0x2::clock::timestamp_ms(arg4), v1)
    }

    public(friend) fun start_force_withdraw_session<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: address, arg5: &0x2::clock::Clock) : WithdrawSession<T0, T1> {
        assert!(version<T0, T1>(&arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert_collateral_price_feed_storage_is_correct(arg2, &arg0.vault_params.collateral_pfs_id);
        assert_withdraw_request_exists<T0, T1>(&arg0, arg4);
        let WithdrawRequest {
            user_lp_coin             : v0,
            request_timestamp_ms     : v1,
            min_expected_balance_out : v2,
        } = 0x2::dynamic_field::remove<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::withdraw_request(arg4));
        assert!(v1 + arg0.vault_params.force_withdraw_delay <= 0x2::clock::timestamp_ms(arg5), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::force_withdraw_delay_not_passed());
        create_withdraw_session<T0, T1>(arg0, arg1, arg4, v0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::oracle::get_price(arg2, arg3, arg5, arg0.vault_params.collateral_pfs_source_id, arg0.vault_params.collateral_pfs_tolerance), true, v2)
    }

    public(friend) fun start_owner_process_withdraw_request<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock, arg5: address) : WithdrawSession<T0, T1> {
        assert!(version<T0, T1>(&arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::check_valid_account_cap<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&arg1, account_cap<T0, T1>(&arg0));
        assert_collateral_price_feed_storage_is_correct(arg2, &arg0.vault_params.collateral_pfs_id);
        assert_withdraw_request_exists<T0, T1>(&arg0, arg5);
        let WithdrawRequest {
            user_lp_coin             : v0,
            request_timestamp_ms     : _,
            min_expected_balance_out : v2,
        } = 0x2::dynamic_field::remove<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::withdraw_request(arg5));
        create_withdraw_session<T0, T1>(arg0, arg1, arg5, v0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::oracle::get_price(arg2, arg3, arg4, arg0.vault_params.collateral_pfs_source_id, arg0.vault_params.collateral_pfs_tolerance), false, v2)
    }

    public(friend) fun start_owner_withdraw_session<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: UserLpCoin<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : WithdrawSession<T0, T1> {
        assert!(version<T0, T1>(&arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(arg5 != 0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::withdraw_amount_zero());
        let v0 = 0x2::balance::value<T0>(&arg4.lp_balance);
        assert!(arg5 <= v0, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::withdraw_amount_too_big());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::check_valid_account_cap<T1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::ADMIN>(&arg1, account_cap<T0, T1>(&arg0));
        assert_collateral_price_feed_storage_is_correct(arg2, &arg0.vault_params.collateral_pfs_id);
        let v1 = 0x2::tx_context::sender(arg8);
        if (arg5 < v0) {
            let v2 = &mut arg4;
            0x2::transfer::public_transfer<UserLpCoin<T0>>(split_user_lp_coin<T0>(v2, v0 - arg5, arg8), v1);
        };
        create_withdraw_session<T0, T1>(arg0, arg1, v1, arg4, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::oracle::get_price(arg2, arg3, arg7, arg0.vault_params.collateral_pfs_source_id, arg0.vault_params.collateral_pfs_tolerance), false, arg6)
    }

    public(friend) fun update_collateral_pfs_info<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::registry::Registry) {
        let (v0, v1, v2) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::registry::get_collateral_info<T1>(arg1);
        arg0.vault_params.collateral_pfs_id = v0;
        arg0.vault_params.collateral_pfs_source_id = v1;
        arg0.vault_params.scaling_factor = v2;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_update_collateral_pfs_info(id<T0, T1>(arg0), v0, v1);
    }

    public(friend) fun update_collateral_pfs_tolerance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        arg0.vault_params.collateral_pfs_tolerance = arg1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_update_collateral_pfs_tolerance(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun update_force_withdraw_delay<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(arg1 <= 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::max_force_withdraw_delay(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_lock_period());
        arg0.vault_params.force_withdraw_delay = arg1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_update_force_withdraw_delay(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun update_lock_period<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(arg1 <= 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::max_lock_period(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_lock_period());
        arg0.vault_params.lock_period = arg1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_update_lock_period(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun update_max_force_withdraw_mr_tolerance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u256) {
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        arg0.vault_params.max_force_withdraw_mr_tolerance = arg1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_update_max_force_withdraw_mr_tolerance(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun update_max_markets_in_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(arg1 <= 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::max_markets_in_vault(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_max_markets_in_vault());
        arg0.vault_params.max_markets_in_vault = arg1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_max_markets_updated(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun update_max_pending_orders_per_position<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(arg1 <= 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::max_pending_orders_per_position(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_max_pending_orders_per_position());
        arg0.vault_params.max_pending_orders_per_position = arg1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_max_pending_orders_updated(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun update_max_total_deposited_collateral<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        arg0.vault_params.max_total_deposited_collateral = arg1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_update_max_total_deposited_collateral(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun update_min_force_withdraw_position_usd<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u256) {
        arg0.vault_params.min_force_withdraw_position_usd = arg1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_update_min_force_withdraw_position_usd(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun update_min_mr_tolerance_ratio<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u256) {
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        arg0.vault_params.min_mr_tolerance_ratio = arg1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_update_min_mr_tolerance_ratio(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun update_min_pause_vault_for_force_withdraw_frequency_ms<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        arg0.vault_params.min_pause_vault_for_force_withdraw_frequency_ms = arg1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_update_min_pause_vault_for_force_withdraw_frequency_ms(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun update_owner_fee_rate<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u256) {
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        assert!(!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg1) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg1, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::max_owner_fee_rate()), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_owner_fee_rate());
        arg0.vault_params.owner_fee_rate = arg1;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_update_owner_fee_rate(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun update_vault_version<T0, T1>(arg0: &mut Vault<T0, T1>) {
        let v0 = 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version();
        assert!(v0 > arg0.version, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::bad_new_vault_version());
        arg0.version = v0;
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_update_vault_version(id<T0, T1>(arg0), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version());
    }

    public fun user_lp_coin_info<T0>(arg0: &UserLpCoin<T0>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.lp_balance), arg0.start_timestamp_ms)
    }

    public fun vault_owner_cap_vault_id<T0>(arg0: &VaultOwnerCap<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun withdraw_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = id<T0, T1>(arg0);
        assert!(version<T0, T1>(arg0) == 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::constants::version(), 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::invalid_version());
        let v1 = owner_fees_mut<T0, T1>(arg0);
        assert!(0x2::balance::value<T1>(v1) >= arg1, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::errors::not_enough_fees());
        0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::events::emit_withdraw_fees(v0, arg1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v1, arg1), arg2)
    }

    public(friend) fun withdraw_request_mut<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address) : &mut WithdrawRequest<T0> {
        0x2::dynamic_field::borrow_mut<0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0x4fab366ac9a5024264e921cc6a3f6c76a87e566a524a93894447b32aae7d499f::keys::withdraw_request(arg1))
    }

    // decompiled from Move bytecode v6
}

