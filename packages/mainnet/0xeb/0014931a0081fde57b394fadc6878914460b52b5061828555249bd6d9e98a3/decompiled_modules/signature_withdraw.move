module 0xeb0014931a0081fde57b394fadc6878914460b52b5061828555249bd6d9e98a3::signature_withdraw {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct UserWithdrawRecord has copy, drop, store {
        nonce: u64,
        total_withdrawn: u64,
        last_withdraw_time: u64,
        withdraw_count_in_hour: u64,
        hour_window_start: u64,
    }

    struct PlatformStats has copy, drop, store {
        total_deposits: u64,
        total_withdrawals: u64,
        total_deposit_count: u64,
        total_withdrawal_count: u64,
        unique_depositors: u64,
        unique_withdrawers: u64,
        emergency_withdrawals: u64,
        emergency_withdrawal_count: u64,
    }

    struct DailyWithdrawRecord has copy, drop, store {
        date: u64,
        amount: u64,
    }

    struct WithdrawConfig has copy, drop, store {
        min_withdraw_amount: u64,
        daily_withdraw_limit: u64,
        withdraw_cooldown: u64,
        hourly_withdraw_limit: u64,
        signature_expiration: u64,
    }

    struct UserWithdrawLimit has copy, drop, store {
        max_single_withdraw: u64,
        daily_limit: u64,
        total_limit: u64,
        enabled: bool,
    }

    struct UserLimitUsage has copy, drop, store {
        total_withdrawn: u64,
        daily_withdrawn: u64,
        last_reset_day: u64,
    }

    struct AdminList has store {
        admins: 0x2::table::Table<address, bool>,
    }

    struct WithdrawState<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
        public_key: vector<u8>,
        user_records: 0x2::table::Table<address, UserWithdrawRecord>,
        platform_stats: PlatformStats,
        depositors: 0x2::table::Table<address, bool>,
        withdrawers: 0x2::table::Table<address, bool>,
        paused: bool,
        config: WithdrawConfig,
        user_daily_withdraws: 0x2::table::Table<address, DailyWithdrawRecord>,
        frozen_accounts: 0x2::table::Table<address, bool>,
        whitelist_enabled: bool,
        whitelisted_addresses: 0x2::table::Table<address, bool>,
        admin_list: AdminList,
        user_withdraw_limits: 0x2::table::Table<address, UserWithdrawLimit>,
        user_limit_usage: 0x2::table::Table<address, UserLimitUsage>,
        default_user_limit: UserWithdrawLimit,
    }

    struct WithdrawEvent has copy, drop {
        coin_type: vector<u8>,
        amount: u64,
        recipient: address,
        timestamp: u64,
        nonce: u64,
        user_total_withdrawn: u64,
        platform_total_withdrawals: u64,
        platform_withdrawal_count: u64,
    }

    struct WithdrawBurnEvent has copy, drop {
        coin_type: vector<u8>,
        amount: u64,
        burn_amount: u64,
        recipient: address,
        timestamp: u64,
        nonce: u64,
        user_total_withdrawn: u64,
        platform_total_withdrawals: u64,
        platform_withdrawal_count: u64,
    }

    struct DepositEvent has copy, drop {
        coin_type: vector<u8>,
        amount: u64,
        depositor: address,
        timestamp: u64,
        platform_total_deposits: u64,
        platform_deposit_count: u64,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        coin_type: vector<u8>,
        amount: u64,
        recipient: address,
        operator: address,
        reason: vector<u8>,
        timestamp: u64,
        remaining_balance: u64,
    }

    struct PauseEvent has copy, drop {
        coin_type: vector<u8>,
        paused: bool,
        operator: address,
        timestamp: u64,
    }

    struct PlatformStatsEvent has copy, drop {
        coin_type: vector<u8>,
        total_deposits: u64,
        total_withdrawals: u64,
        total_deposit_count: u64,
        total_withdrawal_count: u64,
        unique_depositors: u64,
        unique_withdrawers: u64,
        emergency_withdrawals: u64,
        emergency_withdrawal_count: u64,
        current_balance: u64,
        timestamp: u64,
    }

    struct SetUserLimitEvent has copy, drop {
        coin_type: vector<u8>,
        user: address,
        max_single_withdraw: u64,
        daily_limit: u64,
        total_limit: u64,
        operator: address,
        timestamp: u64,
    }

    struct AdminChangeEvent has copy, drop {
        coin_type: vector<u8>,
        admin: address,
        added: bool,
        operator: address,
        timestamp: u64,
    }

    struct LimitWarningEvent has copy, drop {
        coin_type: vector<u8>,
        user: address,
        warning_type: vector<u8>,
        current_usage: u64,
        limit: u64,
        timestamp: u64,
    }

    public fun add_admin<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 5);
        assert!(arg1 != @0x0, 8);
        if (0x2::table::contains<address, bool>(&arg0.admin_list.admins, arg1)) {
            assert!(!*0x2::table::borrow<address, bool>(&arg0.admin_list.admins, arg1), 20);
            *0x2::table::borrow_mut<address, bool>(&mut arg0.admin_list.admins, arg1) = true;
        } else {
            0x2::table::add<address, bool>(&mut arg0.admin_list.admins, arg1, true);
        };
        let v0 = AdminChangeEvent{
            coin_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            admin     : arg1,
            added     : true,
            operator  : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<AdminChangeEvent>(v0);
    }

    public fun add_to_whitelist<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        require_admin<T0>(arg0, arg2);
        if (0x2::table::contains<address, bool>(&arg0.whitelisted_addresses, arg1)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.whitelisted_addresses, arg1) = true;
        } else {
            0x2::table::add<address, bool>(&mut arg0.whitelisted_addresses, arg1, true);
        };
    }

    public fun batch_add_to_whitelist<T0>(arg0: &mut WithdrawState<T0>, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        require_admin<T0>(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (0x2::table::contains<address, bool>(&arg0.whitelisted_addresses, v1)) {
                *0x2::table::borrow_mut<address, bool>(&mut arg0.whitelisted_addresses, v1) = true;
            } else {
                0x2::table::add<address, bool>(&mut arg0.whitelisted_addresses, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public fun batch_freeze_accounts<T0>(arg0: &mut WithdrawState<T0>, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        require_admin<T0>(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (0x2::table::contains<address, bool>(&arg0.frozen_accounts, v1)) {
                *0x2::table::borrow_mut<address, bool>(&mut arg0.frozen_accounts, v1) = true;
            } else {
                0x2::table::add<address, bool>(&mut arg0.frozen_accounts, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public fun batch_set_user_limits<T0>(arg0: &mut WithdrawState<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        require_admin<T0>(arg0, arg7);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 22);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 22);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 22);
        assert!(v0 > 0, 8);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v4 = *0x1::vector::borrow<u64>(&arg3, v1);
            let v5 = *0x1::vector::borrow<u64>(&arg4, v1);
            let v6 = UserWithdrawLimit{
                max_single_withdraw : v3,
                daily_limit         : v4,
                total_limit         : v5,
                enabled             : arg5,
            };
            if (0x2::table::contains<address, UserWithdrawLimit>(&arg0.user_withdraw_limits, v2)) {
                *0x2::table::borrow_mut<address, UserWithdrawLimit>(&mut arg0.user_withdraw_limits, v2) = v6;
            } else {
                0x2::table::add<address, UserWithdrawLimit>(&mut arg0.user_withdraw_limits, v2, v6);
            };
            let v7 = SetUserLimitEvent{
                coin_type           : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
                user                : v2,
                max_single_withdraw : v3,
                daily_limit         : v4,
                total_limit         : v5,
                operator            : 0x2::tx_context::sender(arg7),
                timestamp           : 0x2::clock::timestamp_ms(arg6) / 1000,
            };
            0x2::event::emit<SetUserLimitEvent>(v7);
            v1 = v1 + 1;
        };
    }

    fun check_account_frozen<T0>(arg0: &WithdrawState<T0>, arg1: address) {
        if (0x2::table::contains<address, bool>(&arg0.frozen_accounts, arg1)) {
            assert!(!*0x2::table::borrow<address, bool>(&arg0.frozen_accounts, arg1), 11);
        };
    }

    fun check_cooldown<T0>(arg0: &WithdrawState<T0>, arg1: &UserWithdrawRecord, arg2: u64) {
        if (arg1.last_withdraw_time > 0) {
            assert!(arg2 - arg1.last_withdraw_time >= arg0.config.withdraw_cooldown, 10);
        };
    }

    fun check_daily_limit<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: u64, arg3: u64) {
        let v0 = arg3 / 86400;
        let v1 = if (0x2::table::contains<address, DailyWithdrawRecord>(&arg0.user_daily_withdraws, arg1)) {
            let v2 = *0x2::table::borrow<address, DailyWithdrawRecord>(&arg0.user_daily_withdraws, arg1);
            if (v2.date == v0) {
                v2
            } else {
                DailyWithdrawRecord{date: v0, amount: 0}
            }
        } else {
            DailyWithdrawRecord{date: v0, amount: 0}
        };
        let v3 = v1;
        assert!(v3.amount + arg2 <= arg0.config.daily_withdraw_limit, 9);
        v3.amount = v3.amount + arg2;
        if (0x2::table::contains<address, DailyWithdrawRecord>(&arg0.user_daily_withdraws, arg1)) {
            *0x2::table::borrow_mut<address, DailyWithdrawRecord>(&mut arg0.user_daily_withdraws, arg1) = v3;
        } else {
            0x2::table::add<address, DailyWithdrawRecord>(&mut arg0.user_daily_withdraws, arg1, v3);
        };
    }

    fun check_rate_limit<T0>(arg0: &WithdrawState<T0>, arg1: &mut UserWithdrawRecord, arg2: u64, arg3: u64) {
        if (arg2 / 3600 == arg1.hour_window_start / 3600) {
            assert!(arg1.withdraw_count_in_hour < arg3, 15);
            arg1.withdraw_count_in_hour = arg1.withdraw_count_in_hour + 1;
        } else {
            arg1.hour_window_start = arg2;
            arg1.withdraw_count_in_hour = 1;
        };
    }

    fun check_user_withdraw_limit<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = get_user_limit<T0>(arg0, arg1);
        if (!v0.enabled) {
            return
        };
        assert!(arg2 <= v0.max_single_withdraw, 16);
        let v1 = get_or_create_limit_usage<T0>(arg0, arg1, arg3);
        assert!(v1.daily_withdrawn + arg2 <= v0.daily_limit, 17);
        assert!(v1.total_withdrawn + arg2 <= v0.total_limit, 18);
        v1.daily_withdrawn = v1.daily_withdrawn + arg2;
        v1.total_withdrawn = v1.total_withdrawn + arg2;
        emit_limit_warnings<T0>(arg1, &v0, &v1, arg4);
        if (0x2::table::contains<address, UserLimitUsage>(&arg0.user_limit_usage, arg1)) {
            *0x2::table::borrow_mut<address, UserLimitUsage>(&mut arg0.user_limit_usage, arg1) = v1;
        } else {
            0x2::table::add<address, UserLimitUsage>(&mut arg0.user_limit_usage, arg1, v1);
        };
    }

    fun check_whitelist<T0>(arg0: &WithdrawState<T0>, arg1: address) {
        if (arg0.whitelist_enabled) {
            assert!(0x2::table::contains<address, bool>(&arg0.whitelisted_addresses, arg1) && *0x2::table::borrow<address, bool>(&arg0.whitelisted_addresses, arg1), 12);
        };
    }

    fun create_withdraw_message_with_burn<T0>(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: u64) : vector<u8> {
        let v0 = b"SUI_WITHDRAW:";
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        v0
    }

    public fun create_withdraw_state<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::new<address, bool>(arg2);
        0x2::table::add<address, bool>(&mut v1, v0, true);
        let v2 = PlatformStats{
            total_deposits             : 0,
            total_withdrawals          : 0,
            total_deposit_count        : 0,
            total_withdrawal_count     : 0,
            unique_depositors          : 0,
            unique_withdrawers         : 0,
            emergency_withdrawals      : 0,
            emergency_withdrawal_count : 0,
        };
        let v3 = WithdrawConfig{
            min_withdraw_amount   : 1,
            daily_withdraw_limit  : 1000000,
            withdraw_cooldown     : 60,
            hourly_withdraw_limit : 1000000,
            signature_expiration  : 300,
        };
        let v4 = AdminList{admins: v1};
        let v5 = UserWithdrawLimit{
            max_single_withdraw : 1000000,
            daily_limit         : 1000000,
            total_limit         : 0,
            enabled             : true,
        };
        let v6 = WithdrawState<T0>{
            id                    : 0x2::object::new(arg2),
            balance               : 0x2::balance::zero<T0>(),
            owner                 : v0,
            public_key            : arg1,
            user_records          : 0x2::table::new<address, UserWithdrawRecord>(arg2),
            platform_stats        : v2,
            depositors            : 0x2::table::new<address, bool>(arg2),
            withdrawers           : 0x2::table::new<address, bool>(arg2),
            paused                : false,
            config                : v3,
            user_daily_withdraws  : 0x2::table::new<address, DailyWithdrawRecord>(arg2),
            frozen_accounts       : 0x2::table::new<address, bool>(arg2),
            whitelist_enabled     : false,
            whitelisted_addresses : 0x2::table::new<address, bool>(arg2),
            admin_list            : v4,
            user_withdraw_limits  : 0x2::table::new<address, UserWithdrawLimit>(arg2),
            user_limit_usage      : 0x2::table::new<address, UserLimitUsage>(arg2),
            default_user_limit    : v5,
        };
        0x2::transfer::share_object<WithdrawState<T0>>(v6);
    }

    public fun deposit<T0>(arg0: &mut WithdrawState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        arg0.platform_stats.total_deposits = arg0.platform_stats.total_deposits + v0;
        arg0.platform_stats.total_deposit_count = arg0.platform_stats.total_deposit_count + 1;
        if (!0x2::table::contains<address, bool>(&arg0.depositors, v1)) {
            0x2::table::add<address, bool>(&mut arg0.depositors, v1, true);
            arg0.platform_stats.unique_depositors = arg0.platform_stats.unique_depositors + 1;
        };
        let v2 = DepositEvent{
            coin_type               : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount                  : v0,
            depositor               : v1,
            timestamp               : 0x2::clock::timestamp_ms(arg2) / 1000,
            platform_total_deposits : arg0.platform_stats.total_deposits,
            platform_deposit_count  : arg0.platform_stats.total_deposit_count,
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public fun emergency_withdraw<T0>(arg0: &mut WithdrawState<T0>, arg1: u64, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 5);
        assert!(arg1 > 0, 8);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg5), arg2);
        arg0.platform_stats.emergency_withdrawals = arg0.platform_stats.emergency_withdrawals + arg1;
        arg0.platform_stats.emergency_withdrawal_count = arg0.platform_stats.emergency_withdrawal_count + 1;
        let v0 = EmergencyWithdrawEvent{
            coin_type         : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount            : arg1,
            recipient         : arg2,
            operator          : 0x2::tx_context::sender(arg5),
            reason            : arg3,
            timestamp         : 0x2::clock::timestamp_ms(arg4) / 1000,
            remaining_balance : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v0);
    }

    public fun emergency_withdraw_all<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 5);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v0 > 0, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v0, arg4), arg1);
        arg0.platform_stats.emergency_withdrawals = arg0.platform_stats.emergency_withdrawals + v0;
        arg0.platform_stats.emergency_withdrawal_count = arg0.platform_stats.emergency_withdrawal_count + 1;
        let v1 = EmergencyWithdrawEvent{
            coin_type         : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount            : v0,
            recipient         : arg1,
            operator          : 0x2::tx_context::sender(arg4),
            reason            : arg2,
            timestamp         : 0x2::clock::timestamp_ms(arg3) / 1000,
            remaining_balance : 0,
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v1);
    }

    public fun emergency_withdraw_batch<T0>(arg0: &mut WithdrawState<T0>, arg1: vector<u64>, arg2: vector<address>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 5);
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 == 0x1::vector::length<address>(&arg2), 22);
        assert!(v0 > 0, 8);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg1, v1);
            let v4 = *0x1::vector::borrow<address>(&arg2, v1);
            assert!(v3 > 0, 8);
            assert!(0x2::balance::value<T0>(&arg0.balance) >= v3, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v3, arg5), v4);
            v2 = v2 + v3;
            let v5 = EmergencyWithdrawEvent{
                coin_type         : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
                amount            : v3,
                recipient         : v4,
                operator          : 0x2::tx_context::sender(arg5),
                reason            : arg3,
                timestamp         : 0x2::clock::timestamp_ms(arg4) / 1000,
                remaining_balance : 0x2::balance::value<T0>(&arg0.balance),
            };
            0x2::event::emit<EmergencyWithdrawEvent>(v5);
            v1 = v1 + 1;
        };
        arg0.platform_stats.emergency_withdrawals = arg0.platform_stats.emergency_withdrawals + v2;
        arg0.platform_stats.emergency_withdrawal_count = arg0.platform_stats.emergency_withdrawal_count + v0;
    }

    fun emit_limit_warnings<T0>(arg0: address, arg1: &UserWithdrawLimit, arg2: &UserLimitUsage, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        if (arg2.daily_withdrawn * 100 >= arg1.daily_limit * 80) {
            let v1 = LimitWarningEvent{
                coin_type     : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
                user          : arg0,
                warning_type  : b"daily_80%",
                current_usage : arg2.daily_withdrawn,
                limit         : arg1.daily_limit,
                timestamp     : v0,
            };
            0x2::event::emit<LimitWarningEvent>(v1);
        };
        if (arg1.total_limit > 0 && arg2.total_withdrawn * 100 >= arg1.total_limit * 80) {
            let v2 = LimitWarningEvent{
                coin_type     : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
                user          : arg0,
                warning_type  : b"total_80%",
                current_usage : arg2.total_withdrawn,
                limit         : arg1.total_limit,
                timestamp     : v0,
            };
            0x2::event::emit<LimitWarningEvent>(v2);
        };
    }

    public fun emit_platform_stats<T0>(arg0: &WithdrawState<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        require_admin<T0>(arg0, arg2);
        let v0 = PlatformStatsEvent{
            coin_type                  : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            total_deposits             : arg0.platform_stats.total_deposits,
            total_withdrawals          : arg0.platform_stats.total_withdrawals,
            total_deposit_count        : arg0.platform_stats.total_deposit_count,
            total_withdrawal_count     : arg0.platform_stats.total_withdrawal_count,
            unique_depositors          : arg0.platform_stats.unique_depositors,
            unique_withdrawers         : arg0.platform_stats.unique_withdrawers,
            emergency_withdrawals      : arg0.platform_stats.emergency_withdrawals,
            emergency_withdrawal_count : arg0.platform_stats.emergency_withdrawal_count,
            current_balance            : 0x2::balance::value<T0>(&arg0.balance),
            timestamp                  : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<PlatformStatsEvent>(v0);
    }

    public fun freeze_account<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        require_admin<T0>(arg0, arg2);
        if (0x2::table::contains<address, bool>(&arg0.frozen_accounts, arg1)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.frozen_accounts, arg1) = true;
        } else {
            0x2::table::add<address, bool>(&mut arg0.frozen_accounts, arg1, true);
        };
    }

    public fun get_average_deposit<T0>(arg0: &WithdrawState<T0>) : u64 {
        if (arg0.platform_stats.total_deposit_count == 0) {
            0
        } else {
            arg0.platform_stats.total_deposits / arg0.platform_stats.total_deposit_count
        }
    }

    public fun get_average_deposit_per_user<T0>(arg0: &WithdrawState<T0>) : u64 {
        if (arg0.platform_stats.unique_depositors == 0) {
            0
        } else {
            arg0.platform_stats.total_deposits / arg0.platform_stats.unique_depositors
        }
    }

    public fun get_average_withdrawal<T0>(arg0: &WithdrawState<T0>) : u64 {
        if (arg0.platform_stats.total_withdrawal_count == 0) {
            0
        } else {
            arg0.platform_stats.total_withdrawals / arg0.platform_stats.total_withdrawal_count
        }
    }

    public fun get_average_withdrawal_per_user<T0>(arg0: &WithdrawState<T0>) : u64 {
        if (arg0.platform_stats.unique_withdrawers == 0) {
            0
        } else {
            arg0.platform_stats.total_withdrawals / arg0.platform_stats.unique_withdrawers
        }
    }

    public fun get_balance<T0>(arg0: &WithdrawState<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_default_user_limit<T0>(arg0: &WithdrawState<T0>) : (u64, u64, u64, bool) {
        (arg0.default_user_limit.max_single_withdraw, arg0.default_user_limit.daily_limit, arg0.default_user_limit.total_limit, arg0.default_user_limit.enabled)
    }

    public fun get_deposit_count<T0>(arg0: &WithdrawState<T0>) : u64 {
        arg0.platform_stats.total_deposit_count
    }

    public fun get_emergency_withdrawal_count<T0>(arg0: &WithdrawState<T0>) : u64 {
        arg0.platform_stats.emergency_withdrawal_count
    }

    public fun get_emergency_withdrawal_ratio<T0>(arg0: &WithdrawState<T0>) : u64 {
        let v0 = arg0.platform_stats.total_withdrawals + arg0.platform_stats.emergency_withdrawals;
        if (v0 == 0) {
            0
        } else {
            arg0.platform_stats.emergency_withdrawals * 100 / v0
        }
    }

    public fun get_emergency_withdrawals<T0>(arg0: &WithdrawState<T0>) : u64 {
        arg0.platform_stats.emergency_withdrawals
    }

    public fun get_fund_utilization_rate<T0>(arg0: &WithdrawState<T0>) : u64 {
        if (arg0.platform_stats.total_deposits == 0) {
            0
        } else {
            (arg0.platform_stats.total_withdrawals + arg0.platform_stats.emergency_withdrawals) * 100 / arg0.platform_stats.total_deposits
        }
    }

    public fun get_net_inflow<T0>(arg0: &WithdrawState<T0>) : u64 {
        let v0 = arg0.platform_stats.total_withdrawals + arg0.platform_stats.emergency_withdrawals;
        if (arg0.platform_stats.total_deposits >= v0) {
            arg0.platform_stats.total_deposits - v0
        } else {
            0
        }
    }

    fun get_or_create_limit_usage<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: u64) : UserLimitUsage {
        let v0 = arg2 / 86400;
        if (0x2::table::contains<address, UserLimitUsage>(&arg0.user_limit_usage, arg1)) {
            let v2 = *0x2::table::borrow<address, UserLimitUsage>(&arg0.user_limit_usage, arg1);
            if (v2.last_reset_day != v0) {
                v2.daily_withdrawn = 0;
                v2.last_reset_day = v0;
            };
            v2
        } else {
            UserLimitUsage{total_withdrawn: 0, daily_withdrawn: 0, last_reset_day: v0}
        }
    }

    public fun get_owner<T0>(arg0: &WithdrawState<T0>) : address {
        arg0.owner
    }

    public fun get_platform_metrics<T0>(arg0: &WithdrawState<T0>) : (u64, u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance), arg0.platform_stats.total_deposits, arg0.platform_stats.total_withdrawals, arg0.platform_stats.emergency_withdrawals)
    }

    public fun get_platform_stats<T0>(arg0: &WithdrawState<T0>) : (u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        (arg0.platform_stats.total_deposits, arg0.platform_stats.total_withdrawals, arg0.platform_stats.total_deposit_count, arg0.platform_stats.total_withdrawal_count, arg0.platform_stats.unique_depositors, arg0.platform_stats.unique_withdrawers, arg0.platform_stats.emergency_withdrawals, arg0.platform_stats.emergency_withdrawal_count, 0x2::balance::value<T0>(&arg0.balance))
    }

    public fun get_total_deposits<T0>(arg0: &WithdrawState<T0>) : u64 {
        arg0.platform_stats.total_deposits
    }

    public fun get_total_withdrawals<T0>(arg0: &WithdrawState<T0>) : u64 {
        arg0.platform_stats.total_withdrawals
    }

    public fun get_unique_depositors<T0>(arg0: &WithdrawState<T0>) : u64 {
        arg0.platform_stats.unique_depositors
    }

    public fun get_unique_withdrawers<T0>(arg0: &WithdrawState<T0>) : u64 {
        arg0.platform_stats.unique_withdrawers
    }

    public fun get_user_activity_metrics<T0>(arg0: &WithdrawState<T0>) : (u64, u64, u64, u64) {
        (arg0.platform_stats.unique_depositors, arg0.platform_stats.unique_withdrawers, arg0.platform_stats.total_deposit_count, arg0.platform_stats.total_withdrawal_count)
    }

    public fun get_user_full_info<T0>(arg0: &WithdrawState<T0>, arg1: address, arg2: u64) : (u64, u64, u64, u64, u64, u64, bool, u64, u64, u64, u64, bool, bool, bool) {
        let (v0, v1, v2) = get_user_record<T0>(arg0, arg1);
        let (v3, v4, v5, v6) = get_user_withdraw_limit_info<T0>(arg0, arg1);
        let (v7, v8, _) = get_user_limit_usage_info<T0>(arg0, arg1);
        let (v10, v11) = get_user_remaining_limits<T0>(arg0, arg1, arg2);
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v10, v11, is_account_frozen<T0>(arg0, arg1), is_whitelisted<T0>(arg0, arg1), is_user_admin<T0>(arg0, arg1))
    }

    fun get_user_limit<T0>(arg0: &WithdrawState<T0>, arg1: address) : UserWithdrawLimit {
        if (0x2::table::contains<address, UserWithdrawLimit>(&arg0.user_withdraw_limits, arg1)) {
            *0x2::table::borrow<address, UserWithdrawLimit>(&arg0.user_withdraw_limits, arg1)
        } else {
            arg0.default_user_limit
        }
    }

    public fun get_user_limit_usage_info<T0>(arg0: &WithdrawState<T0>, arg1: address) : (u64, u64, u64) {
        if (0x2::table::contains<address, UserLimitUsage>(&arg0.user_limit_usage, arg1)) {
            let v3 = 0x2::table::borrow<address, UserLimitUsage>(&arg0.user_limit_usage, arg1);
            (v3.total_withdrawn, v3.daily_withdrawn, v3.last_reset_day)
        } else {
            (0, 0, 0)
        }
    }

    public fun get_user_nonce<T0>(arg0: &WithdrawState<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, UserWithdrawRecord>(&arg0.user_records, arg1)) {
            0x2::table::borrow<address, UserWithdrawRecord>(&arg0.user_records, arg1).nonce
        } else {
            0
        }
    }

    public fun get_user_record<T0>(arg0: &WithdrawState<T0>, arg1: address) : (u64, u64, u64) {
        if (0x2::table::contains<address, UserWithdrawRecord>(&arg0.user_records, arg1)) {
            let v3 = 0x2::table::borrow<address, UserWithdrawRecord>(&arg0.user_records, arg1);
            (v3.nonce, v3.total_withdrawn, v3.last_withdraw_time)
        } else {
            (0, 0, 0)
        }
    }

    public fun get_user_remaining_limits<T0>(arg0: &WithdrawState<T0>, arg1: address, arg2: u64) : (u64, u64) {
        let v0 = get_user_limit<T0>(arg0, arg1);
        if (!v0.enabled) {
            return (0, 0)
        };
        let (v1, v2, v3) = if (0x2::table::contains<address, UserLimitUsage>(&arg0.user_limit_usage, arg1)) {
            let v4 = 0x2::table::borrow<address, UserLimitUsage>(&arg0.user_limit_usage, arg1);
            (v4.total_withdrawn, v4.daily_withdrawn, v4.last_reset_day)
        } else {
            (0, 0, 0)
        };
        let v5 = v2;
        if (v3 != arg2 / 86400) {
            v5 = 0;
        };
        let v6 = if (v0.daily_limit > v5) {
            v0.daily_limit - v5
        } else {
            0
        };
        let v7 = if (v0.total_limit == 0) {
            0
        } else if (v0.total_limit > v1) {
            v0.total_limit - v1
        } else {
            0
        };
        (v6, v7)
    }

    public fun get_user_total_withdrawn<T0>(arg0: &WithdrawState<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, UserWithdrawRecord>(&arg0.user_records, arg1)) {
            0x2::table::borrow<address, UserWithdrawRecord>(&arg0.user_records, arg1).total_withdrawn
        } else {
            0
        }
    }

    public fun get_user_withdraw_limit_info<T0>(arg0: &WithdrawState<T0>, arg1: address) : (u64, u64, u64, bool) {
        let v0 = get_user_limit<T0>(arg0, arg1);
        (v0.max_single_withdraw, v0.daily_limit, v0.total_limit, v0.enabled)
    }

    public fun get_withdraw_config<T0>(arg0: &WithdrawState<T0>) : (u64, u64, u64, u64, u64) {
        (arg0.config.min_withdraw_amount, arg0.config.daily_withdraw_limit, arg0.config.withdraw_cooldown, arg0.config.hourly_withdraw_limit, arg0.config.signature_expiration)
    }

    public fun get_withdrawal_count<T0>(arg0: &WithdrawState<T0>) : u64 {
        arg0.platform_stats.total_withdrawal_count
    }

    public fun has_deposited<T0>(arg0: &WithdrawState<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.depositors, arg1)
    }

    public fun has_withdrawn<T0>(arg0: &WithdrawState<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.withdrawers, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_account_frozen<T0>(arg0: &WithdrawState<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.frozen_accounts, arg1) && *0x2::table::borrow<address, bool>(&arg0.frozen_accounts, arg1)
    }

    fun is_admin<T0>(arg0: &WithdrawState<T0>, arg1: address) : bool {
        arg1 == arg0.owner || 0x2::table::contains<address, bool>(&arg0.admin_list.admins, arg1) && *0x2::table::borrow<address, bool>(&arg0.admin_list.admins, arg1)
    }

    public fun is_paused<T0>(arg0: &WithdrawState<T0>) : bool {
        arg0.paused
    }

    public fun is_user_admin<T0>(arg0: &WithdrawState<T0>, arg1: address) : bool {
        is_admin<T0>(arg0, arg1)
    }

    public fun is_whitelist_enabled<T0>(arg0: &WithdrawState<T0>) : bool {
        arg0.whitelist_enabled
    }

    public fun is_whitelisted<T0>(arg0: &WithdrawState<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelisted_addresses, arg1) && *0x2::table::borrow<address, bool>(&arg0.whitelisted_addresses, arg1)
    }

    public fun pause<T0>(arg0: &mut WithdrawState<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        assert!(!arg0.paused, 6);
        arg0.paused = true;
        let v0 = PauseEvent{
            coin_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            paused    : true,
            operator  : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun remove_admin<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 5);
        assert!(arg1 != arg0.owner, 21);
        if (0x2::table::contains<address, bool>(&arg0.admin_list.admins, arg1)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.admin_list.admins, arg1) = false;
        };
        let v0 = AdminChangeEvent{
            coin_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            admin     : arg1,
            added     : false,
            operator  : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<AdminChangeEvent>(v0);
    }

    public fun remove_from_whitelist<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        require_admin<T0>(arg0, arg2);
        if (0x2::table::contains<address, bool>(&arg0.whitelisted_addresses, arg1)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.whitelisted_addresses, arg1) = false;
        };
    }

    fun require_admin<T0>(arg0: &WithdrawState<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(is_admin<T0>(arg0, 0x2::tx_context::sender(arg1)), 19);
    }

    public fun reset_user_total_withdrawn<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        require_admin<T0>(arg0, arg2);
        if (0x2::table::contains<address, UserLimitUsage>(&arg0.user_limit_usage, arg1)) {
            0x2::table::borrow_mut<address, UserLimitUsage>(&mut arg0.user_limit_usage, arg1).total_withdrawn = 0;
        };
    }

    public fun set_user_withdraw_limit<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        require_admin<T0>(arg0, arg7);
        let v0 = UserWithdrawLimit{
            max_single_withdraw : arg2,
            daily_limit         : arg3,
            total_limit         : arg4,
            enabled             : arg5,
        };
        if (0x2::table::contains<address, UserWithdrawLimit>(&arg0.user_withdraw_limits, arg1)) {
            *0x2::table::borrow_mut<address, UserWithdrawLimit>(&mut arg0.user_withdraw_limits, arg1) = v0;
        } else {
            0x2::table::add<address, UserWithdrawLimit>(&mut arg0.user_withdraw_limits, arg1, v0);
        };
        let v1 = SetUserLimitEvent{
            coin_type           : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            user                : arg1,
            max_single_withdraw : arg2,
            daily_limit         : arg3,
            total_limit         : arg4,
            operator            : 0x2::tx_context::sender(arg7),
            timestamp           : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<SetUserLimitEvent>(v1);
    }

    public fun set_whitelist_enabled<T0>(arg0: &mut WithdrawState<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        require_admin<T0>(arg0, arg2);
        arg0.whitelist_enabled = arg1;
    }

    public fun transfer_ownership<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        assert!(arg1 != @0x0, 8);
        if (!0x2::table::contains<address, bool>(&arg0.admin_list.admins, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.admin_list.admins, arg1, true);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.admin_list.admins, arg1) = true;
        };
        arg0.owner = arg1;
    }

    public fun unfreeze_account<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        require_admin<T0>(arg0, arg2);
        if (0x2::table::contains<address, bool>(&arg0.frozen_accounts, arg1)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.frozen_accounts, arg1) = false;
        };
    }

    public fun unpause<T0>(arg0: &mut WithdrawState<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        assert!(arg0.paused, 7);
        arg0.paused = false;
        let v0 = PauseEvent{
            coin_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            paused    : false,
            operator  : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun update_default_user_limit<T0>(arg0: &mut WithdrawState<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        require_admin<T0>(arg0, arg5);
        let v0 = UserWithdrawLimit{
            max_single_withdraw : arg1,
            daily_limit         : arg2,
            total_limit         : arg3,
            enabled             : arg4,
        };
        arg0.default_user_limit = v0;
    }

    public fun update_public_key<T0>(arg0: &mut WithdrawState<T0>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        arg0.public_key = arg1;
    }

    public fun update_withdraw_config<T0>(arg0: &mut WithdrawState<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        require_admin<T0>(arg0, arg6);
        let v0 = WithdrawConfig{
            min_withdraw_amount   : arg1,
            daily_withdraw_limit  : arg2,
            withdraw_cooldown     : arg3,
            hourly_withdraw_limit : arg4,
            signature_expiration  : arg5,
        };
        arg0.config = v0;
    }

    fun verify_timestamp(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 <= arg1, 2);
        assert!(arg1 - arg0 <= arg2, 3);
    }

    public fun withdraw_with_burn<T0>(arg0: &mut WithdrawState<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg6);
        check_account_frozen<T0>(arg0, v0);
        check_whitelist<T0>(arg0, v0);
        assert!(arg1 > 0, 8);
        let v1 = arg1 + arg2;
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v1, 4);
        let v2 = 0x2::clock::timestamp_ms(arg5) / 1000;
        verify_timestamp(arg4, v2, arg0.config.signature_expiration);
        let v3 = if (0x2::table::contains<address, UserWithdrawRecord>(&arg0.user_records, v0)) {
            *0x2::table::borrow<address, UserWithdrawRecord>(&arg0.user_records, v0)
        } else {
            UserWithdrawRecord{nonce: 0, total_withdrawn: 0, last_withdraw_time: 0, withdraw_count_in_hour: 0, hour_window_start: 0}
        };
        let v4 = v3;
        check_cooldown<T0>(arg0, &v4, v2);
        let v5 = &mut v4;
        check_rate_limit<T0>(arg0, v5, v2, arg0.config.hourly_withdraw_limit);
        check_user_withdraw_limit<T0>(arg0, v0, v1, v2, arg5);
        let v6 = create_withdraw_message_with_burn<T0>(arg1, v0, v4.nonce, arg4, arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.public_key, &v6), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg6), v0);
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg2, arg6), @0x0);
        };
        v4.nonce = v4.nonce + 1;
        v4.total_withdrawn = v4.total_withdrawn + v1;
        v4.last_withdraw_time = v2;
        if (0x2::table::contains<address, UserWithdrawRecord>(&arg0.user_records, v0)) {
            *0x2::table::borrow_mut<address, UserWithdrawRecord>(&mut arg0.user_records, v0) = v4;
        } else {
            0x2::table::add<address, UserWithdrawRecord>(&mut arg0.user_records, v0, v4);
        };
        arg0.platform_stats.total_withdrawals = arg0.platform_stats.total_withdrawals + v1;
        arg0.platform_stats.total_withdrawal_count = arg0.platform_stats.total_withdrawal_count + 1;
        if (!0x2::table::contains<address, bool>(&arg0.withdrawers, v0)) {
            0x2::table::add<address, bool>(&mut arg0.withdrawers, v0, true);
            arg0.platform_stats.unique_withdrawers = arg0.platform_stats.unique_withdrawers + 1;
        };
        let v7 = WithdrawBurnEvent{
            coin_type                  : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount                     : arg1,
            burn_amount                : arg2,
            recipient                  : v0,
            timestamp                  : v2,
            nonce                      : v4.nonce - 1,
            user_total_withdrawn       : v4.total_withdrawn,
            platform_total_withdrawals : arg0.platform_stats.total_withdrawals,
            platform_withdrawal_count  : arg0.platform_stats.total_withdrawal_count,
        };
        0x2::event::emit<WithdrawBurnEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

