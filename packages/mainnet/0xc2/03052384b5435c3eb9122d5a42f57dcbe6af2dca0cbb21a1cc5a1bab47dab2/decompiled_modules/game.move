module 0xc203052384b5435c3eb9122d5a42f57dcbe6af2dca0cbb21a1cc5a1bab47dab2::game {
    struct GamePool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>,
        last_player: address,
        end_time: u64,
        claimed: bool,
    }

    struct BurnVault has key {
        id: 0x2::object::UID,
        total_burned: 0x2::balance::Balance<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>,
    }

    struct GameCreated has copy, drop {
        pool_id: 0x2::object::ID,
        seed_amount: u64,
        end_time: u64,
    }

    struct PlayerJoined has copy, drop {
        pool_id: 0x2::object::ID,
        player: address,
        end_time: u64,
        pool_size: u64,
    }

    struct GameFinished has copy, drop {
        pool_id: 0x2::object::ID,
        winner: address,
        winner_prize: u64,
        burned: u64,
    }

    public entry fun join(arg0: &mut GamePool, arg1: 0x2::coin::Coin<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(!arg0.claimed, 2);
        assert!(v0 < arg0.end_time, 0);
        let v1 = 0x2::coin::value<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(&arg1);
        assert!(v1 >= 100000000000, 3);
        if (v1 > 100000000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>>(0x2::coin::split<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(&mut arg1, v1 - 100000000000, arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::balance::join<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(&mut arg0.balance, 0x2::coin::into_balance<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(arg1));
        arg0.last_player = 0x2::tx_context::sender(arg3);
        arg0.end_time = v0 + 86400000;
        let v2 = PlayerJoined{
            pool_id   : 0x2::object::id<GamePool>(arg0),
            player    : 0x2::tx_context::sender(arg3),
            end_time  : arg0.end_time,
            pool_size : 0x2::balance::value<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(&arg0.balance),
        };
        0x2::event::emit<PlayerJoined>(v2);
    }

    public entry fun claim(arg0: &mut GamePool, arg1: &mut BurnVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.claimed, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time, 1);
        arg0.claimed = true;
        let v0 = 0x2::balance::value<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(&arg0.balance);
        let v1 = v0 / 2;
        let v2 = v0 - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>>(0x2::coin::from_balance<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(0x2::balance::split<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(&mut arg0.balance, v1), arg3), arg0.last_player);
        0x2::balance::join<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(&mut arg1.total_burned, 0x2::balance::split<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(&mut arg0.balance, v2));
        let v3 = GameFinished{
            pool_id      : 0x2::object::id<GamePool>(arg0),
            winner       : arg0.last_player,
            winner_prize : v1,
            burned       : v2,
        };
        0x2::event::emit<GameFinished>(v3);
    }

    public entry fun create_game(arg0: 0x2::coin::Coin<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1) + 86400000;
        let v1 = GamePool{
            id          : 0x2::object::new(arg2),
            balance     : 0x2::coin::into_balance<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(arg0),
            last_player : 0x2::tx_context::sender(arg2),
            end_time    : v0,
            claimed     : false,
        };
        let v2 = GameCreated{
            pool_id     : 0x2::object::id<GamePool>(&v1),
            seed_amount : 0x2::coin::value<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(&arg0),
            end_time    : v0,
        };
        0x2::event::emit<GameCreated>(v2);
        0x2::transfer::share_object<GamePool>(v1);
    }

    public fun end_time(arg0: &GamePool) : u64 {
        arg0.end_time
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnVault{
            id           : 0x2::object::new(arg0),
            total_burned : 0x2::balance::zero<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(),
        };
        0x2::transfer::share_object<BurnVault>(v0);
    }

    public fun is_active(arg0: &GamePool, arg1: &0x2::clock::Clock) : bool {
        !arg0.claimed && 0x2::clock::timestamp_ms(arg1) < arg0.end_time
    }

    public fun last_player(arg0: &GamePool) : address {
        arg0.last_player
    }

    public fun pool_size(arg0: &GamePool) : u64 {
        0x2::balance::value<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(&arg0.balance)
    }

    public fun time_remaining_ms(arg0: &GamePool, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.end_time) {
            0
        } else {
            arg0.end_time - v0
        }
    }

    public fun total_burned(arg0: &BurnVault) : u64 {
        0x2::balance::value<0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo::FOMO>(&arg0.total_burned)
    }

    // decompiled from Move bytecode v6
}

