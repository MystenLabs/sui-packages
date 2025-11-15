module 0x4d1c2bed675acbfaaf713a4c1b9f7945db47d295660b46e248dd097f4814a427::lottery_personal {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LotteryPool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        total_deposited: u64,
        user_deposits: 0x2::table::Table<address, u64>,
        whitelist: 0x2::vec_set::VecSet<address>,
        paused: bool,
        depositors: vector<address>,
        created_at: u64,
    }

    struct SuilendTracker has key {
        id: 0x2::object::UID,
        deposited_to_suilend: u64,
        total_yield_earned: u64,
        last_yield_check: u64,
        auto_deposit_threshold: u64,
    }

    struct PlayerLuck has store, key {
        id: 0x2::object::UID,
        player: address,
        regular_luck_bps: u64,
        regular_consecutive_losses: u64,
        last_regular_draw: u64,
        mega_luck_bps: u64,
        mega_consecutive_losses: u64,
        last_mega_draw: u64,
        created_at: u64,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
        deposit_time: u64,
        pool_id: address,
        purchase_draw_number: u64,
        purchase_luck_bps: u64,
        is_active: bool,
    }

    struct MegaEntry has store, key {
        id: 0x2::object::UID,
        owner: address,
        entry_type: u8,
        amount_paid: u64,
        purchase_draw_number: u64,
        purchase_mega_luck_bps: u64,
        is_used: bool,
        created_at: u64,
    }

    struct DrawConfig has key {
        id: 0x2::object::UID,
        current_draw_number: u64,
        last_daily_draw: u64,
        last_weekly_draw: u64,
        last_monthly_draw: u64,
        luck_increment_bps: u64,
        max_regular_luck_bps: u64,
        max_mega_luck_bps: u64,
    }

    struct MegaJackpotPool<phantom T0> has key {
        id: 0x2::object::UID,
        weekly_pool: 0x2::balance::Balance<T0>,
        monthly_pool: 0x2::balance::Balance<T0>,
        weekly_rollover: u64,
        monthly_rollover: u64,
    }

    struct WithdrawalRequest has store, key {
        id: 0x2::object::UID,
        user: address,
        amount: u64,
        ticket_id: address,
        created_at: u64,
        fulfilled: bool,
    }

    struct PendingWithdrawals has key {
        id: 0x2::object::UID,
        requests: 0x2::table::Table<address, WithdrawalRequest>,
    }

    struct WithdrawalRequestedEvent has copy, drop {
        request_id: address,
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct WithdrawalFulfilledEvent has copy, drop {
        request_id: address,
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
        ticket_id: address,
        luck_multiplier: u64,
        total_pool: u64,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        ticket_id: address,
        total_pool: u64,
        timestamp: u64,
    }

    struct MegaEntryPurchased has copy, drop {
        player: address,
        entry_type: u8,
        amount: u64,
        mega_luck: u64,
        timestamp: u64,
    }

    struct JackpotTiers<phantom T0> has key {
        id: 0x2::object::UID,
        hourly_pool: 0x2::balance::Balance<T0>,
        daily_pool: 0x2::balance::Balance<T0>,
        weekly_pool: 0x2::balance::Balance<T0>,
        monthly_pool: 0x2::balance::Balance<T0>,
        last_hourly_draw: u64,
        last_daily_draw: u64,
        last_weekly_draw: u64,
        last_monthly_draw: u64,
        hourly_winner: 0x1::option::Option<address>,
        daily_winner: 0x1::option::Option<address>,
        weekly_winner: 0x1::option::Option<address>,
        monthly_winner: 0x1::option::Option<address>,
    }

    struct JackpotDrawEvent has copy, drop {
        tier: vector<u8>,
        winner: address,
        amount: u64,
        timestamp: u64,
    }

    struct AutoSuilendEvent has copy, drop {
        action: vector<u8>,
        amount: u64,
        timestamp: u64,
    }

    struct DrawExecuted has copy, drop {
        draw_number: u64,
        draw_type: u8,
        winner: address,
        prize_amount: u64,
        timestamp: u64,
    }

    struct LuckUpdated has copy, drop {
        player: address,
        old_luck: u64,
        new_luck: u64,
        is_mega: bool,
        timestamp: u64,
    }

    struct WhitelistEvent has copy, drop {
        address: address,
        added: bool,
        timestamp: u64,
    }

    struct PauseEvent has copy, drop {
        paused: bool,
        timestamp: u64,
    }

    struct DrawEvent has copy, drop {
        draw_number: u64,
        draw_type: u8,
        winner: address,
        prize: u64,
    }

    public fun add_to_whitelist<T0>(arg0: &AdminCap, arg1: &mut LotteryPool<T0>, arg2: address, arg3: &0x2::clock::Clock) {
        0x2::vec_set::insert<address>(&mut arg1.whitelist, arg2);
        let v0 = WhitelistEvent{
            address   : arg2,
            added     : true,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<WhitelistEvent>(v0);
    }

    public entry fun admin_deposit_from_suilend<T0>(arg0: &AdminCap, arg1: &mut LotteryPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
        let v0 = DepositEvent{
            user            : @0x0,
            amount          : 0x2::coin::value<T0>(&arg2),
            ticket_id       : @0x0,
            luck_multiplier : 0,
            total_pool      : 0x2::balance::value<T0>(&arg1.balance),
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public entry fun admin_fulfill_withdrawal<T0>(arg0: &AdminCap, arg1: &mut LotteryPool<T0>, arg2: WithdrawalRequest, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.fulfilled, 10);
        let WithdrawalRequest {
            id         : v0,
            user       : v1,
            amount     : v2,
            ticket_id  : _,
            created_at : _,
            fulfilled  : _,
        } = arg2;
        let v6 = v0;
        assert!(0x2::coin::value<T0>(&arg3) >= v2, 5);
        arg1.total_deposited = arg1.total_deposited - v2;
        if (0x2::table::contains<address, u64>(&arg1.user_deposits, v1)) {
            let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg1.user_deposits, v1);
            *v7 = *v7 - v2;
            if (*v7 == 0) {
                0x2::table::remove<address, u64>(&mut arg1.user_deposits, v1);
            };
        };
        0x2::object::delete(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
        let v8 = WithdrawalFulfilledEvent{
            request_id : 0x2::object::uid_to_address(&v6),
            user       : v1,
            amount     : v2,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<WithdrawalFulfilledEvent>(v8);
    }

    public entry fun admin_record_suilend_deposit<T0>(arg0: &AdminCap, arg1: &mut SuilendTracker, arg2: u64, arg3: &0x2::clock::Clock) {
        arg1.deposited_to_suilend = arg1.deposited_to_suilend + arg2;
        arg1.last_yield_check = 0x2::clock::timestamp_ms(arg3);
    }

    public entry fun admin_record_suilend_withdrawal<T0>(arg0: &AdminCap, arg1: &mut SuilendTracker, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        arg1.deposited_to_suilend = arg1.deposited_to_suilend - arg2;
        arg1.total_yield_earned = arg1.total_yield_earned + arg3;
        arg1.last_yield_check = 0x2::clock::timestamp_ms(arg4);
    }

    public entry fun admin_withdraw_for_suilend<T0>(arg0: &AdminCap, arg1: &mut LotteryPool<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 5);
        let v0 = WithdrawEvent{
            user       : 0x2::tx_context::sender(arg4),
            amount     : arg2,
            ticket_id  : @0x0,
            total_pool : 0x2::balance::value<T0>(&arg1.balance),
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg2, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun buy_mega_entry<T0>(arg0: &mut MegaJackpotPool<T0>, arg1: &DrawConfig, arg2: 0x2::coin::Coin<T0>, arg3: &PlayerLuck, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg4 == 1 || arg4 == 2, 8);
        assert!(arg3.player == v0, 4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = if (arg4 == 1) {
            500000
        } else {
            1000000
        };
        assert!(v1 >= v2, 9);
        let v3 = 0x2::coin::into_balance<T0>(arg2);
        if (arg4 == 1) {
            0x2::balance::join<T0>(&mut arg0.weekly_pool, 0x2::balance::split<T0>(&mut v3, 0x2::balance::value<T0>(&v3) * 80 / 100));
        } else {
            0x2::balance::join<T0>(&mut arg0.monthly_pool, 0x2::balance::split<T0>(&mut v3, 0x2::balance::value<T0>(&v3) * 80 / 100));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg6), v0);
        let v4 = MegaEntry{
            id                     : 0x2::object::new(arg6),
            owner                  : v0,
            entry_type             : arg4,
            amount_paid            : v1,
            purchase_draw_number   : arg1.current_draw_number,
            purchase_mega_luck_bps : arg3.mega_luck_bps,
            is_used                : false,
            created_at             : 0x2::clock::timestamp_ms(arg5),
        };
        let v5 = MegaEntryPurchased{
            player     : v0,
            entry_type : arg4,
            amount     : v1,
            mega_luck  : arg3.mega_luck_bps,
            timestamp  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<MegaEntryPurchased>(v5);
        0x2::transfer::transfer<MegaEntry>(v4, v0);
    }

    public fun calculate_weighted_entries(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 == arg3) {
            arg1
        } else {
            let v1 = if (arg1 > arg0) {
                arg1 - arg0
            } else {
                0
            };
            arg0 + v1 / 2
        }
    }

    public entry fun check_and_deposit_to_suilend<T0>(arg0: &AdminCap, arg1: &mut LotteryPool<T0>, arg2: &mut SuilendTracker, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        if (v0 > arg2.auto_deposit_threshold) {
            let v1 = v0 - arg2.auto_deposit_threshold;
            arg2.deposited_to_suilend = arg2.deposited_to_suilend + v1;
            let v2 = AutoSuilendEvent{
                action    : b"deposit",
                amount    : v1,
                timestamp : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<AutoSuilendEvent>(v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, v1, arg4), 0x2::tx_context::sender(arg4));
        };
    }

    public fun check_draws_ready<T0>(arg0: &JackpotTiers<T0>, arg1: &0x2::clock::Clock) : (bool, bool, bool, bool) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        (v0 >= arg0.last_hourly_draw + 3600000, v0 >= arg0.last_daily_draw + 86400000, v0 >= arg0.last_weekly_draw + 604800000, v0 >= arg0.last_monthly_draw + 2592000000)
    }

    public entry fun create_my_luck(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = PlayerLuck{
            id                         : 0x2::object::new(arg1),
            player                     : v0,
            regular_luck_bps           : 10000,
            regular_consecutive_losses : 0,
            last_regular_draw          : 0,
            mega_luck_bps              : 10000,
            mega_consecutive_losses    : 0,
            last_mega_draw             : 0,
            created_at                 : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::transfer::transfer<PlayerLuck>(v1, v0);
    }

    public entry fun create_pool<T0>(arg0: &AdminCap, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, arg1);
        0x2::vec_set::insert<address>(&mut v0, arg2);
        let v1 = LotteryPool<T0>{
            id              : 0x2::object::new(arg4),
            balance         : 0x2::balance::zero<T0>(),
            total_deposited : 0,
            user_deposits   : 0x2::table::new<address, u64>(arg4),
            whitelist       : v0,
            paused          : false,
            depositors      : 0x1::vector::empty<address>(),
            created_at      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::transfer::share_object<LotteryPool<T0>>(v1);
    }

    public entry fun deposit<T0>(arg0: &mut LotteryPool<T0>, arg1: &DrawConfig, arg2: 0x2::coin::Coin<T0>, arg3: &PlayerLuck, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!arg0.paused, 2);
        assert!(0x2::vec_set::contains<address>(&arg0.whitelist, &v0), 0);
        assert!(arg3.player == v0, 4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= 0, 11);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.user_deposits, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.user_deposits, v0)
        } else {
            0
        };
        let v3 = v2 + v1;
        assert!(v3 <= 100000000, 3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_deposited = arg0.total_deposited + v1;
        if (0x2::table::contains<address, u64>(&arg0.user_deposits, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.user_deposits, v0) = v3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_deposits, v0, v1);
            if (!0x1::vector::contains<address>(&arg0.depositors, &v0)) {
                0x1::vector::push_back<address>(&mut arg0.depositors, v0);
            };
        };
        let v4 = 0x2::object::new(arg5);
        let v5 = Ticket{
            id                   : v4,
            owner                : v0,
            amount               : v1,
            deposit_time         : 0x2::clock::timestamp_ms(arg4),
            pool_id              : 0x2::object::uid_to_address(&arg0.id),
            purchase_draw_number : arg1.current_draw_number,
            purchase_luck_bps    : arg3.regular_luck_bps,
            is_active            : true,
        };
        let v6 = DepositEvent{
            user            : v0,
            amount          : v1,
            ticket_id       : 0x2::object::uid_to_address(&v4),
            luck_multiplier : arg3.regular_luck_bps,
            total_pool      : arg0.total_deposited,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DepositEvent>(v6);
        0x2::transfer::transfer<Ticket>(v5, v0);
    }

    public entry fun deposit_smart<T0>(arg0: &mut LotteryPool<T0>, arg1: &DrawConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!arg0.paused, 2);
        assert!(0x2::vec_set::contains<address>(&arg0.whitelist, &v0), 0);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 11);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.user_deposits, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.user_deposits, v0)
        } else {
            0
        };
        let v3 = v2 + v1;
        assert!(v3 <= 100000000, 3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_deposited = arg0.total_deposited + v1;
        if (0x2::table::contains<address, u64>(&arg0.user_deposits, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.user_deposits, v0) = v3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_deposits, v0, v1);
            if (!0x1::vector::contains<address>(&arg0.depositors, &v0)) {
                0x1::vector::push_back<address>(&mut arg0.depositors, v0);
            };
        };
        let v4 = 0x2::object::new(arg4);
        let v5 = Ticket{
            id                   : v4,
            owner                : v0,
            amount               : v1,
            deposit_time         : 0x2::clock::timestamp_ms(arg3),
            pool_id              : 0x2::object::uid_to_address(&arg0.id),
            purchase_draw_number : arg1.current_draw_number,
            purchase_luck_bps    : 10000,
            is_active            : true,
        };
        let v6 = DepositEvent{
            user            : v0,
            amount          : v1,
            ticket_id       : 0x2::object::uid_to_address(&v4),
            luck_multiplier : 10000,
            total_pool      : arg0.total_deposited,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DepositEvent>(v6);
        0x2::transfer::transfer<Ticket>(v5, v0);
    }

    public entry fun execute_daily_draw<T0>(arg0: &LotteryPool<T0>, arg1: &mut JackpotTiers<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.last_daily_draw + 86400000, 4);
        let v1 = &arg0.depositors;
        assert!(0x1::vector::length<address>(v1) > 0, 5);
        let v2 = 0x2::random::new_generator(arg3, arg4);
        let v3 = *0x1::vector::borrow<address>(v1, 0x2::random::generate_u64_in_range(&mut v2, 0, 0x1::vector::length<address>(v1) - 1));
        let v4 = 0x2::balance::value<T0>(&arg1.daily_pool);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.daily_pool), arg4), v3);
            arg1.daily_winner = 0x1::option::some<address>(v3);
            arg1.last_daily_draw = v0;
            let v5 = JackpotDrawEvent{
                tier      : b"daily",
                winner    : v3,
                amount    : v4,
                timestamp : v0,
            };
            0x2::event::emit<JackpotDrawEvent>(v5);
        };
    }

    public entry fun execute_hourly_draw<T0>(arg0: &LotteryPool<T0>, arg1: &mut JackpotTiers<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.last_hourly_draw + 3600000, 4);
        let v1 = &arg0.depositors;
        assert!(0x1::vector::length<address>(v1) > 0, 5);
        let v2 = 0x2::random::new_generator(arg3, arg4);
        let v3 = *0x1::vector::borrow<address>(v1, 0x2::random::generate_u64_in_range(&mut v2, 0, 0x1::vector::length<address>(v1) - 1));
        let v4 = 0x2::balance::value<T0>(&arg1.hourly_pool);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.hourly_pool), arg4), v3);
            arg1.hourly_winner = 0x1::option::some<address>(v3);
            arg1.last_hourly_draw = v0;
            let v5 = JackpotDrawEvent{
                tier      : b"hourly",
                winner    : v3,
                amount    : v4,
                timestamp : v0,
            };
            0x2::event::emit<JackpotDrawEvent>(v5);
        };
    }

    public entry fun execute_monthly_draw<T0>(arg0: &LotteryPool<T0>, arg1: &mut JackpotTiers<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.last_monthly_draw + 2592000000, 4);
        let v0 = &arg0.depositors;
        assert!(0x1::vector::length<address>(v0) > 0, 5);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        0x2::random::generate_u64_in_range(&mut v1, 0, 0x1::vector::length<address>(v0) - 1);
    }

    public entry fun execute_weekly_draw<T0>(arg0: &LotteryPool<T0>, arg1: &mut JackpotTiers<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.last_weekly_draw + 604800000, 4);
        let v1 = &arg0.depositors;
        assert!(0x1::vector::length<address>(v1) > 0, 5);
        let v2 = 0x2::random::new_generator(arg3, arg4);
        let v3 = *0x1::vector::borrow<address>(v1, 0x2::random::generate_u64_in_range(&mut v2, 0, 0x1::vector::length<address>(v1) - 1));
        let v4 = 0x2::balance::value<T0>(&arg1.weekly_pool);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.weekly_pool), arg4), v3);
            arg1.weekly_winner = 0x1::option::some<address>(v3);
            arg1.last_weekly_draw = v0;
            let v5 = JackpotDrawEvent{
                tier      : b"weekly",
                winner    : v3,
                amount    : v4,
                timestamp : v0,
            };
            0x2::event::emit<JackpotDrawEvent>(v5);
        };
    }

    public fun get_jackpot_balances<T0>(arg0: &JackpotTiers<T0>) : (u64, u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.hourly_pool), 0x2::balance::value<T0>(&arg0.daily_pool), 0x2::balance::value<T0>(&arg0.weekly_pool), 0x2::balance::value<T0>(&arg0.monthly_pool))
    }

    public fun get_last_winners<T0>(arg0: &JackpotTiers<T0>) : (0x1::option::Option<address>, 0x1::option::Option<address>, 0x1::option::Option<address>, 0x1::option::Option<address>) {
        (arg0.hourly_winner, arg0.daily_winner, arg0.weekly_winner, arg0.monthly_winner)
    }

    public fun get_luck_info(arg0: &PlayerLuck) : (u64, u64, u64, u64) {
        (arg0.regular_luck_bps, arg0.regular_consecutive_losses, arg0.mega_luck_bps, arg0.mega_consecutive_losses)
    }

    public fun get_next_draw_times<T0>(arg0: &JackpotTiers<T0>) : (u64, u64, u64, u64) {
        (arg0.last_hourly_draw + 3600000, arg0.last_daily_draw + 86400000, arg0.last_weekly_draw + 604800000, arg0.last_monthly_draw + 2592000000)
    }

    public fun get_pool_balance<T0>(arg0: &LotteryPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_pool_stats<T0>(arg0: &LotteryPool<T0>) : (u64, u64, u64, bool) {
        (0x2::balance::value<T0>(&arg0.balance), arg0.total_deposited, 0x1::vector::length<address>(&arg0.depositors), arg0.paused)
    }

    public fun get_suilend_stats(arg0: &SuilendTracker) : (u64, u64, u64) {
        (arg0.deposited_to_suilend, arg0.total_yield_earned, arg0.auto_deposit_threshold)
    }

    public fun get_user_deposit<T0>(arg0: &LotteryPool<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_deposits, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_deposits, arg1)
        } else {
            0
        }
    }

    public fun get_user_entries<T0>(arg0: &LotteryPool<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_deposits, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_deposits, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_jackpot_tiers<T0>(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = JackpotTiers<T0>{
            id                : 0x2::object::new(arg2),
            hourly_pool       : 0x2::balance::zero<T0>(),
            daily_pool        : 0x2::balance::zero<T0>(),
            weekly_pool       : 0x2::balance::zero<T0>(),
            monthly_pool      : 0x2::balance::zero<T0>(),
            last_hourly_draw  : v0,
            last_daily_draw   : v0,
            last_weekly_draw  : v0,
            last_monthly_draw : v0,
            hourly_winner     : 0x1::option::none<address>(),
            daily_winner      : 0x1::option::none<address>(),
            weekly_winner     : 0x1::option::none<address>(),
            monthly_winner    : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<JackpotTiers<T0>>(v1);
    }

    public entry fun initialize_luck_system(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DrawConfig{
            id                   : 0x2::object::new(arg1),
            current_draw_number  : 0,
            last_daily_draw      : 0,
            last_weekly_draw     : 0,
            last_monthly_draw    : 0,
            luck_increment_bps   : 1000,
            max_regular_luck_bps : 50000,
            max_mega_luck_bps    : 100000,
        };
        0x2::transfer::share_object<DrawConfig>(v0);
    }

    public entry fun initialize_mega_pool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MegaJackpotPool<T0>{
            id               : 0x2::object::new(arg1),
            weekly_pool      : 0x2::balance::zero<T0>(),
            monthly_pool     : 0x2::balance::zero<T0>(),
            weekly_rollover  : 0,
            monthly_rollover : 0,
        };
        0x2::transfer::share_object<MegaJackpotPool<T0>>(v0);
    }

    public entry fun initialize_suilend_tracker(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendTracker{
            id                     : 0x2::object::new(arg2),
            deposited_to_suilend   : 0,
            total_yield_earned     : 0,
            last_yield_check       : 0x2::clock::timestamp_ms(arg1),
            auto_deposit_threshold : 10000,
        };
        0x2::transfer::share_object<SuilendTracker>(v0);
    }

    public fun is_whitelisted<T0>(arg0: &LotteryPool<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelist, &arg1)
    }

    public entry fun pause<T0>(arg0: &AdminCap, arg1: &mut LotteryPool<T0>, arg2: &0x2::clock::Clock) {
        arg1.paused = true;
        let v0 = PauseEvent{
            paused    : true,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public entry fun record_suilend_yield<T0>(arg0: &AdminCap, arg1: &mut SuilendTracker, arg2: &mut JackpotTiers<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        arg1.total_yield_earned = arg1.total_yield_earned + v0;
        arg1.last_yield_check = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::coin::into_balance<T0>(arg3);
        0x2::balance::join<T0>(&mut arg2.hourly_pool, 0x2::balance::split<T0>(&mut v1, v0 * 100 / 10000));
        0x2::balance::join<T0>(&mut arg2.daily_pool, 0x2::balance::split<T0>(&mut v1, v0 * 500 / 10000));
        0x2::balance::join<T0>(&mut arg2.weekly_pool, 0x2::balance::split<T0>(&mut v1, v0 * 1500 / 10000));
        0x2::balance::join<T0>(&mut arg2.monthly_pool, 0x2::balance::split<T0>(&mut v1, v0 * 3000 / 10000));
        0x2::balance::join<T0>(&mut arg2.monthly_pool, v1);
    }

    public entry fun request_withdrawal<T0>(arg0: &mut LotteryPool<T0>, arg1: Ticket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            id                   : v0,
            owner                : v1,
            amount               : v2,
            deposit_time         : _,
            pool_id              : v4,
            purchase_draw_number : _,
            purchase_luck_bps    : _,
            is_active            : _,
        } = arg1;
        let v8 = v0;
        assert!(v1 == 0x2::tx_context::sender(arg3), 4);
        assert!(v4 == 0x2::object::uid_to_address(&arg0.id), 6);
        assert!(0x2::table::contains<address, u64>(&arg0.user_deposits, v1), 4);
        assert!(*0x2::table::borrow<address, u64>(&arg0.user_deposits, v1) >= v2, 5);
        let v9 = 0x2::object::new(arg3);
        0x2::object::delete(v8);
        let v10 = WithdrawalRequest{
            id         : v9,
            user       : v1,
            amount     : v2,
            ticket_id  : 0x2::object::uid_to_address(&v8),
            created_at : 0x2::clock::timestamp_ms(arg2),
            fulfilled  : false,
        };
        0x2::transfer::share_object<WithdrawalRequest>(v10);
        let v11 = WithdrawalRequestedEvent{
            request_id : 0x2::object::uid_to_address(&v9),
            user       : v1,
            amount     : v2,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawalRequestedEvent>(v11);
    }

    fun select_random_depositor<T0>(arg0: &LotteryPool<T0>, arg1: &mut 0x2::random::RandomGenerator) : address {
        let v0 = 0x1::vector::length<address>(&arg0.depositors);
        if (v0 == 0) {
            abort 11
        };
        *0x1::vector::borrow<address>(&arg0.depositors, 0x2::random::generate_u64_in_range(arg1, 0, v0 - 1))
    }

    public entry fun unpause<T0>(arg0: &AdminCap, arg1: &mut LotteryPool<T0>, arg2: &0x2::clock::Clock) {
        arg1.paused = false;
        let v0 = PauseEvent{
            paused    : false,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun update_luck_after_draw(arg0: &mut PlayerLuck, arg1: bool, arg2: bool, arg3: &DrawConfig, arg4: &0x2::clock::Clock) {
        let v0 = if (arg2) {
            arg0.mega_luck_bps
        } else {
            arg0.regular_luck_bps
        };
        if (arg2) {
            if (arg1) {
                arg0.mega_luck_bps = 10000;
                arg0.mega_consecutive_losses = 0;
            } else {
                arg0.mega_consecutive_losses = arg0.mega_consecutive_losses + 1;
                let v1 = arg0.mega_luck_bps + arg3.luck_increment_bps;
                let v2 = if (v1 > arg3.max_mega_luck_bps) {
                    arg3.max_mega_luck_bps
                } else {
                    v1
                };
                arg0.mega_luck_bps = v2;
            };
            arg0.last_mega_draw = arg3.current_draw_number;
        } else {
            if (arg1) {
                arg0.regular_luck_bps = 10000;
                arg0.regular_consecutive_losses = 0;
            } else {
                arg0.regular_consecutive_losses = arg0.regular_consecutive_losses + 1;
                let v3 = arg0.regular_luck_bps + arg3.luck_increment_bps;
                let v4 = if (v3 > arg3.max_regular_luck_bps) {
                    arg3.max_regular_luck_bps
                } else {
                    v3
                };
                arg0.regular_luck_bps = v4;
            };
            arg0.last_regular_draw = arg3.current_draw_number;
        };
        let v5 = if (arg2) {
            arg0.mega_luck_bps
        } else {
            arg0.regular_luck_bps
        };
        let v6 = LuckUpdated{
            player    : arg0.player,
            old_luck  : v0,
            new_luck  : v5,
            is_mega   : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LuckUpdated>(v6);
    }

    public entry fun withdraw<T0>(arg0: &mut LotteryPool<T0>, arg1: Ticket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            id                   : v0,
            owner                : v1,
            amount               : v2,
            deposit_time         : _,
            pool_id              : v4,
            purchase_draw_number : _,
            purchase_luck_bps    : _,
            is_active            : _,
        } = arg1;
        let v8 = v0;
        let v9 = 0x2::tx_context::sender(arg3);
        assert!(v1 == v9, 4);
        assert!(v4 == 0x2::object::uid_to_address(&arg0.id), 6);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v2, 5);
        arg0.total_deposited = arg0.total_deposited - v2;
        if (0x2::table::contains<address, u64>(&arg0.user_deposits, v1)) {
            let v10 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_deposits, v1);
            *v10 = *v10 - v2;
            if (*v10 == 0) {
                0x2::table::remove<address, u64>(&mut arg0.user_deposits, v1);
            };
        };
        let v11 = WithdrawEvent{
            user       : v1,
            amount     : v2,
            ticket_id  : 0x2::object::uid_to_address(&v8),
            total_pool : arg0.total_deposited,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawEvent>(v11);
        0x2::object::delete(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg3), v9);
    }

    public entry fun withdraw_smart<T0>(arg0: &mut LotteryPool<T0>, arg1: &mut SuilendTracker, arg2: Ticket, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            id                   : v0,
            owner                : v1,
            amount               : v2,
            deposit_time         : _,
            pool_id              : v4,
            purchase_draw_number : _,
            purchase_luck_bps    : _,
            is_active            : _,
        } = arg2;
        let v8 = v0;
        let v9 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v9, 4);
        assert!(v4 == 0x2::object::uid_to_address(&arg0.id), 6);
        let v10 = 0x2::balance::value<T0>(&arg0.balance);
        if (v10 >= v2) {
            arg0.total_deposited = arg0.total_deposited - v2;
            if (0x2::table::contains<address, u64>(&arg0.user_deposits, v1)) {
                let v11 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_deposits, v1);
                *v11 = *v11 - v2;
                if (*v11 == 0) {
                    0x2::table::remove<address, u64>(&mut arg0.user_deposits, v1);
                };
            };
            let v12 = WithdrawEvent{
                user       : v1,
                amount     : v2,
                ticket_id  : 0x2::object::uid_to_address(&v8),
                total_pool : arg0.total_deposited,
                timestamp  : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<WithdrawEvent>(v12);
            0x2::object::delete(v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg4), v9);
        } else {
            0x2::object::delete(v8);
            assert!(v10 >= v2, 5);
        };
    }

    // decompiled from Move bytecode v6
}

