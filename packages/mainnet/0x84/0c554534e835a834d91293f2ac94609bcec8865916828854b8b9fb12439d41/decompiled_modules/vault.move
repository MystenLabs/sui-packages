module 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::vault {
    struct WithdrawalRequest has copy, drop, store {
        owner: address,
        receiver: address,
        shares: u64,
        estimated_withdraw_amount: u64,
        timestamp: u64,
        sequence_number: u128,
    }

    struct PlatformFee has copy, drop, store {
        accrued: u64,
        last_charged_at: u64,
    }

    struct Rate has copy, drop, store {
        value: u64,
        max_rate_change_per_update: u64,
        rate_update_interval: u64,
        last_updated_at: u64,
    }

    struct Account has copy, drop, store {
        total_pending_withdrawal_shares: u64,
        pending_withdrawal_requests: vector<WithdrawalRequest>,
        cancel_withdraw_request: vector<u128>,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        admin: address,
        operator: address,
        blacklisted: vector<address>,
        paused: bool,
        pending_withdrawals: 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::queue::Queue<WithdrawalRequest>,
        accounts: 0x2::table::Table<address, Account>,
        pending_shares_to_burn: 0x2::balance::Balance<T1>,
        sub_accounts: vector<address>,
        rate: Rate,
        fee_percentage: u64,
        balance: 0x2::balance::Balance<T0>,
        fee: PlatformFee,
        min_withdrawal_shares: u64,
        max_tvl: u64,
        receipt_token_treasury_cap: 0x2::coin::TreasuryCap<T1>,
        sequence_number: u128,
    }

    fun burn_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T1>(&arg0.pending_shares_to_burn) >= arg1, 2009);
        0x2::coin::burn<T1>(&mut arg0.receipt_token_treasury_cap, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.pending_shares_to_burn, arg1), arg2));
    }

    public fun calculate_amount_from_shares<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : u64 {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::math::div_ceil(arg1, arg0.rate.value)
    }

    public fun calculate_shares_from_amount<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : u64 {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::math::mul(arg1, arg0.rate.value)
    }

    public fun cancel_pending_withdrawal_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_protocol_not_paused(arg1);
        verify_vault_not_paused<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, Account>(&arg0.accounts, v0), 2013);
        let v1 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, v0);
        let (v2, _) = 0x1::vector::index_of<u128>(&v1.cancel_withdraw_request, &arg2);
        assert!(!v2, 2012);
        let v4 = &v1.pending_withdrawal_requests;
        let v5 = 0;
        let v6;
        while (v5 < 0x1::vector::length<WithdrawalRequest>(v4)) {
            if (0x1::vector::borrow<WithdrawalRequest>(v4, v5).sequence_number == arg2) {
                v6 = 0x1::option::some<u64>(v5);
                /* label 11 */
                assert!(0x1::option::is_some<u64>(&v6), 2012);
                let v7 = 0x1::vector::borrow<WithdrawalRequest>(&v1.pending_withdrawal_requests, *0x1::option::borrow<u64>(&v6));
                0x1::vector::push_back<u128>(&mut v1.cancel_withdraw_request, arg2);
                0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_request_cancelled_event(0x2::object::uid_to_inner(&arg0.id), v7.owner, v7.sequence_number, v1.cancel_withdraw_request);
                return
            };
            v5 = v5 + 1;
        };
        v6 = 0x1::option::none<u64>();
        /* goto 11 */
    }

    public fun change_vault_admin<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::AdminCap, arg3: address) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        assert!(arg3 != @0x0 && arg0.admin != arg3, 2001);
        arg0.admin = arg3;
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_admin_changed_event(0x2::object::uid_to_inner(&arg0.id), arg0.admin, arg3, arg0.sequence_number);
    }

    public fun change_vault_operator<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2000);
        assert!(arg2 != @0x0 && arg0.operator != arg2, 2001);
        arg0.operator = arg2;
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_operator_changed_event(0x2::object::uid_to_inner(&arg0.id), arg0.operator, arg2, arg0.sequence_number);
    }

    public fun change_vault_rate_update_interval<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_protocol_not_paused(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2000);
        assert!(arg2 >= 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::get_min_rate_interval(arg1) && arg2 <= 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::get_max_rate_interval(arg1), 2010);
        assert!(arg2 != arg0.rate.rate_update_interval, 2014);
        arg0.rate.rate_update_interval = arg2;
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_rate_update_interval_changed_event(0x2::object::uid_to_inner(&arg0.id), arg0.rate.rate_update_interval, arg2, arg0.sequence_number);
    }

    public fun charge_platform_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_protocol_not_paused(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.operator, 2000);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - arg0.fee.last_charged_at > 86400000, 2010);
        let v1 = 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::math::mul(get_vault_tvl<T0, T1>(arg0), arg0.fee_percentage);
        assert!(v1 > 0, 2004);
        arg0.fee.accrued = arg0.fee.accrued + v1;
        arg0.fee.last_charged_at = v0;
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_platform_fee_charged_event(0x2::object::uid_to_inner(&arg0.id), v1, arg0.fee.accrued, arg0.fee.last_charged_at, arg0.sequence_number);
    }

    public fun collect_platform_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_protocol_not_paused(arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.operator, 2000);
        let v0 = arg0.fee.accrued;
        assert!(v0 > 0, 2004);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg0.fee.accrued, 2007);
        arg0.fee.accrued = 0;
        let v1 = 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::get_platform_fee_recipient(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2), v1);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_protocol_fee_collected_event<T0>(0x2::object::uid_to_inner(&arg0.id), v0, 0x2::balance::value<T0>(&arg0.balance), v1, arg0.sequence_number);
    }

    public fun create_vault<T0, T1>(arg0: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg1: 0x2::coin::TreasuryCap<T1>, arg2: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::AdminCap, arg3: 0x1::string::String, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<address>, arg12: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg0);
        assert!(arg9 >= 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::get_min_rate_interval(arg0) && arg9 <= 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::get_max_rate_interval(arg0), 2010);
        let v0 = Rate{
            value                      : 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::get_default_rate(arg0),
            max_rate_change_per_update : arg6,
            rate_update_interval       : arg9,
            last_updated_at            : 0,
        };
        let v1 = PlatformFee{
            accrued         : 0,
            last_charged_at : 0,
        };
        let v2 = Vault<T0, T1>{
            id                         : 0x2::object::new(arg12),
            name                       : arg3,
            admin                      : arg4,
            operator                   : arg5,
            blacklisted                : 0x1::vector::empty<address>(),
            paused                     : false,
            pending_withdrawals        : 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::queue::new<WithdrawalRequest>(arg12),
            accounts                   : 0x2::table::new<address, Account>(arg12),
            pending_shares_to_burn     : 0x2::balance::zero<T1>(),
            sub_accounts               : arg11,
            rate                       : v0,
            fee_percentage             : arg7,
            balance                    : 0x2::balance::zero<T0>(),
            fee                        : v1,
            min_withdrawal_shares      : arg8,
            max_tvl                    : arg10,
            receipt_token_treasury_cap : arg1,
            sequence_number            : 0,
        };
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_created_event<T0, T1>(0x2::object::uid_to_inner(&v2.id), arg3, arg4, arg5, arg11, arg8, arg7, arg6, arg9, v0.value, arg10);
        v2
    }

    public fun decode_withdrawal_request(arg0: &WithdrawalRequest) : (address, address, u64, u64, u64, u128) {
        (arg0.owner, arg0.receiver, arg0.shares, arg0.estimated_withdraw_amount, arg0.timestamp, arg0.sequence_number)
    }

    public fun deposit_asset<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_protocol_not_paused(arg1);
        verify_vault_not_paused<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        verify_not_blacklisted<T0, T1>(arg0, v0);
        let v1 = 0x2::balance::value<T0>(&arg2);
        assert!(v1 > 0, 2004);
        0x2::balance::join<T0>(&mut arg0.balance, arg2);
        let v2 = calculate_shares_from_amount<T0, T1>(arg0, v1);
        assert!(v2 > 0, 2004);
        assert!(get_vault_tvl<T0, T1>(arg0) <= arg0.max_tvl, 2016);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_deposit_event<T0>(0x2::object::uid_to_inner(&arg0.id), v0, v1, v2, 0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<T0>(&arg0.balance), get_vault_total_shares<T0, T1>(arg0), arg0.sequence_number);
        0x2::coin::mint<T1>(&mut arg0.receipt_token_treasury_cap, v2, arg3)
    }

    public fun deposit_to_vault_without_minting_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: 0x2::balance::Balance<T0>, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_protocol_not_paused(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.operator, 2000);
        assert!(0x1::vector::contains<address>(&arg0.sub_accounts, &arg3), 2001);
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0, 2004);
        0x2::balance::join<T0>(&mut arg0.balance, arg2);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_deposit_without_minting_shares_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg3, 0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<T0>(&arg0.balance), v0, arg0.sequence_number);
    }

    public fun get_account_cancelled_withdraw_request_sequencer_numbers<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : vector<u128> {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            0x1::vector::empty<u128>()
        } else {
            0x2::table::borrow<address, Account>(&arg0.accounts, arg1).cancel_withdraw_request
        }
    }

    public fun get_account_pending_withdrawal_requests<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : vector<WithdrawalRequest> {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            0x1::vector::empty<WithdrawalRequest>()
        } else {
            0x2::table::borrow<address, Account>(&arg0.accounts, arg1).pending_withdrawal_requests
        }
    }

    public fun get_account_total_pending_withdrawal_shares<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : u64 {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            0
        } else {
            0x2::table::borrow<address, Account>(&arg0.accounts, arg1).total_pending_withdrawal_shares
        }
    }

    public fun get_accrued_platform_fee<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.fee.accrued
    }

    public fun get_last_charged_at_platform_fee<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.fee.last_charged_at
    }

    public fun get_pending_shares_to_redeem<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.pending_shares_to_burn)
    }

    public fun get_vault_admin<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.admin
    }

    public fun get_vault_balance<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_vault_blacklisted<T0, T1>(arg0: &Vault<T0, T1>) : vector<address> {
        arg0.blacklisted
    }

    public fun get_vault_blacklisted_accounts<T0, T1>(arg0: &Vault<T0, T1>) : vector<address> {
        arg0.blacklisted
    }

    public fun get_vault_fee_percentage<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.fee_percentage
    }

    public fun get_vault_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_vault_last_updated_at<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.rate.last_updated_at
    }

    public fun get_vault_max_rate_change_per_update<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.rate.max_rate_change_per_update
    }

    public fun get_vault_max_tvl<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.max_tvl
    }

    public fun get_vault_min_withdrawal_shares<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.min_withdrawal_shares
    }

    public fun get_vault_name<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::string::String {
        arg0.name
    }

    public fun get_vault_operator<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.operator
    }

    public fun get_vault_paused<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.paused
    }

    public fun get_vault_rate<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.rate.value
    }

    public fun get_vault_rate_update_interval<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.rate.rate_update_interval
    }

    public fun get_vault_sequence_number<T0, T1>(arg0: &Vault<T0, T1>) : u128 {
        arg0.sequence_number
    }

    public fun get_vault_sub_accounts<T0, T1>(arg0: &Vault<T0, T1>) : vector<address> {
        arg0.sub_accounts
    }

    public fun get_vault_total_shares<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.receipt_token_treasury_cap)
    }

    public fun get_vault_total_shares_in_circulation<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.receipt_token_treasury_cap) - 0x2::balance::value<T1>(&arg0.pending_shares_to_burn)
    }

    public fun get_vault_tvl<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::math::div(get_vault_total_shares<T0, T1>(arg0), arg0.rate.value)
    }

    public fun get_withdrawal_queue<T0, T1>(arg0: &Vault<T0, T1>) : &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::queue::Queue<WithdrawalRequest> {
        &arg0.pending_withdrawals
    }

    public fun is_blacklisted<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.blacklisted, &arg1)
    }

    public fun mint_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: &mut 0x2::balance::Balance<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_protocol_not_paused(arg1);
        verify_vault_not_paused<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        verify_not_blacklisted<T0, T1>(arg0, v0);
        assert!(arg3 > 0, 2004);
        let v1 = calculate_amount_from_shares<T0, T1>(arg0, arg3);
        assert!(v1 > 0, 2004);
        assert!(0x2::balance::value<T0>(arg2) >= v1, 2007);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::split<T0>(arg2, v1));
        assert!(get_vault_tvl<T0, T1>(arg0) <= arg0.max_tvl, 2016);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_deposit_event<T0>(0x2::object::uid_to_inner(&arg0.id), v0, v1, arg3, 0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<T0>(&arg0.balance), get_vault_total_shares<T0, T1>(arg0), arg0.sequence_number);
        0x2::coin::mint<T1>(&mut arg0.receipt_token_treasury_cap, arg3, arg4)
    }

    fun process_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &WithdrawalRequest, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (bool, bool, u64, u64) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::math::div(arg1.shares, arg0.rate.value);
        let v2 = v1;
        let v3 = 0x2::table::borrow<address, Account>(&arg0.accounts, arg1.owner);
        let v4 = 0x1::vector::length<u128>(&v3.cancel_withdraw_request);
        let (v5, v6) = 0x1::vector::index_of<u128>(&v3.cancel_withdraw_request, &arg1.sequence_number);
        let v7 = if (v5) {
            0x1::option::some<u64>(v6)
        } else {
            0x1::option::none<u64>()
        };
        let v8 = v7;
        let v9 = if (is_blacklisted<T0, T1>(arg0, arg1.owner)) {
            true
        } else if (is_blacklisted<T0, T1>(arg0, arg1.receiver)) {
            true
        } else if (v5) {
            true
        } else {
            v1 == 0
        };
        if (v9) {
            if (!v5) {
                v8 = 0x1::option::some<u64>(v4);
            };
            v2 = 0;
            return_shares_to_owner<T0, T1>(arg0, arg1.shares, arg1.owner, arg3);
        } else {
            burn_shares<T0, T1>(arg0, arg1.shares, arg3);
            assert!(0x2::balance::value<T0>(&arg0.balance) >= v1, 2007);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg3), arg1.receiver);
        };
        update_account_state<T0, T1>(arg0, arg1, false, v8);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_request_processed_event<T0>(v0, arg1.owner, arg1.receiver, arg1.shares, v2, arg1.timestamp, arg2, 0x1::option::is_some<u64>(&v8), v5, get_vault_total_shares<T0, T1>(arg0), 0x2::balance::value<T1>(&arg0.pending_shares_to_burn), arg0.sequence_number, arg1.sequence_number);
        (0x1::option::is_some<u64>(&v8), v5, v2, arg1.shares)
    }

    public fun process_withdrawal_requests<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_protocol_not_paused(arg1);
        verify_vault_not_paused<T0, T1>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.operator, 2000);
        assert!(arg2 > 0, 2004);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x2::object::uid_to_inner(&arg0.id);
        let v6 = 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::queue::len<WithdrawalRequest>(&arg0.pending_withdrawals);
        let v7 = if (arg2 < v6) {
            arg2
        } else {
            v6
        };
        arg0.sequence_number = arg0.sequence_number + 1;
        let v8 = 0;
        while (v8 < v7) {
            let v9 = 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::queue::dequeue<WithdrawalRequest>(&mut arg0.pending_withdrawals);
            let (v10, v11, v12, v13) = process_request<T0, T1>(arg0, &v9, 0x2::clock::timestamp_ms(arg3), arg4);
            v1 = v1 + 1;
            v0 = v0 + v13;
            v2 = v2 + v12;
            if (v10) {
                v3 = v3 + 1;
            };
            if (v11) {
                v4 = v4 + 1;
            };
            v8 = v8 + 1;
        };
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_process_requests_summary_event(v5, v1, v3, v4, v0, v2, get_vault_total_shares<T0, T1>(arg0), 0x2::balance::value<T1>(&arg0.pending_shares_to_burn), arg0.rate.value, arg0.sequence_number);
    }

    public fun process_withdrawal_requests_up_to_timestamp<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_protocol_not_paused(arg1);
        verify_vault_not_paused<T0, T1>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.operator, 2000);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x2::object::uid_to_inner(&arg0.id);
        arg0.sequence_number = arg0.sequence_number + 1;
        while (!0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::queue::is_empty<WithdrawalRequest>(&arg0.pending_withdrawals)) {
            if (0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::queue::peek<WithdrawalRequest>(&arg0.pending_withdrawals).timestamp > arg2) {
                break
            };
            let v6 = 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::queue::dequeue<WithdrawalRequest>(&mut arg0.pending_withdrawals);
            let (v7, v8, v9, v10) = process_request<T0, T1>(arg0, &v6, 0x2::clock::timestamp_ms(arg3), arg4);
            v1 = v1 + 1;
            v0 = v0 + v10;
            v2 = v2 + v9;
            if (v7) {
                v3 = v3 + 1;
            };
            if (v8) {
                v4 = v4 + 1;
            };
        };
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_process_requests_summary_event(v5, v1, v3, v4, v0, v2, get_vault_total_shares<T0, T1>(arg0), 0x2::balance::value<T1>(&arg0.pending_shares_to_burn), arg0.rate.value, arg0.sequence_number);
    }

    public fun redeem_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: 0x2::balance::Balance<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : WithdrawalRequest {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_protocol_not_paused(arg1);
        verify_vault_not_paused<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        verify_not_blacklisted<T0, T1>(arg0, v0);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0x2::balance::value<T1>(&arg2);
        assert!(v2 >= arg0.min_withdrawal_shares, 2009);
        0x2::balance::join<T1>(&mut arg0.pending_shares_to_burn, arg2);
        arg0.sequence_number = arg0.sequence_number + 1;
        let v3 = WithdrawalRequest{
            owner                     : v0,
            receiver                  : arg3,
            shares                    : v2,
            estimated_withdraw_amount : calculate_amount_from_shares<T0, T1>(arg0, v2),
            timestamp                 : 0x2::clock::timestamp_ms(arg4),
            sequence_number           : arg0.sequence_number,
        };
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::queue::enqueue<WithdrawalRequest>(&mut arg0.pending_withdrawals, v3);
        update_account_state<T0, T1>(arg0, &v3, true, 0x1::option::none<u64>());
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_request_redeemed_event<T0>(v1, v3.owner, v3.receiver, v3.shares, v3.timestamp, get_vault_total_shares<T0, T1>(arg0), 0x2::balance::value<T1>(&arg0.pending_shares_to_burn), arg0.sequence_number);
        v3
    }

    fun return_shares_to_owner<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.pending_shares_to_burn, arg1), arg3), arg2);
    }

    public fun set_blacklisted_account<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_protocol_not_paused(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.operator, 2000);
        assert!(!arg3 || !0x1::vector::contains<address>(&arg0.sub_accounts, &arg2), 2001);
        let v0 = &mut arg0.blacklisted;
        update_accounts(v0, arg2, arg3);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_blacklisted_account_updated_event(0x2::object::uid_to_inner(&arg0.id), arg0.blacklisted, arg0.blacklisted, arg2, arg3, arg0.sequence_number);
    }

    public fun set_min_withdrawal_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2000);
        assert!(arg2 > 0, 2004);
        assert!(arg2 != arg0.min_withdrawal_shares, 2011);
        arg0.min_withdrawal_shares = arg2;
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_min_withdrawal_shares_updated_event(0x2::object::uid_to_inner(&arg0.id), arg0.min_withdrawal_shares, arg2, arg0.sequence_number);
    }

    public fun set_sub_account<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 2000);
        assert!(!arg3 || !0x1::vector::contains<address>(&arg0.blacklisted, &arg2), 2008);
        let v0 = &mut arg0.sub_accounts;
        update_accounts(v0, arg2, arg3);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_sub_account_updated_event(0x2::object::uid_to_inner(&arg0.id), arg0.sub_accounts, arg0.sub_accounts, arg2, arg3, arg0.sequence_number);
    }

    public fun set_vault_paused_status<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2000);
        assert!(arg0.paused != arg2, 2005);
        arg0.paused = arg2;
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_paused_status_updated_event(0x2::object::uid_to_inner(&arg0.id), arg2, arg0.sequence_number);
    }

    public fun share_vault<T0, T1>(arg0: Vault<T0, T1>) {
        0x2::transfer::share_object<Vault<T0, T1>>(arg0);
    }

    fun update_account_state<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &WithdrawalRequest, arg2: bool, arg3: 0x1::option::Option<u64>) {
        let v0 = arg2 && 0x1::option::is_some<u64>(&arg3);
        assert!(!v0, 2012);
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1.owner)) {
            let v1 = Account{
                total_pending_withdrawal_shares : 0,
                pending_withdrawal_requests     : 0x1::vector::empty<WithdrawalRequest>(),
                cancel_withdraw_request         : 0x1::vector::empty<u128>(),
            };
            0x2::table::add<address, Account>(&mut arg0.accounts, arg1.owner, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg1.owner);
        if (arg2) {
            v2.total_pending_withdrawal_shares = v2.total_pending_withdrawal_shares + arg1.shares;
            0x1::vector::push_back<WithdrawalRequest>(&mut v2.pending_withdrawal_requests, *arg1);
        } else {
            v2.total_pending_withdrawal_shares = v2.total_pending_withdrawal_shares - arg1.shares;
            0x1::vector::remove<WithdrawalRequest>(&mut v2.pending_withdrawal_requests, 0);
            if (0x1::option::is_some<u64>(&arg3) && *0x1::option::borrow<u64>(&arg3) < 0x1::vector::length<u128>(&v2.cancel_withdraw_request)) {
                0x1::vector::remove<u128>(&mut v2.cancel_withdraw_request, *0x1::option::borrow<u64>(&arg3));
            };
        };
        if (v2.total_pending_withdrawal_shares == 0) {
            0x2::table::remove<address, Account>(&mut arg0.accounts, arg1.owner);
        };
    }

    fun update_accounts(arg0: &mut vector<address>, arg1: address, arg2: bool) {
        let (v0, v1) = 0x1::vector::index_of<address>(arg0, &arg1);
        if (arg2) {
            assert!(!v0, 2015);
            0x1::vector::push_back<address>(arg0, arg1);
        } else {
            assert!(v0, 2012);
            0x1::vector::remove<address>(arg0, v1);
        };
    }

    public fun update_vault_fee_percentage<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2000);
        assert!(arg2 <= 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::get_max_allowed_fee_percentage(arg1), 2003);
        assert!(arg2 != arg0.fee_percentage, 2014);
        arg0.fee_percentage = arg2;
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_fee_percentage_updated_event(0x2::object::uid_to_inner(&arg0.id), arg0.fee_percentage, arg2, arg0.sequence_number);
    }

    public fun update_vault_max_tvl<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2000);
        assert!(arg2 > 0, 2011);
        assert!(arg2 != arg0.max_tvl, 2014);
        assert!(get_vault_tvl<T0, T1>(arg0) <= arg2, 2016);
        arg0.max_tvl = arg2;
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_max_tvl_updated_event(0x2::object::uid_to_inner(&arg0.id), arg0.max_tvl, arg2, arg0.sequence_number);
    }

    public fun update_vault_rate<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_protocol_not_paused(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.operator, 2000);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 - arg0.rate.last_updated_at > arg0.rate.rate_update_interval, 2010);
        arg0.rate.last_updated_at = v0;
        let v1 = if (arg2 >= 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::get_min_rate(arg1)) {
            if (arg2 <= 0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::get_max_rate(arg1)) {
                0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::math::diff_percent(arg0.rate.value, arg2) <= arg0.rate.max_rate_change_per_update
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2002);
        assert!(arg2 != arg0.rate.value, 2014);
        arg0.rate.value = arg2;
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_rate_updated_event(0x2::object::uid_to_inner(&arg0.id), arg0.rate.value, arg2, arg0.sequence_number);
    }

    public fun verify_not_blacklisted<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) {
        assert!(!0x1::vector::contains<address>(&arg0.blacklisted, &arg1), 2008);
    }

    public fun verify_vault_not_paused<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(!arg0.paused, 2006);
    }

    public fun withdraw_from_vault_without_redeeming_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::ProtocolConfig, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_supported_package(arg1);
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::admin::verify_protocol_not_paused(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.operator, 2000);
        assert!(0x1::vector::contains<address>(&arg0.sub_accounts, &arg2), 2001);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<T0>(&arg0.balance), 2007);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg3), arg4), arg2);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x840c554534e835a834d91293f2ac94609bcec8865916828854b8b9fb12439d41::events::emit_vault_withdrawal_without_redeeming_shares_event<T0>(0x2::object::uid_to_inner(&arg0.id), arg2, 0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<T0>(&arg0.balance), arg3, arg0.sequence_number);
    }

    // decompiled from Move bytecode v6
}

