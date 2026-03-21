module 0xcd7d6a3954c820a9cd2244b341fb7402575c8ff09a31d8409b0dca34ddaeb70d::game {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Platform has key {
        id: 0x2::object::UID,
        platform_fee_mist: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        whitelist: 0x2::table::Table<0x1::type_name::TypeName, bool>,
    }

    struct GamePool<phantom T0> has key {
        id: 0x2::object::UID,
        prize_pool: 0x2::balance::Balance<T0>,
        creator: address,
        entry_fee: u64,
        creator_fee_pct: u64,
        burn_rate_pct: u64,
        lucky_draw_pct: u64,
        end_time: u64,
        last_player: address,
        claimed: bool,
        unique_player_count: u64,
        players: 0x2::table::Table<u64, address>,
        player_registered: 0x2::table::Table<address, bool>,
    }

    struct CoinWhitelisted has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct CoinRemovedFromWhitelist has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct PlatformFeeUpdated has copy, drop {
        new_fee_mist: u64,
    }

    struct PlatformFeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct GameCreated has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        creator: address,
        entry_fee: u64,
        creator_fee_pct: u64,
        burn_rate_pct: u64,
        lucky_draw_pct: u64,
        end_time: u64,
        initial_prize: u64,
    }

    struct PlayerJoined has copy, drop {
        pool_id: 0x2::object::ID,
        player: address,
        end_time: u64,
        prize_pool: u64,
    }

    struct GameFinished has copy, drop {
        pool_id: 0x2::object::ID,
        winner: address,
        prize: u64,
        lucky_winner: address,
        lucky_prize: u64,
    }

    public entry fun join<T0>(arg0: &mut GamePool<T0>, arg1: &mut Platform, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.claimed, 7);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.end_time, 5);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg0.entry_fee, 8);
        if (v0 > arg0.entry_fee) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v0 - arg0.entry_fee, arg5), 0x2::tx_context::sender(arg5));
        };
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= arg1.platform_fee_mist, 9);
        if (v1 > arg1.platform_fee_mist) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1 - arg1.platform_fee_mist, arg5), 0x2::tx_context::sender(arg5));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        if (arg0.burn_rate_pct > 0) {
            let v2 = (((arg0.entry_fee as u128) * (arg0.burn_rate_pct as u128) / 100) as u64);
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v2, arg5), @0x0);
            };
        };
        if (arg0.creator_fee_pct > 0) {
            let v3 = (((arg0.entry_fee as u128) * (arg0.creator_fee_pct as u128) / 100) as u64);
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v3, arg5), arg0.creator);
            };
        };
        0x2::balance::join<T0>(&mut arg0.prize_pool, 0x2::coin::into_balance<T0>(arg2));
        let v4 = 0x2::tx_context::sender(arg5);
        if (!0x2::table::contains<address, bool>(&arg0.player_registered, v4)) {
            0x2::table::add<address, bool>(&mut arg0.player_registered, v4, true);
            0x2::table::add<u64, address>(&mut arg0.players, arg0.unique_player_count, v4);
            arg0.unique_player_count = arg0.unique_player_count + 1;
        };
        arg0.last_player = v4;
        arg0.end_time = arg0.end_time + 1000;
        let v5 = PlayerJoined{
            pool_id    : 0x2::object::id<GamePool<T0>>(arg0),
            player     : v4,
            end_time   : arg0.end_time,
            prize_pool : 0x2::balance::value<T0>(&arg0.prize_pool),
        };
        0x2::event::emit<PlayerJoined>(v5);
    }

    public entry fun add_to_whitelist<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, bool>(&arg1.whitelist, v0)) {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg1.whitelist, v0, true);
            let v1 = CoinWhitelisted{coin_type: v0};
            0x2::event::emit<CoinWhitelisted>(v1);
        };
    }

    public fun burn_rate_pct<T0>(arg0: &GamePool<T0>) : u64 {
        arg0.burn_rate_pct
    }

    public entry fun claim<T0>(arg0: &mut GamePool<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.claimed, 7);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time, 6);
        assert!(0x2::tx_context::sender(arg3) == arg0.last_player, 13);
        arg0.claimed = true;
        let v0 = 0x2::balance::value<T0>(&arg0.prize_pool);
        let v1 = arg0.last_player;
        let v2 = if (arg0.lucky_draw_pct > 0) {
            if (arg0.unique_player_count > 0) {
                v0 > 0
            } else {
                false
            }
        } else {
            false
        };
        let (v3, v4) = if (v2) {
            let v5 = (((v0 as u128) * (arg0.lucky_draw_pct as u128) / 100) as u64);
            if (v5 > 0) {
                let v6 = 0x2::random::new_generator(arg1, arg3);
                let v7 = *0x2::table::borrow<u64, address>(&arg0.players, 0x2::random::generate_u64_in_range(&mut v6, 0, arg0.unique_player_count - 1));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pool, v5), arg3), v7);
                (v7, v5)
            } else {
                (@0x0, 0)
            }
        } else {
            (@0x0, 0)
        };
        let v8 = 0x2::balance::value<T0>(&arg0.prize_pool);
        let v9 = GameFinished{
            pool_id      : 0x2::object::id<GamePool<T0>>(arg0),
            winner       : v1,
            prize        : v8,
            lucky_winner : v3,
            lucky_prize  : v4,
        };
        0x2::event::emit<GameFinished>(v9);
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.prize_pool), arg3), v1);
        };
    }

    public entry fun create_game<T0>(arg0: &Platform, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.whitelist, 0x1::type_name::get<T0>()), 0);
        assert!(arg1 > 0, 11);
        assert!(0x2::coin::value<T0>(&arg6) > 0, 1);
        assert!(arg2 <= 20, 2);
        assert!(arg3 <= 20, 3);
        assert!(arg4 <= 10, 12);
        assert!(arg5 >= 1 && arg5 <= 10000, 4);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = GamePool<T0>{
            id                  : 0x2::object::new(arg8),
            prize_pool          : 0x2::coin::into_balance<T0>(arg6),
            creator             : v0,
            entry_fee           : arg1,
            creator_fee_pct     : arg2,
            burn_rate_pct       : arg3,
            lucky_draw_pct      : arg4,
            end_time            : 0x2::clock::timestamp_ms(arg7) + arg5 * 3600000,
            last_player         : v0,
            claimed             : false,
            unique_player_count : 0,
            players             : 0x2::table::new<u64, address>(arg8),
            player_registered   : 0x2::table::new<address, bool>(arg8),
        };
        let v2 = GameCreated{
            pool_id         : 0x2::object::id<GamePool<T0>>(&v1),
            coin_type       : 0x1::type_name::get<T0>(),
            creator         : v0,
            entry_fee       : arg1,
            creator_fee_pct : arg2,
            burn_rate_pct   : arg3,
            lucky_draw_pct  : arg4,
            end_time        : v1.end_time,
            initial_prize   : 0x2::coin::value<T0>(&arg6),
        };
        0x2::event::emit<GameCreated>(v2);
        0x2::transfer::share_object<GamePool<T0>>(v1);
    }

    public fun creator<T0>(arg0: &GamePool<T0>) : address {
        arg0.creator
    }

    public fun creator_fee_pct<T0>(arg0: &GamePool<T0>) : u64 {
        arg0.creator_fee_pct
    }

    public fun end_time<T0>(arg0: &GamePool<T0>) : u64 {
        arg0.end_time
    }

    public fun entry_fee<T0>(arg0: &GamePool<T0>) : u64 {
        arg0.entry_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Platform{
            id                : 0x2::object::new(arg0),
            platform_fee_mist : 10000000,
            treasury          : 0x2::balance::zero<0x2::sui::SUI>(),
            whitelist         : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
        };
        0x2::transfer::share_object<Platform>(v1);
    }

    public fun is_active<T0>(arg0: &GamePool<T0>, arg1: &0x2::clock::Clock) : bool {
        !arg0.claimed && 0x2::clock::timestamp_ms(arg1) < arg0.end_time
    }

    public fun is_claimed<T0>(arg0: &GamePool<T0>) : bool {
        arg0.claimed
    }

    public fun is_whitelisted<T0>(arg0: &Platform) : bool {
        0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.whitelist, 0x1::type_name::get<T0>())
    }

    public fun last_player<T0>(arg0: &GamePool<T0>) : address {
        arg0.last_player
    }

    public fun lucky_draw_pct<T0>(arg0: &GamePool<T0>) : u64 {
        arg0.lucky_draw_pct
    }

    public fun platform_fee(arg0: &Platform) : u64 {
        arg0.platform_fee_mist
    }

    public fun prize_pool_size<T0>(arg0: &GamePool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.prize_pool)
    }

    public entry fun remove_from_whitelist<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg1.whitelist, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg1.whitelist, v0);
            let v1 = CoinRemovedFromWhitelist{coin_type: v0};
            0x2::event::emit<CoinRemovedFromWhitelist>(v1);
        };
    }

    public entry fun set_platform_fee(arg0: &AdminCap, arg1: &mut Platform, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.platform_fee_mist = arg2;
        let v0 = PlatformFeeUpdated{new_fee_mist: arg2};
        0x2::event::emit<PlatformFeeUpdated>(v0);
    }

    public fun time_remaining_ms<T0>(arg0: &GamePool<T0>, arg1: &0x2::clock::Clock) : u64 {
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

    public fun unique_player_count<T0>(arg0: &GamePool<T0>) : u64 {
        arg0.unique_player_count
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

