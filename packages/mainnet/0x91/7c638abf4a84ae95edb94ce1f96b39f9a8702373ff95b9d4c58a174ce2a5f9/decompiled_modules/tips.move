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

    public fun additive_fee_mode() : u8 {
        1
    }

    fun assert_fee_terms(arg0: u64, arg1: address, arg2: u8) {
        assert!(arg0 <= 3000, 13835340367777497089);
        assert!(arg1 != @0x0, 13835621847049306115);
        assert!(arg2 == 0 || arg2 == 1, 13835340376367431681);
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 13835903343500984325);
        arg0 + arg1
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

    public fun included_fee_mode() : u8 {
        0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let (v1, v2) = new_fee_policy(0, v0, 0, arg0);
        0x2::transfer::share_object<TipFeePolicy>(v1);
        0x2::transfer::public_transfer<TipFeePolicyAdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun max_fee_bps() : u64 {
        3000
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

    fun prepare_tip<T0>(arg0: &TipFeePolicy, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::VaultRole, arg3: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg4: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg5: &0x2::clock::Clock) : (u64, u64, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::RateSnapshot) {
        assert!(0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&arg4) > 0, 13836184852837564423);
        assert!(0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::binding_vault_id(arg2) == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg3) && 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::binding_role(arg2) == 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::creator_role(), 13836466344994275337);
        let (v0, _, v2) = quote(arg0, arg4);
        let (v3, v4) = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::to_coin_units<T0>(arg1, v0, arg5);
        let (v5, _) = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::to_coin_units<T0>(arg1, v2, arg5);
        (v3, v5, v4)
    }

    public fun quote(arg0: &TipFeePolicy, arg1: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money) : (0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money) {
        let v0 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&arg1);
        let v1 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg1);
        let v2 = (v0 as u128) * (arg0.fee_bps as u128) / (10000 as u128);
        assert!(v2 <= 18446744073709551615, 13835902982723731461);
        let v3 = (v2 as u64);
        let (v4, v5) = if (arg0.mode == 0) {
            (arg1, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_from_parts(v0 - v3, v1))
        } else {
            (0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_from_parts(checked_add(v0, v3), v1), arg1)
        };
        (v4, v5, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_from_parts(v3, v1))
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

    public fun update_fee_policy(arg0: &mut TipFeePolicy, arg1: &TipFeePolicyAdminCap, arg2: u64, arg3: address, arg4: u8) {
        assert!(arg1.policy_id == 0x2::object::id<TipFeePolicy>(arg0), 13835339972640505857);
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

