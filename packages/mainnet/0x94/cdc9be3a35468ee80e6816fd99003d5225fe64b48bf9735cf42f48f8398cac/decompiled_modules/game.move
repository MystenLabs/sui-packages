module 0x94cdc9be3a35468ee80e6816fd99003d5225fe64b48bf9735cf42f48f8398cac::game {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct GamePool has key {
        id: 0x2::object::UID,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        last_player: address,
        end_time: u64,
        claimed: bool,
    }

    struct GameCreated has copy, drop {
        pool_id: 0x2::object::ID,
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
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    public entry fun join(arg0: &mut GamePool, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.claimed, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.end_time, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= 100000000, 3);
        if (v0 > 100000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0 - 100000000, arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 20000000, arg4)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.last_player = 0x2::tx_context::sender(arg4);
        arg0.end_time = arg0.end_time + 1000;
        let v1 = PlayerJoined{
            pool_id    : 0x2::object::id<GamePool>(arg0),
            player     : 0x2::tx_context::sender(arg4),
            end_time   : arg0.end_time,
            prize_pool : 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<PlayerJoined>(v1);
    }

    public entry fun claim(arg0: &mut GamePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.claimed, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 1);
        arg0.claimed = true;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        let v1 = arg0.last_player;
        let v2 = GameFinished{
            pool_id : 0x2::object::id<GamePool>(arg0),
            winner  : v1,
            prize   : v0,
        };
        0x2::event::emit<GameFinished>(v2);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.prize_pool), arg2), v1);
        };
    }

    public entry fun create_game(arg0: &AdminCap, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 5);
        let v0 = GamePool{
            id          : 0x2::object::new(arg4),
            prize_pool  : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            last_player : 0x2::tx_context::sender(arg4),
            end_time    : 0x2::clock::timestamp_ms(arg3) + arg1,
            claimed     : false,
        };
        let v1 = GameCreated{
            pool_id       : 0x2::object::id<GamePool>(&v0),
            end_time      : v0.end_time,
            initial_prize : 0x2::coin::value<0x2::sui::SUI>(&arg2),
        };
        0x2::event::emit<GameCreated>(v1);
        0x2::transfer::share_object<GamePool>(v0);
    }

    public fun end_time(arg0: &GamePool) : u64 {
        arg0.end_time
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v1);
    }

    public fun is_active(arg0: &GamePool, arg1: &0x2::clock::Clock) : bool {
        !arg0.claimed && 0x2::clock::timestamp_ms(arg1) < arg0.end_time
    }

    public fun last_player(arg0: &GamePool) : address {
        arg0.last_player
    }

    public fun prize_pool_size(arg0: &GamePool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun time_remaining_ms(arg0: &GamePool, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.end_time) {
            0
        } else {
            arg0.end_time - v0
        }
    }

    public fun treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v0 > 0, 4);
        let v1 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg2), v1);
        let v2 = FeesWithdrawn{
            amount    : v0,
            recipient : v1,
        };
        0x2::event::emit<FeesWithdrawn>(v2);
    }

    // decompiled from Move bytecode v6
}

