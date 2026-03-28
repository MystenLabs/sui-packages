module 0x8df58b8cf7467b8f8f914fb3aaa475bb3b7568ed0fca8a2246fb685e78831949::lottery {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Platform has key {
        id: 0x2::object::UID,
        platform_fee_mist: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct LotteryPool<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        entry_fee: u64,
        creator_royalty_pct: u64,
        end_time: u64,
        prize_pool: 0x2::balance::Balance<T0>,
        first_pct: u64,
        second_pct: u64,
        third_pct: u64,
        player_count: u64,
        players: 0x2::table::Table<u64, address>,
        player_registered: 0x2::table::Table<address, bool>,
        drawn: bool,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        creator: address,
        entry_fee: u64,
        creator_royalty_pct: u64,
        end_time: u64,
        initial_prize: u64,
        first_pct: u64,
        second_pct: u64,
        third_pct: u64,
    }

    struct PlayerJoined has copy, drop {
        pool_id: 0x2::object::ID,
        player: address,
        player_index: u64,
        prize_pool: u64,
        player_count: u64,
    }

    struct LotteryDrawn has copy, drop {
        pool_id: 0x2::object::ID,
        total_pool: u64,
        creator_royalty: u64,
        first_winner: address,
        first_prize: u64,
        second_winners: vector<address>,
        second_prize_each: u64,
        third_winners: vector<address>,
        third_prize_each: u64,
        precision_remainder: u64,
    }

    struct PoolCancelled has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        refund: u64,
    }

    struct PlatformFeeUpdated has copy, drop {
        new_fee_mist: u64,
    }

    struct PlatformFeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    public entry fun join<T0>(arg0: &mut LotteryPool<T0>, arg1: &mut Platform, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.drawn, 6);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.end_time, 4);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<address, bool>(&arg0.player_registered, v0), 7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= arg1.platform_fee_mist, 9);
        if (v1 > arg1.platform_fee_mist) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1 - arg1.platform_fee_mist, arg5), v0);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        if (arg0.entry_fee > 0) {
            let v2 = 0x2::coin::value<T0>(&arg2);
            assert!(v2 >= arg0.entry_fee, 8);
            if (v2 > arg0.entry_fee) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v2 - arg0.entry_fee, arg5), v0);
            };
            0x2::balance::join<T0>(&mut arg0.prize_pool, 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        };
        let v3 = arg0.player_count;
        0x2::table::add<u64, address>(&mut arg0.players, v3, v0);
        0x2::table::add<address, bool>(&mut arg0.player_registered, v0, true);
        arg0.player_count = v3 + 1;
        let v4 = PlayerJoined{
            pool_id      : 0x2::object::id<LotteryPool<T0>>(arg0),
            player       : v0,
            player_index : v3,
            prize_pool   : 0x2::balance::value<T0>(&arg0.prize_pool),
            player_count : arg0.player_count,
        };
        0x2::event::emit<PlayerJoined>(v4);
    }

    public entry fun cancel_empty_pool<T0>(arg0: &mut LotteryPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 11);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 5);
        assert!(arg0.player_count == 0, 14);
        assert!(!arg0.drawn, 6);
        arg0.drawn = true;
        let v0 = 0x2::balance::value<T0>(&arg0.prize_pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.prize_pool), arg2), arg0.creator);
        };
        let v1 = PoolCancelled{
            pool_id : 0x2::object::id<LotteryPool<T0>>(arg0),
            creator : arg0.creator,
            refund  : v0,
        };
        0x2::event::emit<PoolCancelled>(v1);
    }

    fun contains_u64(arg0: &vector<u64>, arg1: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun create_pool<T0>(arg0: &0xcd7d6a3954c820a9cd2244b341fb7402575c8ff09a31d8409b0dca34ddaeb70d::game::Platform, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xcd7d6a3954c820a9cd2244b341fb7402575c8ff09a31d8409b0dca34ddaeb70d::game::is_whitelisted<T0>(arg0), 0);
        assert!(arg2 <= 10, 1);
        assert!(arg3 >= 1 && arg3 <= 10000, 2);
        let v0 = if (arg4 + arg5 + arg6 == 100) {
            if (arg4 > 0) {
                if (arg5 > 0) {
                    arg6 > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = 0x2::clock::timestamp_ms(arg8) + arg3 * 3600000;
        let v3 = LotteryPool<T0>{
            id                  : 0x2::object::new(arg9),
            creator             : v1,
            entry_fee           : arg1,
            creator_royalty_pct : arg2,
            end_time            : v2,
            prize_pool          : 0x2::coin::into_balance<T0>(arg7),
            first_pct           : arg4,
            second_pct          : arg5,
            third_pct           : arg6,
            player_count        : 0,
            players             : 0x2::table::new<u64, address>(arg9),
            player_registered   : 0x2::table::new<address, bool>(arg9),
            drawn               : false,
        };
        let v4 = PoolCreated{
            pool_id             : 0x2::object::id<LotteryPool<T0>>(&v3),
            coin_type           : 0x1::type_name::get<T0>(),
            creator             : v1,
            entry_fee           : arg1,
            creator_royalty_pct : arg2,
            end_time            : v2,
            initial_prize       : 0x2::coin::value<T0>(&arg7),
            first_pct           : arg4,
            second_pct          : arg5,
            third_pct           : arg6,
        };
        0x2::event::emit<PoolCreated>(v4);
        0x2::transfer::share_object<LotteryPool<T0>>(v3);
    }

    public fun creator<T0>(arg0: &LotteryPool<T0>) : address {
        arg0.creator
    }

    fun do_draw<T0>(arg0: &mut LotteryPool<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.drawn, 6);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time, 5);
        let v0 = arg0.player_count;
        assert!(v0 > 0, 13);
        arg0.drawn = true;
        let v1 = arg0.creator;
        let v2 = 0x2::balance::value<T0>(&arg0.prize_pool);
        let v3 = (((v2 as u128) * (arg0.creator_royalty_pct as u128) / 100) as u64);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pool, v3), arg3), v1);
        };
        let v4 = 0x2::balance::value<T0>(&arg0.prize_pool);
        let v5 = 0x2::random::new_generator(arg1, arg3);
        if (v0 < 6) {
            let v6 = *0x2::table::borrow<u64, address>(&arg0.players, 0x2::random::generate_u64_in_range(&mut v5, 0, v0 - 1));
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.prize_pool), arg3), v6);
            };
            let v7 = LotteryDrawn{
                pool_id             : 0x2::object::id<LotteryPool<T0>>(arg0),
                total_pool          : v2,
                creator_royalty     : v3,
                first_winner        : v6,
                first_prize         : v4,
                second_winners      : 0x1::vector::empty<address>(),
                second_prize_each   : 0,
                third_winners       : 0x1::vector::empty<address>(),
                third_prize_each    : 0,
                precision_remainder : 0,
            };
            0x2::event::emit<LotteryDrawn>(v7);
        } else {
            let v8 = 0x1::vector::empty<u64>();
            let v9 = 0;
            while (0x1::vector::length<u64>(&v8) < 6) {
                assert!(v9 < 100, 15);
                let v10 = 0x2::random::generate_u64_in_range(&mut v5, 0, v0 - 1);
                if (!contains_u64(&v8, v10)) {
                    0x1::vector::push_back<u64>(&mut v8, v10);
                };
                v9 = v9 + 1;
            };
            let v11 = *0x2::table::borrow<u64, address>(&arg0.players, *0x1::vector::borrow<u64>(&v8, 0));
            let v12 = *0x2::table::borrow<u64, address>(&arg0.players, *0x1::vector::borrow<u64>(&v8, 1));
            let v13 = *0x2::table::borrow<u64, address>(&arg0.players, *0x1::vector::borrow<u64>(&v8, 2));
            let v14 = *0x2::table::borrow<u64, address>(&arg0.players, *0x1::vector::borrow<u64>(&v8, 3));
            let v15 = *0x2::table::borrow<u64, address>(&arg0.players, *0x1::vector::borrow<u64>(&v8, 4));
            let v16 = *0x2::table::borrow<u64, address>(&arg0.players, *0x1::vector::borrow<u64>(&v8, 5));
            let v17 = (((v4 as u128) * (arg0.first_pct as u128) / 100) as u64);
            let v18 = (((v4 as u128) * (arg0.second_pct as u128) / 100 / 2) as u64);
            let v19 = (((v4 as u128) * (arg0.third_pct as u128) / 100 / 3) as u64);
            let v20 = v4 - v17 - v18 * 2 - v19 * 3;
            if (v19 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pool, v19), arg3), v14);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pool, v19), arg3), v15);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pool, v19), arg3), v16);
            };
            if (v18 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pool, v18), arg3), v12);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pool, v18), arg3), v13);
            };
            if (v17 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pool, v17), arg3), v11);
            };
            if (v20 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.prize_pool), arg3), v1);
            };
            let v21 = 0x1::vector::empty<address>();
            let v22 = &mut v21;
            0x1::vector::push_back<address>(v22, v12);
            0x1::vector::push_back<address>(v22, v13);
            let v23 = 0x1::vector::empty<address>();
            let v24 = &mut v23;
            0x1::vector::push_back<address>(v24, v14);
            0x1::vector::push_back<address>(v24, v15);
            0x1::vector::push_back<address>(v24, v16);
            let v25 = LotteryDrawn{
                pool_id             : 0x2::object::id<LotteryPool<T0>>(arg0),
                total_pool          : v2,
                creator_royalty     : v3,
                first_winner        : v11,
                first_prize         : v17,
                second_winners      : v21,
                second_prize_each   : v18,
                third_winners       : v23,
                third_prize_each    : v19,
                precision_remainder : v20,
            };
            0x2::event::emit<LotteryDrawn>(v25);
        };
    }

    public entry fun draw<T0>(arg0: &mut LotteryPool<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_draw<T0>(arg0, arg1, arg2, arg3);
    }

    public fun end_time<T0>(arg0: &LotteryPool<T0>) : u64 {
        arg0.end_time
    }

    public fun entry_fee<T0>(arg0: &LotteryPool<T0>) : u64 {
        arg0.entry_fee
    }

    public fun first_pct<T0>(arg0: &LotteryPool<T0>) : u64 {
        arg0.first_pct
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Platform{
            id                : 0x2::object::new(arg0),
            platform_fee_mist : 10000000,
            treasury          : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Platform>(v1);
    }

    public fun is_active<T0>(arg0: &LotteryPool<T0>, arg1: &0x2::clock::Clock) : bool {
        !arg0.drawn && 0x2::clock::timestamp_ms(arg1) < arg0.end_time
    }

    public fun is_drawn<T0>(arg0: &LotteryPool<T0>) : bool {
        arg0.drawn
    }

    public fun is_player<T0>(arg0: &LotteryPool<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.player_registered, arg1)
    }

    public fun platform_fee(arg0: &Platform) : u64 {
        arg0.platform_fee_mist
    }

    public fun player_count<T0>(arg0: &LotteryPool<T0>) : u64 {
        arg0.player_count
    }

    public fun prize_pool_value<T0>(arg0: &LotteryPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.prize_pool)
    }

    public fun royalty_pct<T0>(arg0: &LotteryPool<T0>) : u64 {
        arg0.creator_royalty_pct
    }

    public fun second_pct<T0>(arg0: &LotteryPool<T0>) : u64 {
        arg0.second_pct
    }

    public entry fun set_platform_fee(arg0: &AdminCap, arg1: &mut Platform, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 12);
        arg1.platform_fee_mist = arg2;
        let v0 = PlatformFeeUpdated{new_fee_mist: arg2};
        0x2::event::emit<PlatformFeeUpdated>(v0);
    }

    public fun third_pct<T0>(arg0: &LotteryPool<T0>) : u64 {
        arg0.third_pct
    }

    public fun time_remaining_ms<T0>(arg0: &LotteryPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.end_time) {
            0
        } else {
            arg0.end_time - v0
        }
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun treasury_balance(arg0: &Platform) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public entry fun withdraw_platform_fees(arg0: &AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.treasury);
        assert!(v0 > 0, 10);
        let v1 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.treasury), arg2), v1);
        let v2 = PlatformFeesWithdrawn{
            amount    : v0,
            recipient : v1,
        };
        0x2::event::emit<PlatformFeesWithdrawn>(v2);
    }

    // decompiled from Move bytecode v6
}

