module 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::accountant {
    struct Accountant<phantom T0> has store, key {
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
        version: u64,
    }

    struct PlatformFeeUpdated has copy, drop {
        old_fee: u16,
        new_fee: u16,
    }

    struct PerformanceFeeUpdated has copy, drop {
        old_fee: u16,
        new_fee: u16,
    }

    struct PayoutAddressUpdated has copy, drop {
        old_address: address,
        new_address: address,
    }

    struct DelayInMsecondsUpdated has copy, drop {
        old_delay: u64,
        new_delay: u64,
    }

    struct LowerBoundUpdated has copy, drop {
        old_bound: u16,
        new_bound: u16,
    }

    struct UpperBoundUpdated has copy, drop {
        old_bound: u16,
        new_bound: u16,
    }

    struct ExchangeRateUpdated has copy, drop {
        old_rate: u64,
        new_rate: u64,
        current_time: u64,
    }

    struct VersionUpdated has copy, drop {
        version: u64,
    }

    struct Paused has copy, drop {
        dummy_field: bool,
    }

    struct Unpaused has copy, drop {
        dummy_field: bool,
    }

    struct HighwaterMarkReset has copy, drop {
        dummy_field: bool,
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
            ((v3 * (arg0.platform_fee as u128) / 10000 * (((arg2 - arg0.last_update_timestamp) / 1000) as u128) / 31536000) as u64)
        } else {
            0
        };
        (v2, v1)
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

    public fun get_rate<T0>(arg0: &Accountant<T0>) : u64 {
        arg0.exchange_rate
    }

    public fun get_rate_safe<T0>(arg0: &Accountant<T0>) : u64 {
        assert!(arg0.version == 0, 9);
        assert!(arg0.is_paused == false, 6);
        arg0.exchange_rate
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

    entry fun migrate_accountant<T0>(arg0: &mut Accountant<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg2)), 5);
        arg0.version = 0;
        let v0 = VersionUpdated{version: 0};
        0x2::event::emit<VersionUpdated>(v0);
    }

    public(friend) fun new_accountant<T0>(arg0: address, arg1: u64, arg2: u16, arg3: u16, arg4: u64, arg5: u16, arg6: u16, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : Accountant<T0> {
        Accountant<T0>{
            id                                 : 0x2::object::new(arg8),
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
            version                            : 0,
        }
    }

    public fun pause<T0>(arg0: &mut Accountant<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg2)), 5);
        arg0.is_paused = true;
        let v0 = Paused{dummy_field: false};
        0x2::event::emit<Paused>(v0);
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

    public fun reset_highwater_mark<T0>(arg0: &mut Accountant<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 9);
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        assert!(arg0.exchange_rate <= arg0.highwater_mark, 7);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.exchange_rate;
        calculate_fees_owed<T0>(arg0, v1, v0);
        arg0.total_shares_last_updated = arg0.total_shares;
        arg0.highwater_mark = arg0.exchange_rate;
        arg0.last_update_timestamp = v0;
        let v2 = HighwaterMarkReset{dummy_field: false};
        0x2::event::emit<HighwaterMarkReset>(v2);
    }

    public fun unpause<T0>(arg0: &mut Accountant<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::PauserCap>(arg1, 0x2::tx_context::sender(arg2)), 5);
        arg0.is_paused = false;
        let v0 = Unpaused{dummy_field: false};
        0x2::event::emit<Unpaused>(v0);
    }

    public fun update_delay<T0>(arg0: &mut Accountant<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 1209600000, 0);
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        let v0 = DelayInMsecondsUpdated{
            old_delay : arg0.minimum_update_delay_in_mseconds,
            new_delay : arg2,
        };
        0x2::event::emit<DelayInMsecondsUpdated>(v0);
        arg0.minimum_update_delay_in_mseconds = arg2;
    }

    public fun update_exchange_rate<T0>(arg0: &mut Accountant<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 9);
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::UpdateExchangeRateCap>(arg1, 0x2::tx_context::sender(arg4)), 5);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (before_update_exchange_rate<T0>(arg0, arg2, v0)) {
            arg0.is_paused = true;
        } else {
            calculate_fees_owed<T0>(arg0, arg2, v0);
        };
        arg0.exchange_rate = arg2;
        arg0.total_shares_last_updated = arg0.total_shares;
        arg0.last_update_timestamp = v0;
        let v1 = ExchangeRateUpdated{
            old_rate     : arg0.exchange_rate,
            new_rate     : arg2,
            current_time : v0,
        };
        0x2::event::emit<ExchangeRateUpdated>(v1);
    }

    public fun update_lower<T0>(arg0: &mut Accountant<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 3);
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        let v0 = LowerBoundUpdated{
            old_bound : arg0.allowed_exchange_rate_change_lower,
            new_bound : arg2,
        };
        0x2::event::emit<LowerBoundUpdated>(v0);
        arg0.allowed_exchange_rate_change_lower = arg2;
    }

    public fun update_payout_address<T0>(arg0: &mut Accountant<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        let v0 = PayoutAddressUpdated{
            old_address : arg0.payout_address,
            new_address : arg2,
        };
        0x2::event::emit<PayoutAddressUpdated>(v0);
        arg0.payout_address = arg2;
    }

    public fun update_performance_fee<T0>(arg0: &mut Accountant<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 5000, 2);
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        let v0 = PerformanceFeeUpdated{
            old_fee : arg0.performance_fee,
            new_fee : arg2,
        };
        0x2::event::emit<PerformanceFeeUpdated>(v0);
        arg0.performance_fee = arg2;
    }

    public fun update_platform_fee<T0>(arg0: &mut Accountant<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 2000, 1);
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        let v0 = PlatformFeeUpdated{
            old_fee : arg0.platform_fee,
            new_fee : arg2,
        };
        0x2::event::emit<PlatformFeeUpdated>(v0);
        arg0.platform_fee = arg2;
    }

    public(friend) fun update_total_shares<T0>(arg0: &mut Accountant<T0>, arg1: u64) {
        arg0.total_shares = arg1;
    }

    public fun update_upper<T0>(arg0: &mut Accountant<T0>, arg1: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 >= 10000, 4);
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 5);
        let v0 = UpperBoundUpdated{
            old_bound : arg0.allowed_exchange_rate_change_upper,
            new_bound : arg2,
        };
        0x2::event::emit<UpperBoundUpdated>(v0);
        arg0.allowed_exchange_rate_change_upper = arg2;
    }

    // decompiled from Move bytecode v6
}

