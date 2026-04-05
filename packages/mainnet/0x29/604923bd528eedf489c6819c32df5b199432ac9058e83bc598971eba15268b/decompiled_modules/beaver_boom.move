module 0x29604923bd528eedf489c6819c32df5b199432ac9058e83bc598971eba15268b::beaver_boom {
    struct BeaverGame has key {
        id: 0x2::object::UID,
        round_id: u64,
        pool: 0x2::balance::Balance<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>,
        last_feeder: 0x1::option::Option<address>,
        total_feeds: u64,
        min_feed: u64,
    }

    struct GameAdmin has key {
        id: 0x2::object::UID,
    }

    struct Fed has copy, drop {
        round_id: u64,
        feeder: address,
        paid: u64,
        pool_after: u64,
        total_feeds: u64,
        boom_chance_bps: u64,
        roll: u64,
    }

    struct Boom has copy, drop {
        round_id: u64,
        winner: address,
        prize: u64,
        feeds_in_round: u64,
    }

    struct PoolSeeded has copy, drop {
        amount: u64,
        pool_after: u64,
        from: address,
    }

    fun boom_chance_bps(arg0: u64, arg1: u64) : u64 {
        0x1::u64::min(9800, (((stake_boom_bps(arg0) as u128) * (feed_multiplier_fp(arg1) as u128) / (1000000 as u128)) as u64))
    }

    entry fun feed(arg0: &mut BeaverGame, arg1: 0x2::coin::Coin<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>, arg2: &0x2::random::Random, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>(&arg1);
        assert!(v0 >= arg0.min_feed, 1);
        assert!(v0 >= 100000000, 4);
        assert!(v0 <= 100000000000, 4);
        assert!(arg0.round_id == arg3, 3);
        0x2::balance::join<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>(&mut arg0.pool, 0x2::coin::into_balance<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>(arg1));
        arg0.total_feeds = arg0.total_feeds + 1;
        let v1 = 0x2::balance::value<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>(&arg0.pool);
        let v2 = boom_chance_bps(v0, arg0.total_feeds);
        let v3 = 0x2::random::new_generator(arg2, arg4);
        let v4 = 0x2::random::generate_u64_in_range(&mut v3, 0, 10000 - 1);
        if (v4 < v2) {
            assert!(v1 > 0, 2);
            let v5 = 0x2::tx_context::sender(arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>>(0x2::coin::take<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>(&mut arg0.pool, v1, arg4), v5);
            arg0.total_feeds = 0;
            arg0.last_feeder = 0x1::option::none<address>();
            arg0.round_id = arg0.round_id + 1;
            let v6 = Boom{
                round_id       : arg0.round_id,
                winner         : v5,
                prize          : v1,
                feeds_in_round : arg0.total_feeds,
            };
            0x2::event::emit<Boom>(v6);
        } else {
            arg0.last_feeder = 0x1::option::some<address>(0x2::tx_context::sender(arg4));
            let v7 = Fed{
                round_id        : arg0.round_id,
                feeder          : 0x2::tx_context::sender(arg4),
                paid            : v0,
                pool_after      : v1,
                total_feeds     : arg0.total_feeds,
                boom_chance_bps : v2,
                roll            : v4,
            };
            0x2::event::emit<Fed>(v7);
        };
    }

    fun feed_multiplier_fp(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 1000000
        };
        if (arg0 <= 100) {
            return 1001000 + ((99000 * ((arg0 - 1) as u128) / 99) as u64)
        };
        if (arg0 <= 1000) {
            return 1100000 + ((400000 * ((arg0 - 100) as u128) / 900) as u64)
        };
        1500000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BeaverGame{
            id          : 0x2::object::new(arg0),
            round_id    : 0,
            pool        : 0x2::balance::zero<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>(),
            last_feeder : 0x1::option::none<address>(),
            total_feeds : 0,
            min_feed    : 100000000,
        };
        0x2::transfer::share_object<BeaverGame>(v0);
        let v1 = GameAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GameAdmin>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun last_feeder(arg0: &BeaverGame) : 0x1::option::Option<address> {
        arg0.last_feeder
    }

    public fun min_feed(arg0: &BeaverGame) : u64 {
        arg0.min_feed
    }

    public fun pool_amount(arg0: &BeaverGame) : u64 {
        0x2::balance::value<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>(&arg0.pool)
    }

    public fun preview_boom_bps_for(arg0: &BeaverGame, arg1: u64, arg2: u64) : u64 {
        boom_chance_bps(arg1, arg2)
    }

    public fun round_id(arg0: &BeaverGame) : u64 {
        arg0.round_id
    }

    entry fun seed_pool(arg0: &GameAdmin, arg1: &mut BeaverGame, arg2: 0x2::coin::Coin<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>(&arg2);
        assert!(v0 > 0, 5);
        0x2::balance::join<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>(&mut arg1.pool, 0x2::coin::into_balance<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>(arg2));
        let v1 = PoolSeeded{
            amount     : v0,
            pool_after : 0x2::balance::value<0x17a1b338d630b30ed19c7a893f973db25bb0f7c9d4c8bdf2fc3ccb414fbaa9a6::bvs::BVS>(&arg1.pool),
            from       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PoolSeeded>(v1);
    }

    entry fun set_min_feed(arg0: &GameAdmin, arg1: &mut BeaverGame, arg2: u64) {
        arg1.min_feed = arg2;
    }

    fun stake_boom_bps(arg0: u64) : u64 {
        let v0 = ((100000000000 - 100000000) as u128);
        50 + ((((1500 - 50) as u128) * (0x1::u128::sqrt(((arg0 - 100000000) as u128) * v0) as u128) / v0) as u64)
    }

    public fun stake_range_max() : u64 {
        100000000000
    }

    public fun stake_range_min() : u64 {
        100000000
    }

    public fun total_feeds(arg0: &BeaverGame) : u64 {
        arg0.total_feeds
    }

    entry fun transfer_game_admin(arg0: GameAdmin, arg1: address) {
        0x2::transfer::transfer<GameAdmin>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

