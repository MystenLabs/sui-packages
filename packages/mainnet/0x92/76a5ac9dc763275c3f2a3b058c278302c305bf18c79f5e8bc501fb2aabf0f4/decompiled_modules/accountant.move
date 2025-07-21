module 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant {
    struct Accountant<phantom T0> has key {
        id: 0x2::object::UID,
        payout_address: address,
        highwater_mark: u64,
        fees_owed_in_base: u64,
        total_shares_last_updated: u64,
        exchange_rate: u64,
        allowed_exchange_rate_change_upper: u16,
        allowed_exchange_rate_change_lower: u16,
        last_update_timestamp: u64,
        is_paused: bool,
        minimum_update_delay_in_mseconds: u64,
        platform_fee: u16,
        performance_fee: u16,
        total_shares: u64,
        one_share: u64,
        share_decimals: u8,
        base_asset_type: 0x1::type_name::TypeName,
        staleness_seconds: u64,
        slippage_pct_threshold: u64,
        version: u64,
    }

    fun before_update_exchange_rate<T0>(arg0: &Accountant<T0>, arg1: u64, arg2: u64) : bool {
        assert!(arg0.is_paused == false, 6);
        let v0 = arg0.exchange_rate;
        if (arg2 < arg0.last_update_timestamp + arg0.minimum_update_delay_in_mseconds) {
            true
        } else if (arg1 > v0 * (arg0.allowed_exchange_rate_change_upper as u64) / 10000) {
            true
        } else {
            arg1 < v0 * (arg0.allowed_exchange_rate_change_lower as u64) / 10000
        }
    }

    fun calculate_fees_owed<T0>(arg0: &mut Accountant<T0>, arg1: u64, arg2: u64) {
        let (v0, v1) = calculate_platform_fee<T0>(arg0, arg1, arg2);
        let v2 = v0;
        if (arg1 > arg0.highwater_mark) {
            v2 = v0 + calculate_performance_fee<T0>(arg0, arg1, v1);
            arg0.highwater_mark = arg1;
        };
        arg0.fees_owed_in_base = arg0.fees_owed_in_base + v2;
    }

    fun calculate_performance_fee<T0>(arg0: &Accountant<T0>, arg1: u64, arg2: u64) : u64 {
        if (arg0.performance_fee > 0) {
            (arg1 - arg0.highwater_mark) * arg2 / (arg0.one_share as u64) * (arg0.performance_fee as u64) / 10000
        } else {
            0
        }
    }

    fun calculate_platform_fee<T0>(arg0: &Accountant<T0>, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = arg0.total_shares;
        let v1 = v0;
        if (arg0.total_shares_last_updated < v0) {
            v1 = arg0.total_shares_last_updated;
        };
        let v2 = if (arg0.platform_fee > 0) {
            let v3 = if (arg1 > arg0.exchange_rate) {
                (v1 as u128) * (arg0.exchange_rate as u128) / (arg0.one_share as u128)
            } else {
                (v1 as u128) * (arg1 as u128) / (arg0.one_share as u128)
            };
            let v4 = 0x1::u128::try_as_u64(v3 * (arg0.platform_fee as u128) / 10000 * (((arg2 - arg0.last_update_timestamp) / 1000) as u128) / 31536000);
            assert!(0x1::option::is_some<u64>(&v4), 10);
            0x1::option::extract<u64>(&mut v4)
        } else {
            0
        };
        (v2, v1)
    }

    public fun get_base_asset_type<T0>(arg0: &Accountant<T0>) : 0x1::type_name::TypeName {
        arg0.base_asset_type
    }

    public fun get_delay<T0>(arg0: &Accountant<T0>) : u64 {
        arg0.minimum_update_delay_in_mseconds
    }

    public fun get_fees_owed_in_base<T0>(arg0: &Accountant<T0>) : u64 {
        arg0.fees_owed_in_base
    }

    public fun get_highwater_mark<T0>(arg0: &Accountant<T0>) : u64 {
        arg0.highwater_mark
    }

    public fun get_last_update_timestamp<T0>(arg0: &Accountant<T0>) : u64 {
        arg0.last_update_timestamp
    }

    public fun get_lower<T0>(arg0: &Accountant<T0>) : u16 {
        arg0.allowed_exchange_rate_change_lower
    }

    public fun get_one_share<T0>(arg0: &Accountant<T0>) : u64 {
        arg0.one_share
    }

    public fun get_payout_address<T0>(arg0: &Accountant<T0>) : address {
        arg0.payout_address
    }

    public fun get_performance_fee<T0>(arg0: &Accountant<T0>) : u16 {
        arg0.performance_fee
    }

    public fun get_platform_fee<T0>(arg0: &Accountant<T0>) : u16 {
        arg0.platform_fee
    }

    public fun get_rate<T0, T1>(arg0: &Accountant<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::PriceFeedsMap<T0>, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(v0));
        if (v0 == arg0.base_asset_type || 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::is_pegged_to_base<T0>(&v1, arg3)) {
            return arg0.exchange_rate
        };
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle_operations::divide_safe(arg0.exchange_rate, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle_operations::transform_price_to_decimal_format(get_rate_from_oracle<T0, T1>(arg0, arg1, arg2, arg3, arg4)), arg0.one_share)
    }

    fun get_rate_from_oracle<T0, T1>(arg0: &Accountant<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::PriceFeedsMap<T0>, arg4: &0x2::clock::Clock) : 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle_operations::PriceRatioResult {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(arg0.base_asset_type));
        assert!(v0 != v1, 13906835716236640255);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle_operations::calculate_price_ratio(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::get_price<T0>(arg4, arg2, &v0, arg3, arg0.staleness_seconds, arg0.slippage_pct_threshold), 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::get_price<T0>(arg4, arg1, &v1, arg3, arg0.staleness_seconds, arg0.slippage_pct_threshold), arg0.one_share)
    }

    public fun get_rate_safe<T0, T1>(arg0: &Accountant<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::PriceFeedsMap<T0>, arg4: &0x2::clock::Clock) : u64 {
        assert!(arg0.version == 0, 9);
        assert!(arg0.is_paused == false, 6);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(v0));
        if (v0 == arg0.base_asset_type || 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::is_pegged_to_base<T0>(&v1, arg3)) {
            return arg0.exchange_rate
        };
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle_operations::divide_safe(arg0.exchange_rate, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle_operations::transform_price_to_decimal_format(get_rate_from_oracle<T0, T1>(arg0, arg1, arg2, arg3, arg4)), arg0.one_share)
    }

    public fun get_total_shares<T0>(arg0: &Accountant<T0>) : u64 {
        arg0.total_shares
    }

    public fun get_upper<T0>(arg0: &Accountant<T0>) : u16 {
        arg0.allowed_exchange_rate_change_upper
    }

    public fun is_paused<T0>(arg0: &Accountant<T0>) : bool {
        arg0.is_paused
    }

    entry fun migrate_accountant<T0>(arg0: &mut Accountant<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg2)), 5);
        arg0.version = 0;
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_version_accountant_updated<T0>(0);
    }

    public(friend) fun new_accountant<T0>(arg0: address, arg1: u64, arg2: u16, arg3: u16, arg4: u64, arg5: u16, arg6: u16, arg7: u64, arg8: u8, arg9: 0x1::type_name::TypeName, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : Accountant<T0> {
        Accountant<T0>{
            id                                 : 0x2::object::new(arg12),
            payout_address                     : arg0,
            highwater_mark                     : arg1,
            fees_owed_in_base                  : 0,
            total_shares_last_updated          : 0,
            exchange_rate                      : arg1,
            allowed_exchange_rate_change_upper : arg2,
            allowed_exchange_rate_change_lower : arg3,
            last_update_timestamp              : 0,
            is_paused                          : false,
            minimum_update_delay_in_mseconds   : arg4,
            platform_fee                       : arg5,
            performance_fee                    : arg6,
            total_shares                       : 0,
            one_share                          : arg7,
            share_decimals                     : arg8,
            base_asset_type                    : arg9,
            staleness_seconds                  : arg10,
            slippage_pct_threshold             : arg11,
            version                            : 0,
        }
    }

    public fun pause<T0>(arg0: &mut Accountant<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg2)), 5);
        arg0.is_paused = true;
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_paused<T0>();
    }

    public fun preview_update_exchange_rate<T0>(arg0: &Accountant<T0>, arg1: u64, arg2: &0x2::clock::Clock) : (bool, u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (!before_update_exchange_rate<T0>(arg0, arg1, v0)) {
            let (v4, v5) = calculate_platform_fee<T0>(arg0, arg1, v0);
            let v6 = v4;
            if (arg1 > arg0.highwater_mark) {
                v6 = v4 + calculate_performance_fee<T0>(arg0, arg1, v5);
            };
            (false, v6, arg0.fees_owed_in_base + v6)
        } else {
            (true, 0, arg0.fees_owed_in_base)
        }
    }

    public(friend) fun reset_fees_owed_in_base<T0>(arg0: &mut Accountant<T0>) {
        arg0.fees_owed_in_base = 0;
    }

    public fun reset_highwater_mark<T0>(arg0: &mut Accountant<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 9);
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        assert!(arg0.exchange_rate <= arg0.highwater_mark, 7);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.exchange_rate;
        calculate_fees_owed<T0>(arg0, v1, v0);
        arg0.total_shares_last_updated = arg0.total_shares;
        arg0.highwater_mark = arg0.exchange_rate;
        arg0.last_update_timestamp = v0;
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_highwater_mark_reset<T0>();
    }

    public fun share<T0>(arg0: Accountant<T0>) {
        0x2::transfer::share_object<Accountant<T0>>(arg0);
    }

    public fun unpause<T0>(arg0: &mut Accountant<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg2)), 5);
        arg0.is_paused = false;
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_unpaused<T0>();
    }

    public fun update_delay<T0>(arg0: &mut Accountant<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 1209600000, 0);
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_delay_in_mseconds_updated<T0>(arg0.minimum_update_delay_in_mseconds, arg2);
        arg0.minimum_update_delay_in_mseconds = arg2;
    }

    public fun update_exchange_rate<T0>(arg0: &mut Accountant<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 9);
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::UpdateExchangeRateCap>(arg1, 0x2::tx_context::sender(arg4)), 5);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (before_update_exchange_rate<T0>(arg0, arg2, v0)) {
            arg0.is_paused = true;
        } else {
            calculate_fees_owed<T0>(arg0, arg2, v0);
        };
        arg0.exchange_rate = arg2;
        arg0.total_shares_last_updated = arg0.total_shares;
        arg0.last_update_timestamp = v0;
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_exchange_rate_updated<T0>(arg0.exchange_rate, arg2, v0);
    }

    public fun update_lower<T0>(arg0: &mut Accountant<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 3);
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_lower_bound_updated<T0>(arg0.allowed_exchange_rate_change_lower, arg2);
        arg0.allowed_exchange_rate_change_lower = arg2;
    }

    public fun update_payout_address<T0>(arg0: &mut Accountant<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_payout_address_updated<T0>(arg0.payout_address, arg2);
        arg0.payout_address = arg2;
    }

    public fun update_performance_fee<T0>(arg0: &mut Accountant<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 5000, 2);
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_performance_fee_updated<T0>(arg0.performance_fee, arg2);
        arg0.performance_fee = arg2;
    }

    public fun update_platform_fee<T0>(arg0: &mut Accountant<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 2000, 1);
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_platform_fee_updated<T0>(arg0.platform_fee, arg2);
        arg0.platform_fee = arg2;
    }

    public fun update_slippage_threshold<T0>(arg0: &mut Accountant<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_slippage_threshold_updated<T0>(arg0.slippage_pct_threshold, arg2);
        arg0.slippage_pct_threshold = arg2;
    }

    public fun update_staleness_threshold<T0>(arg0: &mut Accountant<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_staleness_threshold_updated<T0>(arg0.staleness_seconds, arg2);
        arg0.staleness_seconds = arg2;
    }

    public(friend) fun update_total_shares<T0>(arg0: &mut Accountant<T0>, arg1: u64) {
        arg0.total_shares = arg1;
    }

    public fun update_upper<T0>(arg0: &mut Accountant<T0>, arg1: &0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::Auth<T0>, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 >= 10000, 4);
        assert!(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::has_cap<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::events::emit_upper_bound_updated<T0>(arg0.allowed_exchange_rate_change_upper, arg2);
        arg0.allowed_exchange_rate_change_upper = arg2;
    }

    // decompiled from Move bytecode v6
}

