module 0xc5678980afa7c8e70714404457ac028d49fb06fd13e957546044fa9c327c3155::signature_withdraw {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct UserWithdrawRecord has copy, drop, store {
        nonce: u64,
        total_withdrawn: u64,
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

    struct WithdrawBrunEvent has copy, drop {
        coin_type: vector<u8>,
        amount: u64,
        brun_amount: u64,
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

    fun create_withdraw_message<T0>(arg0: u64, arg1: address, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = b"SUI_WITHDRAW:";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        v0
    }

    fun create_withdraw_messageV1<T0>(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: u64) : vector<u8> {
        let v0 = b"SUI_WITHDRAW:";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        v0
    }

    public fun create_withdraw_state<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformStats{
            total_deposits             : 0,
            total_withdrawals          : 0,
            total_deposit_count        : 0,
            total_withdrawal_count     : 0,
            unique_depositors          : 0,
            unique_withdrawers         : 0,
            emergency_withdrawals      : 0,
            emergency_withdrawal_count : 0,
        };
        let v1 = WithdrawState<T0>{
            id             : 0x2::object::new(arg2),
            balance        : 0x2::balance::zero<T0>(),
            owner          : 0x2::tx_context::sender(arg2),
            public_key     : arg1,
            user_records   : 0x2::table::new<address, UserWithdrawRecord>(arg2),
            platform_stats : v0,
            depositors     : 0x2::table::new<address, bool>(arg2),
            withdrawers    : 0x2::table::new<address, bool>(arg2),
            paused         : false,
        };
        0x2::transfer::share_object<WithdrawState<T0>>(v1);
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
        assert!(v0 == 0x1::vector::length<address>(&arg2), 8);
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

    public fun emit_platform_stats<T0>(arg0: &WithdrawState<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
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

    public fun get_user_nonce<T0>(arg0: &WithdrawState<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, UserWithdrawRecord>(&arg0.user_records, arg1)) {
            0x2::table::borrow<address, UserWithdrawRecord>(&arg0.user_records, arg1).nonce
        } else {
            0
        }
    }

    public fun get_user_record<T0>(arg0: &WithdrawState<T0>, arg1: address) : (u64, u64) {
        if (0x2::table::contains<address, UserWithdrawRecord>(&arg0.user_records, arg1)) {
            let v2 = 0x2::table::borrow<address, UserWithdrawRecord>(&arg0.user_records, arg1);
            (v2.nonce, v2.total_withdrawn)
        } else {
            (0, 0)
        }
    }

    public fun get_user_total_withdrawn<T0>(arg0: &WithdrawState<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, UserWithdrawRecord>(&arg0.user_records, arg1)) {
            0x2::table::borrow<address, UserWithdrawRecord>(&arg0.user_records, arg1).total_withdrawn
        } else {
            0
        }
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

    public fun is_paused<T0>(arg0: &WithdrawState<T0>) : bool {
        arg0.paused
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

    public fun transfer_ownership<T0>(arg0: &mut WithdrawState<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        arg0.owner = arg1;
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

    public fun update_public_key<T0>(arg0: &mut WithdrawState<T0>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        arg0.public_key = arg1;
    }

    public fun withdraw<T0>(arg0: &mut WithdrawState<T0>, arg1: u64, arg2: address, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg5) / 1000, 2);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 4);
        assert!(arg1 > 0, 8);
        let v0 = if (0x2::table::contains<address, UserWithdrawRecord>(&arg0.user_records, arg2)) {
            *0x2::table::borrow<address, UserWithdrawRecord>(&arg0.user_records, arg2)
        } else {
            UserWithdrawRecord{nonce: 0, total_withdrawn: 0}
        };
        let v1 = v0;
        let v2 = create_withdraw_message<T0>(arg1, arg2, v1.nonce, arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.public_key, &v2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg6), arg2);
        v1.nonce = v1.nonce + 1;
        v1.total_withdrawn = v1.total_withdrawn + arg1;
        if (0x2::table::contains<address, UserWithdrawRecord>(&arg0.user_records, arg2)) {
            *0x2::table::borrow_mut<address, UserWithdrawRecord>(&mut arg0.user_records, arg2) = v1;
        } else {
            0x2::table::add<address, UserWithdrawRecord>(&mut arg0.user_records, arg2, v1);
        };
        arg0.platform_stats.total_withdrawals = arg0.platform_stats.total_withdrawals + arg1;
        arg0.platform_stats.total_withdrawal_count = arg0.platform_stats.total_withdrawal_count + 1;
        let v3 = WithdrawEvent{
            coin_type                  : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount                     : arg1,
            recipient                  : arg2,
            timestamp                  : 0x2::clock::timestamp_ms(arg5),
            nonce                      : v1.nonce - 1,
            user_total_withdrawn       : v1.total_withdrawn,
            platform_total_withdrawals : arg0.platform_stats.total_withdrawals,
            platform_withdrawal_count  : arg0.platform_stats.total_withdrawal_count,
        };
        0x2::event::emit<WithdrawEvent>(v3);
    }

    public fun withdrawV1<T0>(arg0: &mut WithdrawState<T0>, arg1: u64, arg2: u64, arg3: address, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(arg5 > 0x2::clock::timestamp_ms(arg6) / 1000, 2);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 4);
        assert!(arg1 > 0, 8);
        let v0 = if (0x2::table::contains<address, UserWithdrawRecord>(&arg0.user_records, arg3)) {
            *0x2::table::borrow<address, UserWithdrawRecord>(&arg0.user_records, arg3)
        } else {
            UserWithdrawRecord{nonce: 0, total_withdrawn: 0}
        };
        let v1 = v0;
        let v2 = create_withdraw_messageV1<T0>(arg1, arg3, v1.nonce, arg5, arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.public_key, &v2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg7), arg3);
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg2, arg7), @0x0);
        };
        v1.nonce = v1.nonce + 1;
        v1.total_withdrawn = v1.total_withdrawn + arg1;
        if (0x2::table::contains<address, UserWithdrawRecord>(&arg0.user_records, arg3)) {
            *0x2::table::borrow_mut<address, UserWithdrawRecord>(&mut arg0.user_records, arg3) = v1;
        } else {
            0x2::table::add<address, UserWithdrawRecord>(&mut arg0.user_records, arg3, v1);
        };
        arg0.platform_stats.total_withdrawals = arg0.platform_stats.total_withdrawals + arg1;
        arg0.platform_stats.total_withdrawal_count = arg0.platform_stats.total_withdrawal_count + 1;
        let v3 = WithdrawBrunEvent{
            coin_type                  : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount                     : arg1,
            brun_amount                : arg2,
            recipient                  : arg3,
            timestamp                  : 0x2::clock::timestamp_ms(arg6),
            nonce                      : v1.nonce - 1,
            user_total_withdrawn       : v1.total_withdrawn,
            platform_total_withdrawals : arg0.platform_stats.total_withdrawals,
            platform_withdrawal_count  : arg0.platform_stats.total_withdrawal_count,
        };
        0x2::event::emit<WithdrawBrunEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

