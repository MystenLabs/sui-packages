module 0x36d9b42ccaefbd4541e0a143115c7abba245ff7ed4955e867f083849fc94aacb::LLV3 {
    struct LotusPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
        init_a: u64,
        init_b: u64,
        init_reward_b: u64,
        init_lp_b: u64,
        pool_created: u64,
        created_by: address,
        block_price: u64,
        block_quantity: u64,
        max_blocks: u64,
        buyback_limit: u64,
        lp_builder_fee: u64,
        burn_fee: u64,
        creator_royalty_fee: u64,
        rewards_fee: u64,
        creator_royalty_wallet: address,
    }

    struct Trade has copy, drop {
        pool_id: 0x2::object::ID,
        wallet: address,
        tokenin: 0x1::type_name::TypeName,
        amountin: u64,
        tokenout: 0x1::type_name::TypeName,
        amountout: u64,
        is_buy: bool,
        reserve_a: u64,
        reserve_b: u64,
        trade_fee: u64,
        block_price: u64,
        block_quantity: u64,
        blocks_sold: u64,
        buyback_closed: bool,
        pool_sold_out: bool,
        close_deadline: 0x1::option::Option<u64>,
        timestamp: u64,
    }

    struct PoolClosed has copy, drop {
        pool_id: 0x2::object::ID,
        reason: vector<u8>,
        timestamp: u64,
    }

    struct BuybackClosed has copy, drop {
        pool_id: 0x2::object::ID,
        blocks_sold: u64,
        close_deadline: u64,
        timestamp: u64,
    }

    struct PoolSoldOut has copy, drop {
        pool_id: 0x2::object::ID,
        total_blocks: u64,
        timestamp: u64,
    }

    struct TradeFeeDistributed has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        timestamp: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        trade_fee: u64,
        trade_fee_wallet: address,
        admin: address,
        launch_manager: address,
    }

    struct CreatePoolLock has key {
        id: 0x2::object::UID,
        locked: bool,
        allowlist: vector<address>,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        trade_balance_a: 0x2::balance::Balance<T0>,
        reward_balance_b: 0x2::balance::Balance<T1>,
        lp_deposit: 0x2::balance::Balance<T1>,
        pool_created: u64,
        created_by: address,
        block_price: u64,
        block_quantity: u64,
        blocks_sold: u64,
        max_blocks: u64,
        buyback_limit: u64,
        close_deadline: 0x1::option::Option<u64>,
        buyers: 0x2::table::Table<address, bool>,
        lp_builder_fee: u64,
        burn_fee: u64,
        creator_royalty_fee: u64,
        rewards_fee: u64,
        creator_royalty_wallet: address,
        buyback_open: bool,
        sold_out: bool,
        pool_closed: bool,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<PoolItem, 0x2::object::ID>,
    }

    struct PoolItem has copy, drop, store {
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
    }

    fun add_pool<T0, T1>(arg0: &mut Factory, arg1: 0x2::object::ID) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 1);
        let v2 = PoolItem{
            a : v0,
            b : v1,
        };
        let v3 = PoolItem{
            a : v1,
            b : v0,
        };
        let v4 = 0x2::table::contains<PoolItem, 0x2::object::ID>(&arg0.pools, v2) || 0x2::table::contains<PoolItem, 0x2::object::ID>(&arg0.pools, v3);
        assert!(!v4, 2);
        let v5 = PoolItem{
            a : v0,
            b : v1,
        };
        0x2::table::add<PoolItem, 0x2::object::ID>(&mut arg0.pools, v5, arg1);
    }

    public entry fun add_to_allowlist(arg0: &mut CreatePoolLock, arg1: &Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 4);
        assert!(!0x1::vector::contains<address>(&arg0.allowlist, &arg2), 7);
        0x1::vector::push_back<address>(&mut arg0.allowlist, arg2);
    }

    public entry fun buy_block<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = compute_total_input(arg0.block_price, arg1.trade_fee);
        assert!(0x2::coin::value<T0>(&arg2) >= v1, 22);
        let v2 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v1, arg4));
        let v3 = trade_a_for_b<T0, T1>(arg0, arg1, v2, arg3, arg4);
        let v4 = 0x2::tx_context::sender(arg4);
        destroy_zero_or_transfer_balance<T0>(0x2::coin::into_balance<T0>(arg2), v4, arg4);
        destroy_zero_or_transfer_balance<T1>(v3, v4, arg4);
    }

    public fun compute_total_input(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = arg0 * arg1 / 10000;
        (v0, arg0 + v0)
    }

    public fun create_lotus_pool<T0, T1>(arg0: &mut Factory, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T1>, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: address, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1) > 0 && 0x2::balance::value<T1>(&arg2) > 0, 0);
        assert!(0x2::balance::value<T1>(&arg3) > 0, 0);
        assert!(0x2::balance::value<T1>(&arg4) > 0, 0);
        assert!(arg5 != @0x0, 9);
        assert!(arg6 > 0, 15);
        assert!(arg7 > 0, 16);
        assert!(arg8 > 0, 17);
        assert!(arg9 > 0, 18);
        assert!(arg10 <= 300, 3);
        assert!(arg11 <= 500, 3);
        assert!(arg12 <= 100, 3);
        assert!(arg13 <= 500, 3);
        assert!(arg14 != @0x0, 9);
        assert!(arg9 <= arg8, 14);
        assert!(0x2::balance::value<T1>(&arg2) == arg7 * arg8, 23);
        let v0 = get_timestamp(arg15);
        let v1 = Pool<T0, T1>{
            id                     : 0x2::object::new(arg16),
            balance_a              : arg1,
            balance_b              : arg2,
            trade_balance_a        : 0x2::balance::zero<T0>(),
            reward_balance_b       : arg3,
            lp_deposit             : arg4,
            pool_created           : v0,
            created_by             : arg5,
            block_price            : arg6,
            block_quantity         : arg7,
            blocks_sold            : 0,
            max_blocks             : arg8,
            buyback_limit          : arg9,
            close_deadline         : 0x1::option::none<u64>(),
            buyers                 : 0x2::table::new<address, bool>(arg16),
            lp_builder_fee         : arg10,
            burn_fee               : arg11,
            creator_royalty_fee    : arg12,
            rewards_fee            : arg13,
            creator_royalty_wallet : arg14,
            buyback_open           : true,
            sold_out               : false,
            pool_closed            : false,
        };
        let v2 = 0x2::object::id<Pool<T0, T1>>(&v1);
        add_pool<T0, T1>(arg0, v2);
        let v3 = LotusPoolCreated{
            pool_id                : v2,
            a                      : 0x1::type_name::get<T0>(),
            b                      : 0x1::type_name::get<T1>(),
            init_a                 : 0x2::balance::value<T0>(&v1.balance_a),
            init_b                 : 0x2::balance::value<T1>(&v1.balance_b),
            init_reward_b          : 0x2::balance::value<T1>(&v1.reward_balance_b),
            init_lp_b              : 0x2::balance::value<T1>(&v1.lp_deposit),
            pool_created           : v0,
            created_by             : arg5,
            block_price            : arg6,
            block_quantity         : arg7,
            max_blocks             : arg8,
            buyback_limit          : arg9,
            lp_builder_fee         : arg10,
            burn_fee               : arg11,
            creator_royalty_fee    : arg12,
            rewards_fee            : arg13,
            creator_royalty_wallet : arg14,
        };
        0x2::event::emit<LotusPoolCreated>(v3);
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
    }

    fun destroy_zero_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    public fun distribute_trade_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.trade_balance_a);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.trade_balance_a, v0), arg3), arg1.trade_fee_wallet);
            let v1 = TradeFeeDistributed{
                pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
                amount    : v0,
                timestamp : arg2,
            };
            0x2::event::emit<TradeFeeDistributed>(v1);
        };
    }

    fun get_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<PoolItem, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Factory>(v0);
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = Config{
            id               : 0x2::object::new(arg0),
            trade_fee        : 100,
            trade_fee_wallet : v1,
            admin            : v1,
            launch_manager   : v1,
        };
        0x2::transfer::share_object<Config>(v2);
        let v3 = CreatePoolLock{
            id        : 0x2::object::new(arg0),
            locked    : true,
            allowlist : 0x1::vector::singleton<address>(v1),
        };
        0x2::transfer::share_object<CreatePoolLock>(v3);
    }

    public entry fun new_lotus_pool<T0, T1>(arg0: &CreatePoolLock, arg1: &mut Factory, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: address, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 5);
        assert!(arg5 > 0, 5);
        let v0 = 0x2::tx_context::sender(arg17);
        assert!(!arg0.locked || 0x1::vector::contains<address>(&arg0.allowlist, &v0), 4);
        assert!(arg5 == arg8 * arg9 * 10, 23);
        let v1 = 0x2::coin::split<T1>(&mut arg4, arg5, arg17);
        let v2 = 0x2::coin::value<T1>(&v1);
        let v3 = v2 * 10 / 100;
        let v4 = v2 * 15 / 100;
        assert!(v3 > 0, 21);
        assert!(v4 > 0, 21);
        let v5 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg17));
        let v6 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, v3, arg17));
        let v7 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, v4, arg17));
        create_lotus_pool<T0, T1>(arg1, v5, v6, v7, 0x2::coin::into_balance<T1>(v1), arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        destroy_zero_or_transfer_balance<T0>(0x2::coin::into_balance<T0>(arg2), v0, arg17);
        destroy_zero_or_transfer_balance<T1>(0x2::coin::into_balance<T1>(arg4), v0, arg17);
    }

    public entry fun remove_from_allowlist(arg0: &mut CreatePoolLock, arg1: &Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 4);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.allowlist, &arg2);
        assert!(v0, 8);
        0x1::vector::swap_remove<address>(&mut arg0.allowlist, v1);
    }

    public entry fun sell_block<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.block_quantity;
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 >= v0, 22);
        let v2 = 0x2::tx_context::sender(arg4);
        if (v1 == v0) {
            let v3 = trade_b_for_a<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(arg2), arg3, arg4);
            destroy_zero_or_transfer_balance<T0>(v3, v2, arg4);
        } else {
            let v4 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v0, arg4));
            let v5 = trade_b_for_a<T0, T1>(arg0, arg1, v4, arg3, arg4);
            destroy_zero_or_transfer_balance<T1>(0x2::coin::into_balance<T1>(arg2), v2, arg4);
            destroy_zero_or_transfer_balance<T0>(v5, v2, arg4);
        };
    }

    public entry fun set_create_pool_lock(arg0: &mut CreatePoolLock, arg1: &Config, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 4);
        arg0.locked = arg2;
    }

    public entry fun set_pool_closed<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.launch_manager, 4);
        arg0.pool_closed = arg2;
    }

    public fun trade_a_for_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = get_timestamp(arg3);
        let v2 = false;
        let v3 = false;
        assert!(!arg0.sold_out, 11);
        assert!(!0x2::table::contains<address, bool>(&arg0.buyers, v0), 10);
        if (0x1::option::is_some<u64>(&arg0.close_deadline)) {
            if (v1 >= *0x1::option::borrow<u64>(&arg0.close_deadline)) {
                arg0.pool_closed = true;
                let v4 = PoolClosed{
                    pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
                    reason    : b"deadline_expired",
                    timestamp : v1,
                };
                0x2::event::emit<PoolClosed>(v4);
            };
        };
        assert!(!arg0.pool_closed, 12);
        assert!(arg0.blocks_sold < arg0.max_blocks, 11);
        let v5 = arg0.block_price;
        let (v6, v7) = compute_total_input(arg0.block_price, arg1.trade_fee);
        assert!(0x2::balance::value<T0>(&arg2) == v7, 19);
        assert!(0x2::balance::value<T1>(&arg0.balance_b) >= arg0.block_quantity, 20);
        0x2::balance::join<T0>(&mut arg0.balance_a, arg2);
        0x2::balance::join<T0>(&mut arg0.trade_balance_a, 0x2::balance::split<T0>(&mut arg2, v6));
        distribute_trade_fee<T0, T1>(arg0, arg1, v1, arg4);
        let v8 = arg0.block_quantity;
        arg0.blocks_sold = arg0.blocks_sold + 1;
        0x2::table::add<address, bool>(&mut arg0.buyers, v0, true);
        let v9 = v1 + 86400000;
        if (arg0.blocks_sold == arg0.buyback_limit && arg0.buyback_open) {
            arg0.buyback_open = false;
            arg0.close_deadline = 0x1::option::some<u64>(v9);
            v2 = true;
            let v10 = BuybackClosed{
                pool_id        : 0x2::object::id<Pool<T0, T1>>(arg0),
                blocks_sold    : arg0.blocks_sold,
                close_deadline : v9,
                timestamp      : v1,
            };
            0x2::event::emit<BuybackClosed>(v10);
        };
        let v11 = 0x1::option::none<u64>();
        if (v2) {
            v11 = 0x1::option::some<u64>(v9);
        };
        if (arg0.blocks_sold == arg0.max_blocks && !arg0.sold_out) {
            arg0.sold_out = true;
            v3 = true;
            let v12 = PoolSoldOut{
                pool_id      : 0x2::object::id<Pool<T0, T1>>(arg0),
                total_blocks : arg0.blocks_sold,
                timestamp    : v1,
            };
            0x2::event::emit<PoolSoldOut>(v12);
        };
        let v13 = Trade{
            pool_id        : 0x2::object::id<Pool<T0, T1>>(arg0),
            wallet         : v0,
            tokenin        : 0x1::type_name::get<T0>(),
            amountin       : v7,
            tokenout       : 0x1::type_name::get<T1>(),
            amountout      : v8,
            is_buy         : true,
            reserve_a      : 0x2::balance::value<T0>(&arg0.balance_a),
            reserve_b      : 0x2::balance::value<T1>(&arg0.balance_b),
            trade_fee      : v6,
            block_price    : v5,
            block_quantity : arg0.block_quantity,
            blocks_sold    : arg0.blocks_sold,
            buyback_closed : v2,
            pool_sold_out  : v3,
            close_deadline : v11,
            timestamp      : v1,
        };
        0x2::event::emit<Trade>(v13);
        0x2::balance::split<T1>(&mut arg0.balance_b, v8)
    }

    public fun trade_b_for_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = get_timestamp(arg3);
        assert!(!arg0.pool_closed, 12);
        assert!(arg0.buyback_open, 13);
        assert!(!arg0.sold_out, 11);
        let v2 = 0x2::balance::value<T1>(&arg2);
        assert!(v2 == arg0.block_quantity, 19);
        0x2::balance::join<T1>(&mut arg0.balance_b, arg2);
        let v3 = arg0.block_price;
        let (v4, _) = compute_total_input(v3, arg1.trade_fee);
        let v6 = v3 - v4;
        assert!(0x2::balance::value<T0>(&arg0.balance_a) >= v3, 20);
        let v7 = 0x2::balance::split<T0>(&mut arg0.balance_a, v6);
        0x2::balance::join<T0>(&mut arg0.trade_balance_a, 0x2::balance::split<T0>(&mut arg0.balance_a, v4));
        distribute_trade_fee<T0, T1>(arg0, arg1, v1, arg4);
        assert!(arg0.blocks_sold > 0, 19);
        arg0.blocks_sold = arg0.blocks_sold - 1;
        let v8 = Trade{
            pool_id        : 0x2::object::id<Pool<T0, T1>>(arg0),
            wallet         : v0,
            tokenin        : 0x1::type_name::get<T1>(),
            amountin       : v2,
            tokenout       : 0x1::type_name::get<T0>(),
            amountout      : v6,
            is_buy         : false,
            reserve_a      : 0x2::balance::value<T0>(&arg0.balance_a),
            reserve_b      : 0x2::balance::value<T1>(&arg0.balance_b),
            trade_fee      : v4,
            block_price    : v3,
            block_quantity : arg0.block_quantity,
            blocks_sold    : arg0.blocks_sold,
            buyback_closed : !arg0.buyback_open,
            pool_sold_out  : arg0.sold_out,
            close_deadline : arg0.close_deadline,
            timestamp      : v1,
        };
        0x2::event::emit<Trade>(v8);
        v7
    }

    public entry fun update_admin(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        arg0.admin = arg1;
    }

    public entry fun update_launch_manager(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        arg0.launch_manager = arg1;
    }

    public entry fun update_trade_fee(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        assert!(arg1 <= 100, 3);
        arg0.trade_fee = arg1;
    }

    public entry fun update_trade_fee_wallet(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        arg0.trade_fee_wallet = arg1;
    }

    public entry fun withdraw_balance_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.launch_manager, 4);
        destroy_zero_or_transfer_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, 0x2::balance::value<T0>(&arg0.balance_a)), arg1.launch_manager, arg2);
    }

    public entry fun withdraw_balance_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.launch_manager, 4);
        destroy_zero_or_transfer_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, 0x2::balance::value<T1>(&arg0.balance_b)), arg1.launch_manager, arg2);
    }

    public entry fun withdraw_lp_deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.launch_manager, 4);
        destroy_zero_or_transfer_balance<T1>(0x2::balance::split<T1>(&mut arg0.lp_deposit, 0x2::balance::value<T1>(&arg0.lp_deposit)), arg1.launch_manager, arg2);
    }

    public entry fun withdraw_rewards<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.launch_manager, 4);
        destroy_zero_or_transfer_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_balance_b, 0x2::balance::value<T1>(&arg0.reward_balance_b)), arg1.launch_manager, arg2);
    }

    public entry fun withdraw_trade_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.admin, 4);
        assert!(0x2::balance::value<T0>(&arg0.trade_balance_a) > 0, 6);
        destroy_zero_or_transfer_balance<T0>(0x2::balance::split<T0>(&mut arg0.trade_balance_a, 0x2::balance::value<T0>(&arg0.trade_balance_a)), arg1.trade_fee_wallet, arg2);
    }

    // decompiled from Move bytecode v6
}

