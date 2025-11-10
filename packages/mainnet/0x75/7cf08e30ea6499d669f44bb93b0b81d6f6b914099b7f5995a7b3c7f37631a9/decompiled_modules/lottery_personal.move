module 0x757cf08e30ea6499d669f44bb93b0b81d6f6b914099b7f5995a7b3c7f37631a9::lottery_personal {
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

    public entry fun execute_daily_draw<T0>(arg0: &mut LotteryPool<T0>, arg1: &mut DrawConfig, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 - arg1.last_daily_draw >= 86400000, 11);
        let v1 = 0x2::balance::value<T0>(&arg0.balance) / 20;
        let v2 = 0x2::random::new_generator(arg2, arg4);
        let v3 = &mut v2;
        let v4 = select_random_depositor<T0>(arg0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg4), v4);
        arg1.last_daily_draw = v0;
        arg1.current_draw_number = arg1.current_draw_number + 1;
        let v5 = DrawEvent{
            draw_number : arg1.current_draw_number,
            draw_type   : 1,
            winner      : v4,
            prize       : v1,
        };
        0x2::event::emit<DrawEvent>(v5);
    }

    public entry fun execute_monthly_draw<T0>(arg0: &mut LotteryPool<T0>, arg1: &mut DrawConfig, arg2: &mut MegaJackpotPool<T0>, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 - arg1.last_monthly_draw >= 2592000000, 11);
        let v1 = 0x2::balance::value<T0>(&arg0.balance) * 15 / 100;
        let v2 = 0x2::random::new_generator(arg3, arg5);
        let v3 = &mut v2;
        let v4 = select_random_depositor<T0>(arg0, v3);
        let v5 = 0x2::balance::split<T0>(&mut arg0.balance, v1);
        0x2::balance::join<T0>(&mut v5, 0x2::balance::withdraw_all<T0>(&mut arg2.monthly_pool));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg5), v4);
        arg1.last_monthly_draw = v0;
        arg1.current_draw_number = arg1.current_draw_number + 1;
        let v6 = DrawEvent{
            draw_number : arg1.current_draw_number,
            draw_type   : 3,
            winner      : v4,
            prize       : v1 + 0x2::balance::value<T0>(&arg2.monthly_pool),
        };
        0x2::event::emit<DrawEvent>(v6);
    }

    public entry fun execute_weekly_draw<T0>(arg0: &mut LotteryPool<T0>, arg1: &mut DrawConfig, arg2: &mut MegaJackpotPool<T0>, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 - arg1.last_weekly_draw >= 604800000, 11);
        let v1 = 0x2::balance::value<T0>(&arg0.balance) / 10;
        let v2 = 0x2::random::new_generator(arg3, arg5);
        let v3 = &mut v2;
        let v4 = select_random_depositor<T0>(arg0, v3);
        let v5 = 0x2::balance::split<T0>(&mut arg0.balance, v1);
        0x2::balance::join<T0>(&mut v5, 0x2::balance::withdraw_all<T0>(&mut arg2.weekly_pool));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg5), v4);
        arg1.last_weekly_draw = v0;
        arg1.current_draw_number = arg1.current_draw_number + 1;
        let v6 = DrawEvent{
            draw_number : arg1.current_draw_number,
            draw_type   : 2,
            winner      : v4,
            prize       : v1 + 0x2::balance::value<T0>(&arg2.weekly_pool),
        };
        0x2::event::emit<DrawEvent>(v6);
    }

    public fun get_luck_info(arg0: &PlayerLuck) : (u64, u64, u64, u64) {
        (arg0.regular_luck_bps, arg0.regular_consecutive_losses, arg0.mega_luck_bps, arg0.mega_consecutive_losses)
    }

    public fun get_pool_balance<T0>(arg0: &LotteryPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_user_deposit<T0>(arg0: &LotteryPool<T0>, arg1: address) : u64 {
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

    // decompiled from Move bytecode v6
}

