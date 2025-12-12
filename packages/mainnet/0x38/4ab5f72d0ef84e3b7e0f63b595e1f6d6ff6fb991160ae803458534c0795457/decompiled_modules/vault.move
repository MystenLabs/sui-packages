module 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::vault {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        version: u64,
        lp_supply: 0x2::balance::Supply<T0>,
        collateral_balance: 0x2::balance::Balance<T1>,
        total_deposited_collateral: u64,
        ch_ids: vector<0x2::object::ID>,
        vault_params: VaultParams,
    }

    struct VaultParams has store {
        lock_period: u64,
        owner_fee_rate: u256,
        force_withdraw_delay: u64,
        collateral_pfs_id: 0x2::object::ID,
        collateral_pfs_source_id: 0x2::object::ID,
        collateral_pfs_tolerance: u64,
        max_force_withdraw_mr_tolerance: u256,
        scaling_factor: u256,
        max_markets_in_vault: u64,
        max_pending_orders_per_position: u64,
        max_total_deposited_collateral: u64,
    }

    struct DepositSession<phantom T0, phantom T1> {
        vault: Vault<T0, T1>,
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
        account: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>,
        sender: address,
        collateral_price: u256,
        ch_ids: vector<0x2::object::ID>,
        user_lp_coin: UserLpCoin<T0>,
        vault_balance_value: u256,
        accumulated_slippage: u256,
        can_force_process: bool,
        min_expected_balance_out: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CreateVaultCap<phantom T0> has key {
        id: 0x2::object::UID,
        lp_treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct VaultOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        last_used_timestamp_ms: u64,
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

    public(friend) fun account_cap<T0, T1>(arg0: &Vault<T0, T1>) : &0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::AccountCap<T1> {
        0x2::dynamic_object_field::borrow<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::AccountCapKey, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::AccountCap<T1>>(&arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::account_cap_key())
    }

    public(friend) fun account_cap_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::AccountCap<T1> {
        0x2::dynamic_object_field::borrow_mut<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::AccountCapKey, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::AccountCap<T1>>(&mut arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::account_cap_key())
    }

    public(friend) fun add_collateral_to_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.collateral_balance, arg1);
    }

    public(friend) fun add_stop_order_ticket_dof<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::stop_orders::StopOrderTicket<T1>) {
        0x2::dynamic_object_field::add<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::StopOrderTicketKey, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::stop_orders::StopOrderTicket<T1>>(&mut arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::stop_order_ticket(0x2::object::id<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::stop_orders::StopOrderTicket<T1>>(&arg1)), arg1);
    }

    fun assert_base_price_feed_storage_is_correct(arg0: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg1: &0x2::object::ID) {
        let v0 = 0x2::object::id<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage>(arg0);
        assert!(arg1 == &v0, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::wrong_base_oracle());
    }

    fun assert_collateral_price_feed_storage_is_correct(arg0: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg1: &0x2::object::ID) {
        let v0 = 0x2::object::id<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage>(arg0);
        assert!(arg1 == &v0, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::wrong_collateral_oracle());
    }

    fun assert_minimum_owner_locked_liquidity(arg0: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg1: 0x2::object::ID, arg2: u64, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg4: &0x2::clock::Clock, arg5: u64, arg6: u256) {
        assert!(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::greater_than_eq(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(arg5, arg6), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::oracle::get_price(arg0, arg3, arg4, arg1, arg2)), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::min_owner_lock_usd()), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::owner_locked_amount_not_enough());
    }

    fun assert_minimum_user_deposit<T0, T1>(arg0: &Vault<T0, T1>, arg1: u256, arg2: u64) {
        assert!(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::greater_than_eq(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(arg2, arg0.vault_params.scaling_factor), arg1), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::min_deposit_usd()), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::user_deposit_amount_not_enough());
    }

    fun assert_vault_creation_parameters_are_valid(arg0: u64, arg1: u256, arg2: u64) {
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::min_lock_period() <= arg0 && arg0 <= 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::max_lock_period(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_lock_period());
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::min_force_withdraw_delay() <= arg2 && arg2 <= 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::max_force_withdraw_delay(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_force_withdraw_delay());
        assert!(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::less_than_eq(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::min_owner_fee_rate(), arg1) && 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::less_than_eq(arg1, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::max_owner_fee_rate()), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_owner_fee_rate());
    }

    fun assert_withdraw_request_does_not_already_exist<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) {
        assert!(!0x2::dynamic_field::exists_<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::WithdrawRequestKey>(&arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::withdraw_request(arg1)), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::withdraw_request_already_exists());
    }

    fun assert_withdraw_request_exists<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) {
        assert!(0x2::dynamic_field::exists_<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::WithdrawRequestKey>(&arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::withdraw_request(arg1)), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::withdraw_request_does_not_exist());
    }

    public(friend) fun available_balance_coin<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.collateral_balance), arg1)
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

    public fun collateral_balance<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.collateral_balance)
    }

    public(friend) fun collateral_balance_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x2::balance::Balance<T1> {
        &mut arg0.collateral_balance
    }

    fun create_deposit_session<T0, T1>(arg0: Vault<T0, T1>, arg1: address, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u256) : DepositSession<T0, T1> {
        DepositSession<T0, T1>{
            vault               : arg0,
            sender              : arg1,
            timestamp_ms        : arg3,
            collateral_price    : arg4,
            ch_ids              : ch_ids<T0, T1>(&arg0),
            vault_balance_value : 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(collateral_balance<T0, T1>(&arg0), arg0.vault_params.scaling_factor), arg4),
            provided_balance    : arg2,
        }
    }

    public(friend) fun create_vault<T0, T1>(arg0: CreateVaultCap<T0>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::registry::Registry, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: u64, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: u64, arg8: u256, arg9: u64, arg10: 0x2::coin::Coin<T1>, arg11: &mut 0x2::tx_context::TxContext) {
        let CreateVaultCap {
            id              : v0,
            lp_treasury_cap : v1,
        } = arg0;
        let v2 = v1;
        0x2::object::delete(v0);
        assert!(0x2::coin::total_supply<T0>(&v2) == 0, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::non_zero_total_supply());
        assert_vault_creation_parameters_are_valid(arg7, arg8, arg9);
        let (v3, v4, v5) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::registry::get_collateral_info<T1>(arg1);
        assert!(v3 == 0x2::object::id<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage>(arg2), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::wrong_collateral_oracle());
        assert_minimum_owner_locked_liquidity(arg2, v4, arg3, arg4, arg5, 0x2::coin::value<T1>(&arg10), v5);
        let v6 = VaultParams{
            lock_period                     : arg7,
            owner_fee_rate                  : arg8,
            force_withdraw_delay            : arg9,
            collateral_pfs_id               : v3,
            collateral_pfs_source_id        : v4,
            collateral_pfs_tolerance        : arg3,
            max_force_withdraw_mr_tolerance : 5000000000000000,
            scaling_factor                  : v5,
            max_markets_in_vault            : 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::max_markets_in_vault(),
            max_pending_orders_per_position : 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::max_pending_orders_per_position(),
            max_total_deposited_collateral  : 18446744073709551615,
        };
        let v7 = Vault<T0, T1>{
            id                         : 0x2::object::new(arg11),
            name                       : arg6,
            version                    : 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(),
            lp_supply                  : 0x2::coin::treasury_into_supply<T0>(v2),
            collateral_balance         : 0x2::balance::zero<T1>(),
            total_deposited_collateral : 0,
            ch_ids                     : 0x1::vector::empty<0x2::object::ID>(),
            vault_params               : v6,
        };
        let v8 = 0x2::tx_context::sender(arg11);
        let v9 = id<T0, T1>(&v7);
        let v10 = give_vault_owner_capability<T0>(v9, v8, arg5, arg11);
        0x2::dynamic_object_field::add<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::AccountCapKey, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::AccountCap<T1>>(&mut v7.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::account_cap_key(), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::create_account<T1>(arg1, arg11));
        0x2::dynamic_field::add<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::OwnerFeesKey, 0x2::balance::Balance<T1>>(&mut v7.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::owner_fees_key(), 0x2::balance::zero<T1>());
        let v11 = &mut v7;
        let v12 = &mut v7;
        add_collateral_to_vault<T0, T1>(v12, 0x2::coin::into_balance<T1>(arg10));
        0x2::dynamic_field::add<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::OwnerLockedLpCoinKey, 0x2::balance::Balance<T0>>(&mut v7.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::owner_user_lp_coin_key(), mint_lp_balance<T0, T1>(v11, 0x2::coin::value<T1>(&arg10)));
        0x2::transfer::share_object<Vault<T0, T1>>(v7);
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_created_vault_event(v9, v10, v8, arg7);
    }

    public(friend) fun create_vault_cap<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::vector::is_empty<u8>(&arg5)) {
            0x2::url::new_unsafe_from_bytes(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::default_lp_coin_image())
        } else {
            0x2::url::new_unsafe_from_bytes(arg5)
        };
        let (v1, v2) = 0x2::coin::create_currency<T0>(arg0, arg1, arg2, arg4, arg3, 0x1::option::some<0x2::url::Url>(v0), arg6);
        let v3 = CreateVaultCap<T0>{
            id              : 0x2::object::new(arg6),
            lp_treasury_cap : v1,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v2);
        0x2::transfer::transfer<CreateVaultCap<T0>>(v3, 0x2::tx_context::sender(arg6));
    }

    public(friend) fun create_withdraw_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: UserLpCoin<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(arg3 != 0, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::withdraw_amount_zero());
        assert!(0x2::balance::value<T0>(&arg1.lp_balance) >= arg3, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::withdraw_amount_too_big());
        let v0 = 0x2::tx_context::sender(arg5);
        assert_withdraw_request_does_not_already_exist<T0, T1>(arg0, v0);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.start_timestamp_ms + arg0.vault_params.lock_period <= v1, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::lock_period_not_passed());
        let v2 = if (0x2::balance::value<T0>(&arg1.lp_balance) == arg3) {
            WithdrawRequest<T0>{user_lp_coin: arg1, request_timestamp_ms: v1, min_expected_balance_out: arg4}
        } else {
            let v3 = &mut arg1;
            0x2::transfer::public_transfer<UserLpCoin<T0>>(arg1, v0);
            WithdrawRequest<T0>{user_lp_coin: split_user_lp_coin<T0>(v3, arg3, arg5), request_timestamp_ms: v1, min_expected_balance_out: arg4}
        };
        0x2::dynamic_field::add<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::withdraw_request(v0), v2);
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_create_withdraw_request(id<T0, T1>(arg0), v0, arg3, arg4);
    }

    fun create_withdraw_session<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg2: address, arg3: UserLpCoin<T0>, arg4: u256, arg5: bool, arg6: u64) : WithdrawSession<T0, T1> {
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
            sender              : v1,
            timestamp_ms        : v2,
            collateral_price    : v3,
            ch_ids              : v4,
            vault_balance_value : v5,
            provided_balance    : v6,
        } = arg0;
        let v7 = v6;
        let v8 = v4;
        let v9 = v0;
        assert!(version<T0, T1>(&v9) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(0x1::vector::length<0x2::object::ID>(&v8) == 0, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::not_all_chs_processed());
        let v10 = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(0x2::balance::value<T1>(&v7), v9.vault_params.scaling_factor), v3);
        let v11 = &mut v9;
        add_collateral_to_vault<T0, T1>(v11, v7);
        let v12 = multiply_by_rational_ifixed(v10, 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(lp_supply_value<T0, T1>(&v9), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::b9_scaling()), v5);
        assert!(!0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::is_neg(v12), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::user_lp_calculation_negative());
        let v13 = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::to_balance(v12, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::b9_scaling());
        assert!(v13 != 0, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::user_lp_calculation_zero());
        let v14 = &mut v9;
        let v15 = mint_lp_balance<T0, T1>(v14, v13);
        let v16 = 0x2::balance::value<T0>(&v15);
        assert!(v16 >= arg1, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::slippage_check());
        let v17 = UserLpCoin<T0>{
            id                 : 0x2::object::new(arg2),
            lp_balance         : v15,
            start_timestamp_ms : v2,
            provided_value_usd : v10,
        };
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_user_deposit(id<T0, T1>(&v9), v1, 0x2::balance::value<T1>(&v7), v16, v5);
        0x2::transfer::public_share_object<Vault<T0, T1>>(v9);
        v17
    }

    public(friend) fun end_withdraw_session<T0, T1>(arg0: WithdrawSession<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
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
        assert!(0x1::vector::length<0x2::object::ID>(&v10) == 0, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::not_all_chs_processed());
        assert!(version<T0, T1>(&v12) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        let v18 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_collateral_value<T1>(&v11);
        if (v18 != 0) {
            let v19 = &mut v12;
            add_collateral_to_vault<T0, T1>(v19, 0x2::coin::into_balance<T1>(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::withdraw_collateral<T1>(account_cap<T0, T1>(&v12), &mut v11, v18, arg1)));
        };
        let v20 = v12.vault_params.scaling_factor;
        let v21 = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::add(multiply_by_rational_ifixed(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(0x2::balance::value<T0>(&v17), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::b9_scaling()), 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::add(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::add(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(collateral_balance<T0, T1>(&v12), v20), v3), v6), 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::neg(v7)), 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(lp_supply_value<T0, T1>(&v12), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::b9_scaling())), v7);
        assert!(!0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::is_neg(v21), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::slippage_check());
        let v22 = &mut v12;
        burn_lp_balance<T0, T1>(v22, v17);
        let v23 = &mut v12;
        let v24 = remove_collateral_from_vault<T0, T1>(v23, 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::to_balance(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::div(v21, v3), v20));
        if (0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::greater_than(v12.vault_params.owner_fee_rate, 0) && 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::greater_than(v21, v16)) {
            let v25 = &mut v12;
            0x2::balance::join<T1>(owner_fees_mut<T0, T1>(v25), 0x2::balance::split<T1>(&mut v24, 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::to_balance(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::div(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::sub(v21, v16), v12.vault_params.owner_fee_rate), v3), v20)));
        };
        let v26 = 0x2::balance::value<T1>(&v24);
        assert!(v26 >= v9, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::slippage_check());
        v12.total_deposited_collateral = v12.total_deposited_collateral - 0x1::u64::min(v12.total_deposited_collateral, v26);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v24, arg1), v2);
        0x2::transfer::public_share_object<Vault<T0, T1>>(v12);
        0x2::transfer::public_share_object<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>>(v11);
        if (v8) {
            0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_user_force_withdraw(id<T0, T1>(&v12), v2, 0x2::balance::value<T0>(&v17), v26, v6);
        } else {
            0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_owner_withdraw(id<T0, T1>(&v12), v2, 0x2::balance::value<T0>(&v17), v26, v6);
        };
    }

    public fun get_mut_stop_order_ticket_dof<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID) : &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::stop_orders::StopOrderTicket<T1> {
        0x2::dynamic_object_field::borrow_mut<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::StopOrderTicketKey, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::stop_orders::StopOrderTicket<T1>>(&mut arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::stop_order_ticket(arg1))
    }

    public fun get_vault_margin_in_market<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg2: u256, arg3: u256, arg4: u256) : (u256, u256) {
        let (v0, v1) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_cum_funding_rates(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_state<T1>(arg1));
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::compute_margin_with_fundings(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_position<T1>(arg1, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_cap_account_id<T1>(account_cap<T0, T1>(arg0))), arg3, arg2, arg4, v0, v1, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_collateral_haircut(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(arg1)))
    }

    fun give_vault_owner_capability<T0>(arg0: 0x2::object::ID, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg3);
        let v1 = VaultOwnerCap<T0>{
            id                     : v0,
            vault_id               : arg0,
            last_used_timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::transfer<VaultOwnerCap<T0>>(v1, arg1);
        0x2::object::uid_to_inner(&v0)
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<VAULT>(arg0, arg1), v0);
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

    public fun lock_period<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.vault_params.lock_period
    }

    public fun lp_supply_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.lp_supply)
    }

    fun mint_lp_balance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, arg1)
    }

    fun multiply_by_rational_ifixed(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg2 != 0) {
            0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::div(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(arg0, arg1), arg2)
        } else {
            0
        }
    }

    public fun owner_fee_rate<T0, T1>(arg0: &Vault<T0, T1>) : u256 {
        arg0.vault_params.owner_fee_rate
    }

    public fun owner_fees<T0, T1>(arg0: &Vault<T0, T1>) : &0x2::balance::Balance<T1> {
        0x2::dynamic_field::borrow<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::OwnerFeesKey, 0x2::balance::Balance<T1>>(&arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::owner_fees_key())
    }

    public(friend) fun owner_fees_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x2::balance::Balance<T1> {
        0x2::dynamic_field::borrow_mut<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::OwnerFeesKey, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::owner_fees_key())
    }

    public(friend) fun process_clearing_house_for_deposit<T0, T1>(arg0: &mut DepositSession<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg4: &0x2::clock::Clock) {
        assert!(version<T0, T1>(&arg0.vault) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        let v0 = 0x2::object::id<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>>(&arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.ch_ids, &v0);
        assert!(v1, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::clearing_house_id_not_found());
        let v3 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_base_pfs_id(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&arg1));
        assert_base_price_feed_storage_is_correct(arg2, &v3);
        let (v4, _) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::oracle::get_price(arg2, arg3, arg4, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_base_pfs_source_id(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&arg1)), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_base_pfs_tolerance(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&arg1))), arg0.collateral_price, 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_u64(1));
        arg0.vault_balance_value = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::add(arg0.vault_balance_value, v4);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.ch_ids, v2);
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::share_clearing_house<T1>(arg1);
    }

    public(friend) fun process_clearing_house_for_force_withdraw<T0, T1>(arg0: &mut WithdrawSession<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg5: &0x2::clock::Clock, arg6: u64, arg7: &vector<u128>, arg8: &0x2::tx_context::TxContext) {
        assert!(version<T0, T1>(&arg0.vault) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(arg0.can_force_process, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::cannot_force_withdraw());
        let v0 = 0x2::object::id<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>>(&arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.ch_ids, &v0);
        assert!(v1, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::clearing_house_id_not_found());
        let v3 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_base_pfs_id(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&arg1));
        assert_base_price_feed_storage_is_correct(arg2, &v3);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.ch_ids, v2);
        let v4 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::get_cap_account_id<T1>(account_cap<T0, T1>(&arg0.vault));
        let v5 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::oracle::get_price(arg2, arg4, arg5, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_base_pfs_source_id(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&arg1)), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_base_pfs_tolerance(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&arg1)));
        let v6 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_margin_ratio_initial(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&arg1));
        let (v7, _) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, v5, arg0.collateral_price, v6);
        let v9 = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(v7, 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::div(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(0x2::balance::value<T0>(&arg0.user_lp_coin.lp_balance), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::b9_scaling()), 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(lp_supply_value<T0, T1>(&arg0.vault), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::b9_scaling())));
        let v10 = v9;
        if (0x1::vector::length<u128>(arg7) != 0) {
            0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::cancel_orders<T1>(&mut arg1, account_cap<T0, T1>(&arg0.vault), arg7);
        };
        let v11 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_position<T1>(&arg1, v4);
        let (v12, _) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_amounts(v11);
        let (v14, v15) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_pending_amounts(v11);
        let v16 = if (v14 == 0) {
            if (v15 == 0) {
                0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_pending_orders_counter(v11) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v16, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::wrong_order_ids_in_force_withdraw());
        let v17 = if (v12 != 0) {
            0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::div(v7, 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::abs(v12), v5))
        } else {
            0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_u64(1)
        };
        if (v12 != 0) {
            let (_, v19) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_maker_taker_fees(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&arg1));
            let v20 = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::is_neg(v12);
            let v21 = 0x1::u64::min(arg6, 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::to_balance(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::abs(v12), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::b9_scaling()));
            let v22 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::start_session<T1>(arg1, account_cap<T0, T1>(&arg0.vault), arg2, arg3, arg4, arg5, arg8);
            0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::place_market_order<T1>(&mut v22, !v20, v21, false);
            let (v23, v24) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::end_session<T1>(v22, &mut arg0.account, false, 0x1::option::none<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::IntegratorInfo>());
            let v25 = v24;
            arg1 = v23;
            let v26 = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(v21, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::b9_scaling()), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_session_execution_price(&v25, !v20));
            let v27 = if (v20) {
                0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::sub(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(v21, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::b9_scaling()), v5), v26)
            } else {
                0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::sub(v26, 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(v21, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::b9_scaling()), v5))
            };
            let v28 = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(v26, v19);
            arg0.accumulated_slippage = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::add(arg0.accumulated_slippage, 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::sub(v27, v28));
            v10 = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::add(v9, 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::sub(v27, v28));
        };
        assert!(!0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::is_neg(v10), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::negative_amount_to_withdraw());
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::deallocate_collateral<T1>(&mut arg1, account_cap<T0, T1>(&arg0.vault), &mut arg0.account, arg2, arg3, arg4, arg5, 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::to_balance(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::div(v10, arg0.collateral_price), arg0.vault.vault_params.scaling_factor));
        let v29 = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::max(v17, v6);
        let (v30, v31) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, v5, arg0.collateral_price, v29);
        let (v32, _) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_amounts(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_position<T1>(&arg1, v4));
        if (v12 != 0) {
            assert!(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::greater_than_eq(v30, v31), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::force_withdraw_below_margin_ratio());
            assert!(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::greater_than_eq(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::add(v29, arg0.vault.vault_params.max_force_withdraw_mr_tolerance), 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::div(v30, 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::abs(v32), v5))), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::force_withdraw_above_margin_ratio_tolerance());
        };
        arg0.vault_balance_value = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::add(arg0.vault_balance_value, v30);
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::share_clearing_house<T1>(arg1);
    }

    public(friend) fun process_clearing_house_for_withdraw<T0, T1>(arg0: &mut WithdrawSession<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg4: &0x2::clock::Clock) {
        assert!(version<T0, T1>(&arg0.vault) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(!arg0.can_force_process, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::must_force_withdraw());
        let v0 = 0x2::object::id<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>>(&arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.ch_ids, &v0);
        assert!(v1, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::clearing_house_id_not_found());
        let v3 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_base_pfs_id(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&arg1));
        assert_base_price_feed_storage_is_correct(arg2, &v3);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.ch_ids, v2);
        let (v4, _) = get_vault_margin_in_market<T0, T1>(&arg0.vault, &arg1, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::oracle::get_price(arg2, arg3, arg4, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_base_pfs_source_id(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&arg1)), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_base_pfs_tolerance(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&arg1))), arg0.collateral_price, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_margin_ratio_initial(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_params<T1>(&arg1)));
        arg0.vault_balance_value = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::add(arg0.vault_balance_value, v4);
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::interface::share_clearing_house<T1>(arg1);
    }

    public(friend) fun remove_collateral_from_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        assert!(0x2::balance::value<T1>(&arg0.collateral_balance) >= arg1, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::not_enough_collateral_balance());
        0x2::balance::split<T1>(&mut arg0.collateral_balance, arg1)
    }

    public(friend) fun remove_stop_order_ticket_dof<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID) : 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::stop_orders::StopOrderTicket<T1> {
        0x2::dynamic_object_field::remove<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::StopOrderTicketKey, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::stop_orders::StopOrderTicket<T1>>(&mut arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::stop_order_ticket(arg1))
    }

    public(friend) fun remove_withdraw_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) : UserLpCoin<T0> {
        assert!(version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        let v0 = 0x2::tx_context::sender(arg1);
        assert_withdraw_request_exists<T0, T1>(arg0, v0);
        let WithdrawRequest {
            user_lp_coin             : v1,
            request_timestamp_ms     : _,
            min_expected_balance_out : _,
        } = 0x2::dynamic_field::remove<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::withdraw_request(v0));
        let v4 = v1;
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_remove_withdraw_request(id<T0, T1>(arg0), v0, 0x2::balance::value<T0>(&v4.lp_balance));
        v4
    }

    public(friend) fun set_deposit_session_sender<T0, T1>(arg0: &mut DepositSession<T0, T1>, arg1: address) {
        arg0.sender = arg1;
    }

    public(friend) fun set_new_withdraw_request_slippage<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        let v0 = 0x2::tx_context::sender(arg3);
        assert_withdraw_request_exists<T0, T1>(arg0, v0);
        let v1 = withdraw_request_mut<T0, T1>(arg0, v0);
        v1.min_expected_balance_out = arg2;
        v1.request_timestamp_ms = 0x2::clock::timestamp_ms(arg1);
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_user_withdraw_request_set_slippage(id<T0, T1>(arg0), v0, arg2);
    }

    public(friend) fun set_vault_total_deposited_collateral<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        arg0.total_deposited_collateral = arg1;
    }

    public(friend) fun split_user_lp_coin<T0>(arg0: &mut UserLpCoin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : UserLpCoin<T0> {
        let v0 = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(arg0.provided_value_usd, 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::div(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(arg1, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::b9_scaling()), 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(0x2::balance::value<T0>(&arg0.lp_balance), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::b9_scaling())));
        assert!(v0 > 0, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_split_amount());
        arg0.provided_value_usd = arg0.provided_value_usd - v0;
        UserLpCoin<T0>{
            id                 : 0x2::object::new(arg2),
            lp_balance         : 0x2::balance::split<T0>(&mut arg0.lp_balance, arg1),
            start_timestamp_ms : arg0.start_timestamp_ms,
            provided_value_usd : v0,
        }
    }

    public(friend) fun start_deposit_session<T0, T1>(arg0: Vault<T0, T1>, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::tx_context::TxContext) : DepositSession<T0, T1> {
        assert!(version<T0, T1>(&arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert_collateral_price_feed_storage_is_correct(arg1, &arg0.vault_params.collateral_pfs_id);
        let v0 = 0x2::coin::value<T1>(&arg4);
        arg0.total_deposited_collateral = arg0.total_deposited_collateral + v0;
        assert!(arg0.total_deposited_collateral <= arg0.vault_params.max_total_deposited_collateral, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::exceeding_max_total_deposited_collateral());
        let v1 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::oracle::get_price(arg1, arg2, arg3, arg0.vault_params.collateral_pfs_source_id, arg0.vault_params.collateral_pfs_tolerance);
        assert_minimum_user_deposit<T0, T1>(&arg0, v1, v0);
        create_deposit_session<T0, T1>(arg0, 0x2::tx_context::sender(arg5), 0x2::coin::into_balance<T1>(arg4), 0x2::clock::timestamp_ms(arg3), v1)
    }

    public(friend) fun start_force_withdraw_session<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : WithdrawSession<T0, T1> {
        assert!(version<T0, T1>(&arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert_collateral_price_feed_storage_is_correct(arg2, &arg0.vault_params.collateral_pfs_id);
        let v0 = 0x2::tx_context::sender(arg5);
        assert_withdraw_request_exists<T0, T1>(&arg0, v0);
        let WithdrawRequest {
            user_lp_coin             : v1,
            request_timestamp_ms     : v2,
            min_expected_balance_out : v3,
        } = 0x2::dynamic_field::remove<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::withdraw_request(v0));
        assert!(v2 + arg0.vault_params.force_withdraw_delay <= 0x2::clock::timestamp_ms(arg4), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::force_withdraw_delay_not_passed());
        create_withdraw_session<T0, T1>(arg0, arg1, v0, v1, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::oracle::get_price(arg2, arg3, arg4, arg0.vault_params.collateral_pfs_source_id, arg0.vault_params.collateral_pfs_tolerance), true, v3)
    }

    public(friend) fun start_owner_withdraw_session<T0, T1>(arg0: Vault<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg4: &0x2::clock::Clock, arg5: address, arg6: &0x2::tx_context::TxContext) : WithdrawSession<T0, T1> {
        assert!(version<T0, T1>(&arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert_collateral_price_feed_storage_is_correct(arg2, &arg0.vault_params.collateral_pfs_id);
        assert_withdraw_request_exists<T0, T1>(&arg0, arg5);
        let WithdrawRequest {
            user_lp_coin             : v0,
            request_timestamp_ms     : _,
            min_expected_balance_out : v2,
        } = 0x2::dynamic_field::remove<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::withdraw_request(0x2::tx_context::sender(arg6)));
        create_withdraw_session<T0, T1>(arg0, arg1, arg5, v0, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::oracle::get_price(arg2, arg3, arg4, arg0.vault_params.collateral_pfs_source_id, arg0.vault_params.collateral_pfs_tolerance), false, v2)
    }

    public(friend) fun update_collateral_pfs_info<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::registry::Registry) {
        let (v0, v1, v2) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::registry::get_collateral_info<T1>(arg1);
        arg0.vault_params.collateral_pfs_id = v0;
        arg0.vault_params.collateral_pfs_source_id = v1;
        arg0.vault_params.scaling_factor = v2;
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_update_collateral_pfs_info(id<T0, T1>(arg0), v0, v1);
    }

    public(friend) fun update_collateral_pfs_tolerance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        arg0.vault_params.collateral_pfs_tolerance = arg1;
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_update_collateral_pfs_tolerance(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun update_force_withdraw_delay<T0, T1>(arg0: &mut VaultOwnerCap<T0>, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        assert!(version<T0, T1>(arg1) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(arg0.last_used_timestamp_ms + 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::vault_params_update_frequency() < 0x2::clock::timestamp_ms(arg2), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::update_params_frequency_not_passed());
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::min_force_withdraw_delay() <= arg3 && arg3 <= 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::max_force_withdraw_delay(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_lock_period());
        arg1.vault_params.force_withdraw_delay = arg3;
        arg0.last_used_timestamp_ms = 0x2::clock::timestamp_ms(arg2);
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_update_force_withdraw_delay(id<T0, T1>(arg1), arg3);
    }

    public(friend) fun update_lock_period<T0, T1>(arg0: &mut VaultOwnerCap<T0>, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        assert!(version<T0, T1>(arg1) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(arg0.last_used_timestamp_ms + 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::vault_params_update_frequency() < 0x2::clock::timestamp_ms(arg2), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::update_params_frequency_not_passed());
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::min_lock_period() <= arg3 && arg3 <= 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::max_lock_period(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_lock_period());
        arg1.vault_params.lock_period = arg3;
        arg0.last_used_timestamp_ms = 0x2::clock::timestamp_ms(arg2);
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_update_lock_period(id<T0, T1>(arg1), arg3);
    }

    public(friend) fun update_max_markets_in_vault<T0, T1>(arg0: &mut VaultOwnerCap<T0>, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        assert!(version<T0, T1>(arg1) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(arg0.last_used_timestamp_ms + 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::vault_params_update_frequency() < 0x2::clock::timestamp_ms(arg2), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::update_params_frequency_not_passed());
        assert!(arg1.vault_params.max_markets_in_vault < arg3 && arg3 <= 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::max_markets_in_vault(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_max_markets_in_vault());
        arg1.vault_params.max_markets_in_vault = arg3;
        arg0.last_used_timestamp_ms = 0x2::clock::timestamp_ms(arg2);
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_max_markets_updated(id<T0, T1>(arg1), arg3);
    }

    public(friend) fun update_max_pending_orders_per_position<T0, T1>(arg0: &mut VaultOwnerCap<T0>, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        assert!(version<T0, T1>(arg1) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(arg0.last_used_timestamp_ms + 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::vault_params_update_frequency() < 0x2::clock::timestamp_ms(arg2), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::update_params_frequency_not_passed());
        assert!(arg1.vault_params.max_pending_orders_per_position < arg3 && arg3 <= 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::max_pending_orders_per_position(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_max_pending_orders_per_position());
        arg1.vault_params.max_pending_orders_per_position = arg3;
        arg0.last_used_timestamp_ms = 0x2::clock::timestamp_ms(arg2);
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_max_pending_orders_updated(id<T0, T1>(arg1), arg3);
    }

    public(friend) fun update_max_total_deposited_collateral<T0, T1>(arg0: &mut VaultOwnerCap<T0>, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        assert!(version<T0, T1>(arg1) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(arg0.last_used_timestamp_ms + 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::vault_params_update_frequency() < 0x2::clock::timestamp_ms(arg2), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::update_params_frequency_not_passed());
        arg1.vault_params.max_total_deposited_collateral = arg3;
        arg0.last_used_timestamp_ms = 0x2::clock::timestamp_ms(arg2);
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_update_max_total_deposited_collateral(id<T0, T1>(arg1), arg3);
    }

    public(friend) fun update_owner_fee_rate<T0, T1>(arg0: &mut VaultOwnerCap<T0>, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: u256) {
        assert!(version<T0, T1>(arg1) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        assert!(arg0.last_used_timestamp_ms + 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::vault_params_update_frequency() < 0x2::clock::timestamp_ms(arg2), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::update_params_frequency_not_passed());
        assert!(0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::min_owner_fee_rate() <= arg3 && arg3 <= 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::max_owner_fee_rate(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_owner_fee_rate());
        arg1.vault_params.owner_fee_rate = arg3;
        arg0.last_used_timestamp_ms = 0x2::clock::timestamp_ms(arg2);
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_update_owner_fee_rate(id<T0, T1>(arg1), arg3);
    }

    public(friend) fun update_vault_name<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x1::string::String) {
        arg0.name = arg1;
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_update_vault_name(id<T0, T1>(arg0), arg1);
    }

    public(friend) fun update_vault_version<T0, T1>(arg0: &mut Vault<T0, T1>) {
        let v0 = 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version();
        assert!(v0 > arg0.version, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::bad_new_vault_version());
        arg0.version = v0;
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_update_vault_version(id<T0, T1>(arg0), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version());
    }

    public fun user_lp_coin_info<T0>(arg0: &UserLpCoin<T0>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.lp_balance), arg0.start_timestamp_ms)
    }

    public fun vault_owner_cap_vault_id<T0>(arg0: &VaultOwnerCap<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun withdraw_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = id<T0, T1>(arg0);
        assert!(version<T0, T1>(arg0) == 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants::version(), 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::invalid_version());
        let v1 = owner_fees_mut<T0, T1>(arg0);
        assert!(0x2::balance::value<T1>(v1) >= arg1, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::errors::not_enough_fees());
        0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::events::emit_withdraw_fees(v0, arg1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v1, arg1), arg2)
    }

    public(friend) fun withdraw_request_mut<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address) : &mut WithdrawRequest<T0> {
        0x2::dynamic_field::borrow_mut<0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::WithdrawRequestKey, WithdrawRequest<T0>>(&mut arg0.id, 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::keys::withdraw_request(arg1))
    }

    // decompiled from Move bytecode v6
}

