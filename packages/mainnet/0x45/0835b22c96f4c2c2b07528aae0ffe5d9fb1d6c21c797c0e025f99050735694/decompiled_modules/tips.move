module 0x917c638abf4a84ae95edb94ce1f96b39f9a8702373ff95b9d4c58a174ce2a5f9::tips {
    struct TipPayment has drop {
        dummy_field: bool,
    }

    struct TipFeePolicy has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        treasury: address,
        mode: u8,
    }

    struct TipFeePolicyAdminCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct TipIntent has key {
        id: 0x2::object::UID,
        fan_vault_id: 0x2::object::ID,
        spender_cap_id: 0x2::object::ID,
        creator_vault_id: 0x2::object::ID,
        fee_policy_id: 0x2::object::ID,
        amount: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money,
        min_amount: u64,
        exact_charge: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money,
        fee_bps: u64,
        fee_mode: u8,
        coin_type: 0x1::type_name::TypeName,
        max_raw: u64,
        expires_at_ms: u64,
        status: u8,
    }

    struct TipFeePolicyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        fee_bps: u64,
        treasury: address,
        mode: u8,
    }

    struct TipSettled has copy, drop {
        fan_vault_id: 0x2::object::ID,
        creator_vault_id: 0x2::object::ID,
        nominal_currency: 0x1::type_name::TypeName,
        nominal_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        raw_total: u64,
        raw_creator_proceeds: u64,
        raw_fee: u64,
        rate: u64,
        rate_decimals: u8,
        rate_updated_at_ms: u64,
        rate_source: address,
        treasury: address,
        settled_at_ms: u64,
        by: address,
    }

    struct TipIntentCreated has copy, drop {
        intent_id: 0x2::object::ID,
        fan_vault_id: 0x2::object::ID,
        creator_vault_id: 0x2::object::ID,
        spender_cap_id: 0x2::object::ID,
        amount: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money,
        min_amount: u64,
        exact_charge: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money,
        fee_bps: u64,
        fee_mode: u8,
        coin_type: 0x1::type_name::TypeName,
        max_raw: u64,
        expires_at_ms: u64,
    }

    struct TipIntentCancelled has copy, drop {
        intent_id: 0x2::object::ID,
        fan_vault_id: 0x2::object::ID,
    }

    struct TipIntentClosed has copy, drop {
        intent_id: 0x2::object::ID,
        spender_cap_id: 0x2::object::ID,
        status: u8,
    }

    struct TipIntentConsumed has copy, drop {
        intent_id: 0x2::object::ID,
        fan_vault_id: 0x2::object::ID,
        creator_vault_id: 0x2::object::ID,
        nominal_currency: 0x1::type_name::TypeName,
        ordered_amount: u64,
        settled_amount: u64,
        min_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        raw_total: u64,
        raw_fee: u64,
    }

    public fun active_intent_status() : u8 {
        0
    }

    public fun additive_fee_mode() : u8 {
        1
    }

    fun affordable_base(arg0: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::RateEntry, arg1: u64, arg2: u8, arg3: u64) : u64 {
        let v0 = 0x1::u128::min((((arg3 as u128) + 1) * (0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::entry_rate(arg0) as u128) - 1) / pow10((0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::entry_coin_decimals(arg0) as u64) + (0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::entry_rate_decimals(arg0) as u64)), 18446744073709551615);
        if (arg2 == 0) {
            return (v0 as u64)
        };
        let v1 = (10000 as u128);
        let v2 = v0 * v1 / (v1 + (arg1 as u128));
        let v3 = v2 + 1;
        let v4 = if (v3 + v3 * (arg1 as u128) / v1 <= v0) {
            v3
        } else {
            v2
        };
        (v4 as u64)
    }

    fun assert_creator_vault(arg0: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::VaultRole, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault) {
        assert!(0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::binding_vault_id(arg0) == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg1) && 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::binding_role(arg0) == 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::creator_role(), 13836467685024071689);
    }

    fun assert_fee_terms(arg0: u64, arg1: address, arg2: u8) {
        assert!(arg0 <= 3000, 13835341686332456961);
        assert!(arg1 != @0x0, 13835623165604265987);
        assert!(arg2 == 0 || arg2 == 1, 13835341694922391553);
    }

    public fun cancel_tip_intent(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: &mut TipIntent, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0), 13836748756273987595);
        assert!(arg2.status != 1, 13837030235545796621);
        if (is_intent_terminal(arg2)) {
            return
        };
        0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::revoke_all_allowances(arg0, arg1, arg2.spender_cap_id, arg3);
        finish_cancel_tip_intent(arg2);
    }

    public fun cancel_tip_intent_as_user(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &mut TipIntent, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TipPayment{dummy_field: false};
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::assert_tip_payment<TipPayment>(arg0, v0, arg2);
        assert!(arg1.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0), 13836748799223660555);
        assert!(arg1.status != 1, 13837030278495469581);
        if (is_intent_terminal(arg1)) {
            return
        };
        let v1 = TipPayment{dummy_field: false};
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::revoke_tip_payment<TipPayment>(arg0, v1, arg1.spender_cap_id, arg2);
        finish_cancel_tip_intent(arg1);
    }

    public fun cancelled_intent_status() : u8 {
        2
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 13835904662055944197);
        arg0 + arg1
    }

    public fun close_expired_tip_intent(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &mut TipIntent, arg2: 0x2::transfer::Receiving<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0), 13836748876533071883);
        let v0 = arg1.status == 0 && 0x2::clock::timestamp_ms(arg3) >= arg1.expires_at_ms;
        assert!(is_intent_terminal(arg1) || v0, 13839000684937740315);
        let v1 = 0x2::transfer::public_receive<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&mut arg1.id, arg2);
        assert!(0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&v1) == arg1.spender_cap_id, 13838719218550833177);
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::renounce(arg0, v1, arg4);
        if (v0) {
            arg1.status = 3;
        };
        let v2 = TipIntentClosed{
            intent_id      : 0x2::object::id<TipIntent>(arg1),
            spender_cap_id : arg1.spender_cap_id,
            status         : arg1.status,
        };
        0x2::event::emit<TipIntentClosed>(v2);
    }

    public fun consumed_intent_status() : u8 {
        1
    }

    public fun create_tip_intent<T0>(arg0: &TipFeePolicy, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg3: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg4: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::VaultRole, arg5: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg6: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::mint_spender_cap(arg2, arg3, arg11);
        0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::set_allowance<T0>(arg2, arg3, 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&v0), arg8, arg9, 0x1::option::none<u64>(), arg10, arg11);
        finish_tip_intent<T0>(arg0, arg2, arg5, v0, arg6, arg7, prepare_tip_intent<T0>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10), arg8, arg9, arg11)
    }

    public fun create_tip_intent_as_user<T0>(arg0: &TipFeePolicy, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg3: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::VaultRole, arg4: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg5: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = TipPayment{dummy_field: false};
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::assert_tip_payment<TipPayment>(arg2, v0, arg10);
        let v1 = TipPayment{dummy_field: false};
        let v2 = 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::mint_tip_payment_cap<TipPayment>(arg2, v1, arg10);
        let v3 = TipPayment{dummy_field: false};
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::set_tip_payment_allowance<T0, TipPayment>(arg2, v3, &v2, arg7, arg8, arg9, arg10);
        finish_tip_intent<T0>(arg0, arg2, arg4, v2, arg5, arg6, prepare_tip_intent<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9), arg7, arg8, arg10)
    }

    public fun expired_intent_status() : u8 {
        3
    }

    public fun fee_policy_fee_bps(arg0: &TipFeePolicy) : u64 {
        arg0.fee_bps
    }

    public fun fee_policy_mode(arg0: &TipFeePolicy) : u8 {
        arg0.mode
    }

    public fun fee_policy_treasury(arg0: &TipFeePolicy) : address {
        arg0.treasury
    }

    fun finish_cancel_tip_intent(arg0: &mut TipIntent) {
        arg0.status = 2;
        let v0 = TipIntentCancelled{
            intent_id    : 0x2::object::id<TipIntent>(arg0),
            fan_vault_id : arg0.fan_vault_id,
        };
        0x2::event::emit<TipIntentCancelled>(v0);
    }

    fun finish_tip<T0>(arg0: &TipFeePolicy, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg2: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg3: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg4: u64, arg5: u64, arg6: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::RateSnapshot, arg7: 0x2::balance::Balance<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = arg4 - arg5;
        if (arg5 > 0) {
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg7, arg5), arg0.treasury);
        };
        if (v0 > 0) {
            0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::deposit_balance<T0>(arg2, arg7, arg9);
        } else {
            0x2::balance::destroy_zero<T0>(arg7);
        };
        let v1 = TipSettled{
            fan_vault_id         : 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg1),
            creator_vault_id     : 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg2),
            nominal_currency     : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg3),
            nominal_amount       : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&arg3),
            coin_type            : 0x1::type_name::with_defining_ids<T0>(),
            raw_total            : arg4,
            raw_creator_proceeds : v0,
            raw_fee              : arg5,
            rate                 : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::snapshot_rate(&arg6),
            rate_decimals        : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::snapshot_rate_decimals(&arg6),
            rate_updated_at_ms   : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::snapshot_updated_at_ms(&arg6),
            rate_source          : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::snapshot_source(&arg6),
            treasury             : arg0.treasury,
            settled_at_ms        : 0x2::clock::timestamp_ms(arg8),
            by                   : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<TipSettled>(v1);
    }

    fun finish_tip_intent<T0>(arg0: &TipFeePolicy, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg2: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg3: 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap, arg4: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg5: u64, arg6: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg1);
        let v1 = 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg2);
        let v2 = 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&arg3);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        let v4 = arg0.fee_bps;
        let v5 = arg0.mode;
        let v6 = TipIntent{
            id               : 0x2::object::new(arg9),
            fan_vault_id     : v0,
            spender_cap_id   : v2,
            creator_vault_id : v1,
            fee_policy_id    : 0x2::object::id<TipFeePolicy>(arg0),
            amount           : arg4,
            min_amount       : arg5,
            exact_charge     : arg6,
            fee_bps          : v4,
            fee_mode         : v5,
            coin_type        : v3,
            max_raw          : arg7,
            expires_at_ms    : arg8,
            status           : 0,
        };
        let v7 = 0x2::object::id<TipIntent>(&v6);
        0x2::transfer::public_transfer<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(arg3, 0x2::object::id_to_address(&v7));
        let v8 = TipIntentCreated{
            intent_id        : v7,
            fan_vault_id     : v0,
            creator_vault_id : v1,
            spender_cap_id   : v2,
            amount           : arg4,
            min_amount       : arg5,
            exact_charge     : arg6,
            fee_bps          : v4,
            fee_mode         : v5,
            coin_type        : v3,
            max_raw          : arg7,
            expires_at_ms    : arg8,
        };
        0x2::event::emit<TipIntentCreated>(v8);
        0x2::transfer::share_object<TipIntent>(v6);
        v7
    }

    public fun included_fee_mode() : u8 {
        0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let (v1, v2) = new_fee_policy(0, v0, 0, arg0);
        0x2::transfer::share_object<TipFeePolicy>(v1);
        0x2::transfer::public_transfer<TipFeePolicyAdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun is_intent_terminal(arg0: &TipIntent) : bool {
        arg0.status == 2 || arg0.status == 3
    }

    public fun max_fee_bps() : u64 {
        3000
    }

    public fun max_tip_intent_lifetime_ms() : u64 {
        86400000
    }

    fun new_fee_policy(arg0: u64, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (TipFeePolicy, TipFeePolicyAdminCap) {
        assert_fee_terms(arg0, arg1, arg2);
        let v0 = TipFeePolicy{
            id       : 0x2::object::new(arg3),
            fee_bps  : arg0,
            treasury : arg1,
            mode     : arg2,
        };
        let v1 = TipFeePolicyAdminCap{
            id        : 0x2::object::new(arg3),
            policy_id : 0x2::object::id<TipFeePolicy>(&v0),
        };
        (v0, v1)
    }

    fun pow10(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun prepare_tip<T0>(arg0: &TipFeePolicy, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::VaultRole, arg3: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg4: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg5: &0x2::clock::Clock) : (u64, u64, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::RateSnapshot) {
        assert!(0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&arg4) > 0, 13836186171392524295);
        assert_creator_vault(arg2, arg3);
        tip_units<T0>(arg1, arg0.fee_bps, arg0.mode, arg4, arg5)
    }

    fun prepare_tip_intent<T0>(arg0: &TipFeePolicy, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::VaultRole, arg3: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg4: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg7 > v0, 13837593700895555601);
        assert!(arg7 - v0 <= 86400000, 13840126984277065763);
        let (v1, _, _) = prepare_tip<T0>(arg0, arg1, arg2, arg3, arg4, arg8);
        assert!(arg5 > 0 && arg5 <= 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&arg4), 13839282567936475165);
        assert!(v1 <= arg6, 13837875197347233811);
        let (v4, _, _) = tip_units<T0>(arg1, arg0.fee_bps, arg0.mode, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_from_parts(arg5, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg4)), arg8);
        assert!(v4 > 0, 13836186368961019911);
        let (v7, _, _) = quote(arg0, arg4);
        v7
    }

    public fun quote(arg0: &TipFeePolicy, arg1: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money) : (0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money) {
        quote_terms(arg0.fee_bps, arg0.mode, arg1)
    }

    public fun quote_terms(arg0: u64, arg1: u8, arg2: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money) : (0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money) {
        assert!(arg0 <= 3000 && (arg1 == 0 || arg1 == 1), 13835340582525861889);
        let v0 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&arg2);
        let v1 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg2);
        let v2 = (v0 as u128) * (arg0 as u128) / (10000 as u128);
        assert!(v2 <= 18446744073709551615, 13835903549659414533);
        let v3 = (v2 as u64);
        let (v4, v5) = if (arg1 == 0) {
            (arg2, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_from_parts(v0 - v3, v1))
        } else {
            (0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_from_parts(checked_add(v0, v3), v1), arg2)
        };
        (v4, v5, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_from_parts(v3, v1))
    }

    fun settle_held<T0, T1>(arg0: &TipFeePolicy, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg3: &mut TipIntent, arg4: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::VaultRole, arg5: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg6: 0x2::transfer::Receiving<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.status == 0, 13837031073064419341);
        assert!(0x2::clock::timestamp_ms(arg8) < arg3.expires_at_ms, 13837312552336228367);
        let v0 = if (arg3.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg2)) {
            if (arg3.creator_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg5)) {
                arg3.fee_policy_id == 0x2::object::id<TipFeePolicy>(arg0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13836749623857381387);
        assert!(arg3.coin_type == 0x1::type_name::with_defining_ids<T1>(), 13838438482308366359);
        let v1 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg3.amount);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 13839845865782509601);
        assert_creator_vault(arg4, arg5);
        let v2 = arg3.fee_bps;
        let v3 = arg3.fee_mode;
        let v4 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&arg3.amount);
        let (v5, v6, v7) = tip_units<T1>(arg1, v2, v3, arg3.amount, arg8);
        assert!(v5 <= arg3.max_raw, 13837875575304355859);
        let (v8, v9, v10, v11) = if (v5 <= arg7) {
            (v4, v5, v6, v7)
        } else {
            let v12 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::rate_entry<T0, T1>(arg1);
            let v13 = 0x1::u64::min(affordable_base(&v12, v2, v3, arg7), v4);
            let (v14, v15, v16) = tip_units<T1>(arg1, v2, v3, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_from_parts(v13, v1), arg8);
            (v13, v14, v15, v16)
        };
        assert!(v8 >= arg3.min_amount, 13839564472410046495);
        let v17 = 0x2::transfer::public_receive<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&mut arg3.id, arg6);
        assert!(0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&v17) == arg3.spender_cap_id, 13838720060364423193);
        let v18 = 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::spend<T1>(arg2, &v17, v9, arg8, arg9);
        finish_tip<T1>(arg0, arg2, arg5, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_from_parts(v8, v1), v9, v10, v11, v18, arg8, arg9);
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::renounce(arg2, v17, arg9);
        arg3.status = 1;
        let v19 = TipIntentConsumed{
            intent_id        : 0x2::object::id<TipIntent>(arg3),
            fan_vault_id     : arg3.fan_vault_id,
            creator_vault_id : arg3.creator_vault_id,
            nominal_currency : v1,
            ordered_amount   : v4,
            settled_amount   : v8,
            min_amount       : arg3.min_amount,
            coin_type        : arg3.coin_type,
            raw_total        : v9,
            raw_fee          : v10,
        };
        0x2::event::emit<TipIntentConsumed>(v19);
    }

    public fun settle_tip_intent<T0, T1>(arg0: &TipFeePolicy, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg3: &mut TipIntent, arg4: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::VaultRole, arg5: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg6: 0x2::transfer::Receiving<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>, arg7: &0x2::accumulator::AccumulatorRoot, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::balance_value<T1>(arg2, arg7);
        settle_held<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg8, arg9);
    }

    public fun tip<T0>(arg0: &TipFeePolicy, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg3: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg4: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::VaultRole, arg5: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg6: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = prepare_tip<T0>(arg0, arg1, arg4, arg5, arg6, arg7);
        let v3 = 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::withdraw<T0>(arg2, arg3, v0, arg8);
        finish_tip<T0>(arg0, arg2, arg5, arg6, v0, v1, v2, v3, arg7, arg8);
    }

    public fun tip_as_user<T0>(arg0: &TipFeePolicy, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg3: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::VaultRole, arg4: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg5: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = prepare_tip<T0>(arg0, arg1, arg3, arg4, arg5, arg6);
        let v3 = TipPayment{dummy_field: false};
        let v4 = 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::withdraw_tip_payment<T0, TipPayment>(arg2, v3, v0, arg7);
        finish_tip<T0>(arg0, arg2, arg4, arg5, v0, v1, v2, v4, arg6, arg7);
    }

    public fun tip_intent_amount(arg0: &TipIntent) : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money {
        arg0.amount
    }

    public fun tip_intent_coin_type(arg0: &TipIntent) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun tip_intent_creator_vault_id(arg0: &TipIntent) : 0x2::object::ID {
        arg0.creator_vault_id
    }

    public fun tip_intent_exact_charge(arg0: &TipIntent) : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money {
        arg0.exact_charge
    }

    public fun tip_intent_expires_at_ms(arg0: &TipIntent) : u64 {
        arg0.expires_at_ms
    }

    public fun tip_intent_fan_vault_id(arg0: &TipIntent) : 0x2::object::ID {
        arg0.fan_vault_id
    }

    public fun tip_intent_fee_bps(arg0: &TipIntent) : u64 {
        arg0.fee_bps
    }

    public fun tip_intent_fee_mode(arg0: &TipIntent) : u8 {
        arg0.fee_mode
    }

    public fun tip_intent_max_raw(arg0: &TipIntent) : u64 {
        arg0.max_raw
    }

    public fun tip_intent_min_amount(arg0: &TipIntent) : u64 {
        arg0.min_amount
    }

    public fun tip_intent_spender_cap_id(arg0: &TipIntent) : 0x2::object::ID {
        arg0.spender_cap_id
    }

    public fun tip_intent_status(arg0: &TipIntent) : u8 {
        arg0.status
    }

    fun tip_units<T0>(arg0: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg1: u64, arg2: u8, arg3: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg4: &0x2::clock::Clock) : (u64, u64, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::RateSnapshot) {
        let (v0, _, v2) = quote_terms(arg1, arg2, arg3);
        let (v3, v4) = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::to_coin_units<T0>(arg0, v0, arg4);
        let (v5, _) = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::to_coin_units<T0>(arg0, v2, arg4);
        (v3, v5, v4)
    }

    public fun update_fee_policy(arg0: &mut TipFeePolicy, arg1: &TipFeePolicyAdminCap, arg2: u64, arg3: address, arg4: u8) {
        assert!(arg1.policy_id == 0x2::object::id<TipFeePolicy>(arg0), 13835340496626515969);
        assert_fee_terms(arg2, arg3, arg4);
        arg0.fee_bps = arg2;
        arg0.treasury = arg3;
        arg0.mode = arg4;
        let v0 = TipFeePolicyUpdated{
            policy_id : 0x2::object::id<TipFeePolicy>(arg0),
            fee_bps   : arg2,
            treasury  : arg3,
            mode      : arg4,
        };
        0x2::event::emit<TipFeePolicyUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

