module 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::bot {
    struct RasenganBot has key {
        id: 0x2::object::UID,
        capital_usdc: u64,
        n_positions: u8,
        position_width: u16,
        shift_count: u8,
        buffer_ticks: u8,
        cooldown_seconds: u64,
        tick_min: u32,
        tick_max: u32,
        last_tick_seen: u32,
        last_shift_ts: u64,
        shift_count_total: u32,
        run_started_at: u64,
        run_started_tick: u32,
        mode: u8,
        positions: 0x2::table::Table<u8, 0x2::object::ID>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        bot_id: 0x2::object::ID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        bot_id: 0x2::object::ID,
    }

    struct BotCreated has copy, drop {
        bot_id: 0x2::object::ID,
        admin: address,
        capital_usdc: u64,
        n_positions: u8,
        shift_count: u8,
        timestamp_ms: u64,
    }

    struct GridInitialized has copy, drop {
        bot_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        n_positions: u8,
        center_tick: u32,
        tick_min: u32,
        tick_max: u32,
        total_usdc: u64,
        total_sui: u64,
        timestamp_ms: u64,
    }

    struct TickResult has copy, drop {
        triggered: bool,
        direction: u8,
        current_tick: u32,
    }

    struct ShiftTriggered has copy, drop {
        bot_id: 0x2::object::ID,
        direction: u8,
        current_tick: u32,
        tick_min: u32,
        tick_max: u32,
        buffer_ticks: u8,
        timestamp_ms: u64,
    }

    struct ShiftExecuted has copy, drop {
        bot_id: 0x2::object::ID,
        n_closed: u8,
        n_opened: u8,
        new_tick_min: u32,
        new_tick_max: u32,
        new_center_tick: u32,
        timestamp_ms: u64,
    }

    struct ShiftPartialExecuted has copy, drop {
        bot_id: 0x2::object::ID,
        direction: u8,
        n_shifted: u8,
        old_tick_min: u32,
        old_tick_max: u32,
        new_tick_min: u32,
        new_tick_max: u32,
        timestamp_ms: u64,
    }

    struct ModeChanged has copy, drop {
        bot_id: 0x2::object::ID,
        old_mode: u8,
        new_mode: u8,
        timestamp_ms: u64,
    }

    struct StrategyChanged has copy, drop {
        bot_id: 0x2::object::ID,
        old_sc: u8,
        new_sc: u8,
        old_buf: u8,
        new_buf: u8,
        old_cooldown: u64,
        new_cooldown: u64,
    }

    struct WithdrawalExecuted has copy, drop {
        bot_id: 0x2::object::ID,
        amount_usdc: u64,
        amount_sui: u64,
        timestamp_ms: u64,
    }

    public fun admin_bot_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.bot_id
    }

    fun assert_admin_for_bot(arg0: &AdminCap, arg1: &RasenganBot) {
        assert!(arg0.bot_id == 0x2::object::id<RasenganBot>(arg1), 1);
    }

    fun assert_keeper_for_bot(arg0: &KeeperCap, arg1: &RasenganBot) {
        assert!(arg0.bot_id == 0x2::object::id<RasenganBot>(arg1), 1);
    }

    fun assert_running(arg0: &RasenganBot) {
        assert!(arg0.mode == 0, 2);
    }

    public fun buffer_ticks(arg0: &RasenganBot) : u8 {
        arg0.buffer_ticks
    }

    public fun capital_usdc(arg0: &RasenganBot) : u64 {
        arg0.capital_usdc
    }

    public fun close_all_and_withdraw(arg0: &AdminCap, arg1: &mut RasenganBot, arg2: &mut 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPool, arg3: vector<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>, 0x2::coin::Coin<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>) {
        assert_admin_for_bot(arg0, arg1);
        let v0 = arg1.n_positions;
        assert!((0x1::vector::length<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(&arg3) as u8) == v0, 2);
        let v1 = 0x2::coin::zero<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(arg5);
        let v2 = 0x2::coin::zero<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(arg5);
        let v3 = 0;
        while (v3 < v0) {
            let (v4, v5) = 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::close_position(arg2, 0x1::vector::pop_back<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(&mut arg3), arg5);
            0x2::coin::join<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(&mut v1, v4);
            0x2::coin::join<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(&mut v2, v5);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(arg3);
        let v6 = 0;
        while (v6 < v0) {
            0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v6);
            v6 = v6 + 1;
        };
        arg1.tick_min = 0;
        arg1.tick_max = 0;
        arg1.last_tick_seen = 0;
        arg1.mode = 2;
        let v7 = WithdrawalExecuted{
            bot_id       : 0x2::object::id<RasenganBot>(arg1),
            amount_usdc  : 0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(&v1),
            amount_sui   : 0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(&v2),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<WithdrawalExecuted>(v7);
        (v1, v2)
    }

    public fun close_all_and_withdraw_cetus<T0, T1>(arg0: &AdminCap, arg1: &mut RasenganBot, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_admin_for_bot(arg0, arg1);
        let v0 = arg1.n_positions;
        assert!((0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg4) as u8) == v0, 2);
        let v1 = 0x2::coin::zero<T0>(arg6);
        let v2 = 0x2::coin::zero<T1>(arg6);
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg4);
            let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, &mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v4), arg5);
            let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, &v4, true);
            0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v5, arg6));
            0x2::coin::join<T1>(&mut v2, 0x2::coin::from_balance<T1>(v6, arg6));
            0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v7, arg6));
            0x2::coin::join<T1>(&mut v2, 0x2::coin::from_balance<T1>(v8, arg6));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg3, v4);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg4);
        let v9 = 0;
        while (v9 < v0) {
            0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v9);
            v9 = v9 + 1;
        };
        arg1.tick_min = 0;
        arg1.tick_max = 0;
        arg1.last_tick_seen = 0;
        arg1.mode = 2;
        let v10 = WithdrawalExecuted{
            bot_id       : 0x2::object::id<RasenganBot>(arg1),
            amount_usdc  : 0x2::coin::value<T0>(&v1),
            amount_sui   : 0x2::coin::value<T1>(&v2),
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<WithdrawalExecuted>(v10);
        (v1, v2)
    }

    public fun create_bot(arg0: u64, arg1: u8, arg2: u16, arg3: u8, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = RasenganBot{
            id                : 0x2::object::new(arg7),
            capital_usdc      : arg0,
            n_positions       : arg1,
            position_width    : arg2,
            shift_count       : arg3,
            buffer_ticks      : arg4,
            cooldown_seconds  : arg5,
            tick_min          : 0,
            tick_max          : 0,
            last_tick_seen    : 0,
            last_shift_ts     : 0,
            shift_count_total : 0,
            run_started_at    : v0,
            run_started_tick  : 0,
            mode              : 0,
            positions         : 0x2::table::new<u8, 0x2::object::ID>(arg7),
        };
        let v2 = 0x2::object::id<RasenganBot>(&v1);
        let v3 = AdminCap{
            id     : 0x2::object::new(arg7),
            bot_id : v2,
        };
        let v4 = KeeperCap{
            id     : 0x2::object::new(arg7),
            bot_id : v2,
        };
        let v5 = BotCreated{
            bot_id       : v2,
            admin        : 0x2::tx_context::sender(arg7),
            capital_usdc : arg0,
            n_positions  : arg1,
            shift_count  : arg3,
            timestamp_ms : v0,
        };
        0x2::event::emit<BotCreated>(v5);
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<KeeperCap>(v4, 0x2::tx_context::sender(arg7));
        0x2::transfer::share_object<RasenganBot>(v1);
    }

    public fun init_grid(arg0: &AdminCap, arg1: &mut RasenganBot, arg2: &mut 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPool, arg3: 0x2::coin::Coin<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>, arg4: 0x2::coin::Coin<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin_for_bot(arg0, arg1);
        assert!(0x2::table::length<u8, 0x2::object::ID>(&arg1.positions) == 0, 3);
        let v0 = 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::current_tick(arg2);
        let v1 = arg1.n_positions;
        let v2 = arg1.position_width;
        arg1.tick_min = v0 - (v1 as u32) * (v2 as u32) / 2;
        arg1.tick_max = arg1.tick_min + (v1 as u32) * (v2 as u32);
        arg1.run_started_tick = v0;
        arg1.last_tick_seen = v0;
        arg1.run_started_at = 0x2::clock::timestamp_ms(arg5);
        let v3 = 0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(&arg3);
        let v4 = 0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(&arg4);
        let v5 = 0;
        while (v5 < v1) {
            let v6 = arg1.tick_min + (v5 as u32) * (v2 as u32);
            let v7 = if (v5 + 1 == v1) {
                0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(&arg3)
            } else {
                v3 / (v1 as u64)
            };
            let v8 = if (v5 + 1 == v1) {
                0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(&arg4)
            } else {
                v4 / (v1 as u64)
            };
            let v9 = 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::open_position(arg2, v6, v6 + (v2 as u32), 0x2::coin::split<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(&mut arg3, v7, arg6), 0x2::coin::split<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(&mut arg4, v8, arg6), arg6);
            0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v5, 0x2::object::id<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(&v9));
            0x2::transfer::public_transfer<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(v9, 0x2::tx_context::sender(arg6));
            v5 = v5 + 1;
        };
        0x2::coin::destroy_zero<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(arg3);
        0x2::coin::destroy_zero<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(arg4);
        let v10 = GridInitialized{
            bot_id       : 0x2::object::id<RasenganBot>(arg1),
            pool_id      : 0x2::object::id<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPool>(arg2),
            n_positions  : v1,
            center_tick  : v0,
            tick_min     : arg1.tick_min,
            tick_max     : arg1.tick_max,
            total_usdc   : v3,
            total_sui    : v4,
            timestamp_ms : arg1.run_started_at,
        };
        0x2::event::emit<GridInitialized>(v10);
    }

    public fun init_grid_cetus<T0, T1>(arg0: &AdminCap, arg1: &mut RasenganBot, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_admin_for_bot(arg0, arg1);
        assert!(0x2::table::length<u8, 0x2::object::ID>(&arg1.positions) == 0, 3);
        let v0 = arg1.n_positions;
        let v1 = arg1.position_width;
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3)) / (v1 as u32) * (v1 as u32);
        arg1.tick_min = v2 - (v0 as u32) * (v1 as u32) / 2;
        arg1.tick_max = arg1.tick_min + (v0 as u32) * (v1 as u32);
        arg1.run_started_tick = v2;
        arg1.last_tick_seen = v2;
        arg1.run_started_at = 0x2::clock::timestamp_ms(arg6);
        let v3 = 0x2::coin::value<T0>(&arg4);
        let v4 = 0x2::coin::value<T1>(&arg5);
        let v5 = 0;
        while (v5 < v0) {
            let v6 = arg1.tick_min + (v5 as u32) * (v1 as u32);
            let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, v6, v6 + (v1 as u32), arg7);
            let v8 = v6 >= v2;
            let v9 = if (v8) {
                v3 / ((v0 as u64) + 1)
            } else {
                v4 / ((v0 as u64) + 1)
            };
            let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg3, &mut v7, v9, v8, arg6);
            let (v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v10);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v11, arg7)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, v12, arg7)), v10);
            0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v5, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v7));
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v7, 0x2::tx_context::sender(arg7));
            v5 = v5 + 1;
        };
        if (0x2::coin::value<T0>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(arg4);
        };
        if (0x2::coin::value<T1>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T1>(arg5);
        };
        let v13 = GridInitialized{
            bot_id       : 0x2::object::id<RasenganBot>(arg1),
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            n_positions  : v0,
            center_tick  : v2,
            tick_min     : arg1.tick_min,
            tick_max     : arg1.tick_max,
            total_usdc   : v3,
            total_sui    : v4,
            timestamp_ms : arg1.run_started_at,
        };
        0x2::event::emit<GridInitialized>(v13);
    }

    public fun keeper_bot_id(arg0: &KeeperCap) : 0x2::object::ID {
        arg0.bot_id
    }

    public fun mint_keeper_cap(arg0: &AdminCap, arg1: &RasenganBot, arg2: &mut 0x2::tx_context::TxContext) : KeeperCap {
        assert_admin_for_bot(arg0, arg1);
        KeeperCap{
            id     : 0x2::object::new(arg2),
            bot_id : 0x2::object::id<RasenganBot>(arg1),
        }
    }

    public fun mode(arg0: &RasenganBot) : u8 {
        arg0.mode
    }

    public fun mode_paused_const() : u8 {
        1
    }

    public fun mode_running_const() : u8 {
        0
    }

    public fun mode_stopped_const() : u8 {
        2
    }

    public fun n_positions(arg0: &RasenganBot) : u8 {
        arg0.n_positions
    }

    public fun position_width(arg0: &RasenganBot) : u16 {
        arg0.position_width
    }

    public fun record_init(arg0: &AdminCap, arg1: &mut RasenganBot, arg2: u32, arg3: vector<0x2::object::ID>, arg4: &0x2::clock::Clock) {
        assert_admin_for_bot(arg0, arg1);
        assert!(0x2::table::length<u8, 0x2::object::ID>(&arg1.positions) == 0, 3);
        let v0 = arg1.n_positions;
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) == (v0 as u64), 2);
        let v1 = arg1.position_width;
        arg1.tick_min = arg2 - (v0 as u32) * (v1 as u32) / 2;
        arg1.tick_max = arg1.tick_min + (v0 as u32) * (v1 as u32);
        arg1.run_started_tick = arg2;
        arg1.last_tick_seen = arg2;
        arg1.run_started_at = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0;
        while (v2 < v0) {
            0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v2, *0x1::vector::borrow<0x2::object::ID>(&arg3, (v2 as u64)));
            v2 = v2 + 1;
        };
        let v3 = GridInitialized{
            bot_id       : 0x2::object::id<RasenganBot>(arg1),
            pool_id      : 0x2::object::id_from_address(@0x0),
            n_positions  : v0,
            center_tick  : arg2,
            tick_min     : arg1.tick_min,
            tick_max     : arg1.tick_max,
            total_usdc   : 0,
            total_sui    : 0,
            timestamp_ms : arg1.run_started_at,
        };
        0x2::event::emit<GridInitialized>(v3);
    }

    public fun record_revive(arg0: &KeeperCap, arg1: &mut RasenganBot, arg2: u32, arg3: vector<0x2::object::ID>, arg4: &0x2::clock::Clock) {
        assert_keeper_for_bot(arg0, arg1);
        let v0 = arg1.n_positions;
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) == (v0 as u64), 2);
        let v1 = 0;
        while (v1 < v0) {
            0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v1);
            v1 = v1 + 1;
        };
        let v2 = arg1.position_width;
        arg1.tick_min = arg2 - (v0 as u32) * (v2 as u32) / 2;
        arg1.tick_max = arg1.tick_min + (v0 as u32) * (v2 as u32);
        arg1.last_tick_seen = arg2;
        let v3 = 0;
        while (v3 < v0) {
            0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v3, *0x1::vector::borrow<0x2::object::ID>(&arg3, (v3 as u64)));
            v3 = v3 + 1;
        };
        arg1.shift_count_total = arg1.shift_count_total + 1;
        arg1.last_shift_ts = 0x2::clock::timestamp_ms(arg4);
        let v4 = ShiftExecuted{
            bot_id          : 0x2::object::id<RasenganBot>(arg1),
            n_closed        : v0,
            n_opened        : v0,
            new_tick_min    : arg1.tick_min,
            new_tick_max    : arg1.tick_max,
            new_center_tick : arg2,
            timestamp_ms    : arg1.last_shift_ts,
        };
        0x2::event::emit<ShiftExecuted>(v4);
    }

    public fun record_shift_partial(arg0: &KeeperCap, arg1: &mut RasenganBot, arg2: u8, arg3: vector<0x2::object::ID>, arg4: &0x2::clock::Clock) {
        assert_keeper_for_bot(arg0, arg1);
        assert!(arg2 == 1 || arg2 == 2, 2);
        let v0 = arg1.shift_count;
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) == (v0 as u64), 2);
        assert!(v0 > 0 && v0 < arg1.n_positions, 2);
        let v1 = arg1.n_positions;
        let v2 = (v0 as u32) * (arg1.position_width as u32);
        if (arg2 == 1) {
            let v3 = 0;
            while (v3 < v0) {
                0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v3);
                v3 = v3 + 1;
            };
            let v4 = 0;
            while (v4 < v1 - v0) {
                0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v4, 0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v0 + v4));
                v4 = v4 + 1;
            };
            arg1.tick_min = arg1.tick_min + v2;
            arg1.tick_max = arg1.tick_max + v2;
            let v5 = 0;
            while (v5 < v0) {
                0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v1 - v0 + v5, *0x1::vector::borrow<0x2::object::ID>(&arg3, (v5 as u64)));
                v5 = v5 + 1;
            };
        } else {
            let v6 = 0;
            while (v6 < v0) {
                0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v1 - v0 + v6);
                v6 = v6 + 1;
            };
            let v7 = v1 - v0;
            while (v7 > 0) {
                v7 = v7 - 1;
                0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v7 + v0, 0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v7));
            };
            arg1.tick_min = arg1.tick_min - v2;
            arg1.tick_max = arg1.tick_max - v2;
            let v8 = 0;
            while (v8 < v0) {
                0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v8, *0x1::vector::borrow<0x2::object::ID>(&arg3, (v8 as u64)));
                v8 = v8 + 1;
            };
        };
        arg1.shift_count_total = arg1.shift_count_total + 1;
        arg1.last_shift_ts = 0x2::clock::timestamp_ms(arg4);
        let v9 = ShiftPartialExecuted{
            bot_id       : 0x2::object::id<RasenganBot>(arg1),
            direction    : arg2,
            n_shifted    : v0,
            old_tick_min : arg1.tick_min,
            old_tick_max : arg1.tick_max,
            new_tick_min : arg1.tick_min,
            new_tick_max : arg1.tick_max,
            timestamp_ms : arg1.last_shift_ts,
        };
        0x2::event::emit<ShiftPartialExecuted>(v9);
    }

    public fun record_withdrawal(arg0: &AdminCap, arg1: &mut RasenganBot, arg2: &0x2::clock::Clock) {
        assert_admin_for_bot(arg0, arg1);
        let v0 = 0;
        while (v0 < arg1.n_positions) {
            if (0x2::table::contains<u8, 0x2::object::ID>(&arg1.positions, v0)) {
                0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v0);
            };
            v0 = v0 + 1;
        };
        arg1.tick_min = 0;
        arg1.tick_max = 0;
        arg1.last_tick_seen = 0;
        arg1.mode = 2;
        let v1 = WithdrawalExecuted{
            bot_id       : 0x2::object::id<RasenganBot>(arg1),
            amount_usdc  : 0,
            amount_sui   : 0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawalExecuted>(v1);
    }

    public fun revive_atomic(arg0: &KeeperCap, arg1: &mut RasenganBot, arg2: &mut 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPool, arg3: vector<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>, arg4: 0x2::coin::Coin<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>, arg5: 0x2::coin::Coin<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition> {
        assert_keeper_for_bot(arg0, arg1);
        let v0 = arg1.n_positions;
        assert!((0x1::vector::length<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(&arg3) as u8) == v0, 2);
        let v1 = 0;
        while (v1 < v0) {
            let (v2, v3) = 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::close_position(arg2, 0x1::vector::pop_back<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(&mut arg3), arg7);
            0x2::coin::join<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(&mut arg4, v2);
            0x2::coin::join<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(&mut arg5, v3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(arg3);
        let v4 = 0;
        while (v4 < v0) {
            0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v4);
            v4 = v4 + 1;
        };
        let v5 = 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::current_tick(arg2);
        let v6 = arg1.position_width;
        arg1.tick_min = v5 - (v0 as u32) * (v6 as u32) / 2;
        arg1.tick_max = arg1.tick_min + (v0 as u32) * (v6 as u32);
        arg1.last_tick_seen = v5;
        let v7 = 0x1::vector::empty<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>();
        let v8 = 0;
        while (v8 < v0) {
            let v9 = arg1.tick_min + (v8 as u32) * (v6 as u32);
            let v10 = if (v8 + 1 == v0) {
                0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(&arg4)
            } else {
                0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(&arg4) / (v0 as u64)
            };
            let v11 = if (v8 + 1 == v0) {
                0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(&arg5)
            } else {
                0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(&arg5) / (v0 as u64)
            };
            let v12 = 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::open_position(arg2, v9, v9 + (v6 as u32), 0x2::coin::split<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(&mut arg4, v10, arg7), 0x2::coin::split<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(&mut arg5, v11, arg7), arg7);
            0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v8, 0x2::object::id<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(&v12));
            0x1::vector::push_back<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(&mut v7, v12);
            v8 = v8 + 1;
        };
        0x2::coin::destroy_zero<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(arg4);
        0x2::coin::destroy_zero<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(arg5);
        arg1.shift_count_total = arg1.shift_count_total + 1;
        arg1.last_shift_ts = 0x2::clock::timestamp_ms(arg6);
        let v13 = ShiftExecuted{
            bot_id          : 0x2::object::id<RasenganBot>(arg1),
            n_closed        : v0,
            n_opened        : v0,
            new_tick_min    : arg1.tick_min,
            new_tick_max    : arg1.tick_max,
            new_center_tick : v5,
            timestamp_ms    : arg1.last_shift_ts,
        };
        0x2::event::emit<ShiftExecuted>(v13);
        v7
    }

    public fun revive_atomic_cetus<T0, T1>(arg0: &KeeperCap, arg1: &mut RasenganBot, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position> {
        assert_keeper_for_bot(arg0, arg1);
        let v0 = arg1.n_positions;
        assert!((0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg4) as u8) == v0, 2);
        let v1 = arg1.position_width;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg4);
            let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, &mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v3), arg7);
            let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, &v3, true);
            0x2::coin::join<T0>(&mut arg5, 0x2::coin::from_balance<T0>(v4, arg8));
            0x2::coin::join<T1>(&mut arg6, 0x2::coin::from_balance<T1>(v5, arg8));
            0x2::coin::join<T0>(&mut arg5, 0x2::coin::from_balance<T0>(v6, arg8));
            0x2::coin::join<T1>(&mut arg6, 0x2::coin::from_balance<T1>(v7, arg8));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg3, v3);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg4);
        let v8 = 0;
        while (v8 < v0) {
            0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v8);
            v8 = v8 + 1;
        };
        let v9 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3)) / (v1 as u32) * (v1 as u32);
        arg1.tick_min = v9 - (v0 as u32) * (v1 as u32) / 2;
        arg1.tick_max = arg1.tick_min + (v0 as u32) * (v1 as u32);
        arg1.last_tick_seen = v9;
        let v10 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>();
        let v11 = 0;
        while (v11 < v0) {
            let v12 = arg1.tick_min + (v11 as u32) * (v1 as u32);
            let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, v12, v12 + (v1 as u32), arg8);
            let v14 = v12 >= v9;
            let v15 = if (v14) {
                0x2::coin::value<T0>(&arg5) / (v0 as u64)
            } else {
                0x2::coin::value<T1>(&arg6) / (v0 as u64)
            };
            let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg3, &mut v13, v15, v14, arg7);
            let (v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v16);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, v17, arg8)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg6, v18, arg8)), v16);
            0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v11, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v13));
            0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v10, v13);
            v11 = v11 + 1;
        };
        if (0x2::coin::value<T0>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
        if (0x2::coin::value<T1>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg6, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<T1>(arg6);
        };
        arg1.shift_count_total = arg1.shift_count_total + 1;
        arg1.last_shift_ts = 0x2::clock::timestamp_ms(arg7);
        let v19 = ShiftExecuted{
            bot_id          : 0x2::object::id<RasenganBot>(arg1),
            n_closed        : v0,
            n_opened        : v0,
            new_tick_min    : arg1.tick_min,
            new_tick_max    : arg1.tick_max,
            new_center_tick : v9,
            timestamp_ms    : arg1.last_shift_ts,
        };
        0x2::event::emit<ShiftExecuted>(v19);
        v10
    }

    public fun run_started_at(arg0: &RasenganBot) : u64 {
        arg0.run_started_at
    }

    public fun set_mode(arg0: &AdminCap, arg1: &mut RasenganBot, arg2: u8, arg3: &0x2::clock::Clock) {
        assert_admin_for_bot(arg0, arg1);
        assert!(arg2 <= 2, 2);
        arg1.mode = arg2;
        let v0 = ModeChanged{
            bot_id       : 0x2::object::id<RasenganBot>(arg1),
            old_mode     : arg1.mode,
            new_mode     : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ModeChanged>(v0);
    }

    public fun set_strategy(arg0: &AdminCap, arg1: &mut RasenganBot, arg2: u8, arg3: u8, arg4: u64) {
        assert_admin_for_bot(arg0, arg1);
        arg1.shift_count = arg2;
        arg1.buffer_ticks = arg3;
        arg1.cooldown_seconds = arg4;
        let v0 = StrategyChanged{
            bot_id       : 0x2::object::id<RasenganBot>(arg1),
            old_sc       : arg1.shift_count,
            new_sc       : arg2,
            old_buf      : arg1.buffer_ticks,
            new_buf      : arg3,
            old_cooldown : arg1.cooldown_seconds,
            new_cooldown : arg4,
        };
        0x2::event::emit<StrategyChanged>(v0);
    }

    public fun shift_count(arg0: &RasenganBot) : u8 {
        arg0.shift_count
    }

    public fun shift_count_total(arg0: &RasenganBot) : u32 {
        arg0.shift_count_total
    }

    public fun shift_down_const() : u8 {
        2
    }

    public fun shift_none_const() : u8 {
        0
    }

    public fun shift_partial_atomic(arg0: &KeeperCap, arg1: &mut RasenganBot, arg2: &mut 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPool, arg3: u8, arg4: vector<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>, arg5: 0x2::coin::Coin<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>, arg6: 0x2::coin::Coin<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition> {
        assert_keeper_for_bot(arg0, arg1);
        assert!(arg3 == 1 || arg3 == 2, 2);
        let v0 = arg1.shift_count;
        assert!((0x1::vector::length<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(&arg4) as u8) == v0, 2);
        assert!(v0 > 0 && v0 < arg1.n_positions, 2);
        let v1 = arg1.position_width;
        let v2 = 0;
        while (v2 < v0) {
            let (v3, v4) = 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::close_position(arg2, 0x1::vector::pop_back<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(&mut arg4), arg8);
            0x2::coin::join<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(&mut arg5, v3);
            0x2::coin::join<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(&mut arg6, v4);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(arg4);
        let v5 = (v0 as u32) * (v1 as u32);
        if (arg3 == 1) {
            arg1.tick_min = arg1.tick_min + v5;
            arg1.tick_max = arg1.tick_max + v5;
        } else {
            arg1.tick_min = arg1.tick_min - v5;
            arg1.tick_max = arg1.tick_max - v5;
        };
        let v6 = arg1.n_positions;
        if (arg3 == 1) {
            let v7 = 0;
            while (v7 < v0) {
                0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v7);
                v7 = v7 + 1;
            };
            let v8 = 0;
            while (v8 < v6 - v0) {
                0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v8, 0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v0 + v8));
                v8 = v8 + 1;
            };
        } else {
            let v9 = 0;
            while (v9 < v0) {
                0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v6 - v0 + v9);
                v9 = v9 + 1;
            };
            let v10 = v6 - v0;
            while (v10 > 0) {
                v10 = v10 - 1;
                0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v10 + v0, 0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v10));
            };
        };
        let v11 = 0x1::vector::empty<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>();
        let v12 = 0;
        while (v12 < v0) {
            let (v13, v14) = if (arg3 == 1) {
                (arg1.tick_min + ((v6 - v0 + v12) as u32) * (v1 as u32), v6 - v0 + v12)
            } else {
                (arg1.tick_min + (v12 as u32) * (v1 as u32), v12)
            };
            let v15 = if (v12 + 1 == v0) {
                0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(&arg5)
            } else {
                0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(&arg5) / (v0 as u64)
            };
            let v16 = if (v12 + 1 == v0) {
                0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(&arg6)
            } else {
                0x2::coin::value<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(&arg6) / (v0 as u64)
            };
            let v17 = 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::open_position(arg2, v13, v13 + (v1 as u32), 0x2::coin::split<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(&mut arg5, v15, arg8), 0x2::coin::split<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(&mut arg6, v16, arg8), arg8);
            0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v14, 0x2::object::id<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(&v17));
            0x1::vector::push_back<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPosition>(&mut v11, v17);
            v12 = v12 + 1;
        };
        0x2::coin::destroy_zero<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_USDC>(arg5);
        0x2::coin::destroy_zero<0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MOCK_SUI>(arg6);
        arg1.shift_count_total = arg1.shift_count_total + 1;
        arg1.last_shift_ts = 0x2::clock::timestamp_ms(arg7);
        let v18 = ShiftPartialExecuted{
            bot_id       : 0x2::object::id<RasenganBot>(arg1),
            direction    : arg3,
            n_shifted    : v0,
            old_tick_min : arg1.tick_min,
            old_tick_max : arg1.tick_max,
            new_tick_min : arg1.tick_min,
            new_tick_max : arg1.tick_max,
            timestamp_ms : arg1.last_shift_ts,
        };
        0x2::event::emit<ShiftPartialExecuted>(v18);
        v11
    }

    public fun shift_partial_atomic_cetus<T0, T1>(arg0: &KeeperCap, arg1: &mut RasenganBot, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u8, arg5: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position> {
        assert_keeper_for_bot(arg0, arg1);
        assert!(arg4 == 1 || arg4 == 2, 2);
        let v0 = arg1.shift_count;
        assert!((0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg5) as u8) == v0, 2);
        assert!(v0 > 0 && v0 < arg1.n_positions, 2);
        let v1 = arg1.position_width;
        let v2 = arg1.n_positions;
        let v3 = (v0 as u32) * (v1 as u32);
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg5);
            let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, &mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v5), arg8);
            let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, &v5, true);
            0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v6, arg9));
            0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v7, arg9));
            0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v8, arg9));
            0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v9, arg9));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg3, v5);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg5);
        if (arg4 == 1) {
            let v10 = 0;
            while (v10 < v0) {
                0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v10);
                v10 = v10 + 1;
            };
            let v11 = 0;
            while (v11 < v2 - v0) {
                0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v11, 0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v0 + v11));
                v11 = v11 + 1;
            };
            arg1.tick_min = arg1.tick_min + v3;
            arg1.tick_max = arg1.tick_max + v3;
        } else {
            let v12 = 0;
            while (v12 < v0) {
                0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v2 - v0 + v12);
                v12 = v12 + 1;
            };
            let v13 = v2 - v0;
            while (v13 > 0) {
                v13 = v13 - 1;
                0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v13 + v0, 0x2::table::remove<u8, 0x2::object::ID>(&mut arg1.positions, v13));
            };
            arg1.tick_min = arg1.tick_min - v3;
            arg1.tick_max = arg1.tick_max - v3;
        };
        let v14 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>();
        let v15 = 0;
        while (v15 < v0) {
            let (v16, v17) = if (arg4 == 1) {
                (arg1.tick_min + ((v2 - v0 + v15) as u32) * (v1 as u32), v2 - v0 + v15)
            } else {
                (arg1.tick_min + (v15 as u32) * (v1 as u32), v15)
            };
            let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, v16, v16 + (v1 as u32), arg9);
            let v19 = v16 >= 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3)) / (v1 as u32) * (v1 as u32);
            let v20 = if (v19) {
                0x2::coin::value<T0>(&arg6) / (v0 as u64)
            } else {
                0x2::coin::value<T1>(&arg7) / (v0 as u64)
            };
            let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg3, &mut v18, v20, v19, arg8);
            let (v22, v23) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v21);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg6, v22, arg9)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg7, v23, arg9)), v21);
            0x2::table::add<u8, 0x2::object::ID>(&mut arg1.positions, v17, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v18));
            0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v14, v18);
            v15 = v15 + 1;
        };
        if (0x2::coin::value<T0>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<T0>(arg6);
        };
        if (0x2::coin::value<T1>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg7, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<T1>(arg7);
        };
        arg1.shift_count_total = arg1.shift_count_total + 1;
        arg1.last_shift_ts = 0x2::clock::timestamp_ms(arg8);
        let v24 = ShiftPartialExecuted{
            bot_id       : 0x2::object::id<RasenganBot>(arg1),
            direction    : arg4,
            n_shifted    : v0,
            old_tick_min : arg1.tick_min,
            old_tick_max : arg1.tick_max,
            new_tick_min : arg1.tick_min,
            new_tick_max : arg1.tick_max,
            timestamp_ms : arg1.last_shift_ts,
        };
        0x2::event::emit<ShiftPartialExecuted>(v24);
        v14
    }

    public fun shift_up_const() : u8 {
        1
    }

    public fun tick(arg0: &KeeperCap, arg1: &mut RasenganBot, arg2: &0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::MockPool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : TickResult {
        assert_keeper_for_bot(arg0, arg1);
        let v0 = 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool::current_tick(arg2);
        arg1.last_tick_seen = v0;
        if (arg1.mode != 0) {
            return TickResult{
                triggered    : false,
                direction    : 0,
                current_tick : v0,
            }
        };
        if (arg1.tick_max == 0) {
            return TickResult{
                triggered    : false,
                direction    : 0,
                current_tick : v0,
            }
        };
        let v1 = 0x2::clock::timestamp_ms(arg3);
        if (arg1.last_shift_ts > 0 && arg1.cooldown_seconds > 0) {
            if ((v1 - arg1.last_shift_ts) / 1000 < arg1.cooldown_seconds) {
                return TickResult{
                    triggered    : false,
                    direction    : 0,
                    current_tick : v0,
                }
            };
        };
        let v2 = (arg1.buffer_ticks as u32);
        let v3 = if (v0 + v2 >= arg1.tick_max) {
            1
        } else if (v0 < arg1.tick_min + v2) {
            2
        } else {
            0
        };
        if (v3 != 0) {
            let v4 = ShiftTriggered{
                bot_id       : 0x2::object::id<RasenganBot>(arg1),
                direction    : v3,
                current_tick : v0,
                tick_min     : arg1.tick_min,
                tick_max     : arg1.tick_max,
                buffer_ticks : arg1.buffer_ticks,
                timestamp_ms : v1,
            };
            0x2::event::emit<ShiftTriggered>(v4);
        };
        TickResult{
            triggered    : v3 != 0,
            direction    : v3,
            current_tick : v0,
        }
    }

    public fun tick_max(arg0: &RasenganBot) : u32 {
        arg0.tick_max
    }

    public fun tick_min(arg0: &RasenganBot) : u32 {
        arg0.tick_min
    }

    public fun tick_result_current_tick(arg0: &TickResult) : u32 {
        arg0.current_tick
    }

    public fun tick_result_direction(arg0: &TickResult) : u8 {
        arg0.direction
    }

    public fun tick_result_triggered(arg0: &TickResult) : bool {
        arg0.triggered
    }

    // decompiled from Move bytecode v7
}

