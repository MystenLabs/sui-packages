module 0x1c0940117508312a08229995cdf37804fbe6fcc3e12ce29510cf6d411e2fa3d2::suimon_staking {
    struct GameRoomCreated has copy, drop {
        game_id: 0x2::object::ID,
        creator: address,
        stake_amount: u64,
    }

    struct GameRoomJoined has copy, drop {
        game_id: 0x2::object::ID,
        opponent: address,
    }

    struct GameFinished has copy, drop {
        game_id: 0x2::object::ID,
        winner: address,
        winner_reward: u64,
        platform_fee: u64,
    }

    struct GameDisputed has copy, drop {
        game_id: 0x2::object::ID,
        disputer: address,
        timestamp: u64,
    }

    struct GameRefunded has copy, drop {
        game_id: 0x2::object::ID,
        creator_refund: u64,
        opponent_refund: u64,
    }

    struct ContractPaused has copy, drop {
        admin: address,
        timestamp: u64,
    }

    struct ContractUnpaused has copy, drop {
        admin: address,
        timestamp: u64,
    }

    struct AdminChanged has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct FeeChanged has copy, drop {
        old_fee: u64,
        new_fee: u64,
        admin: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ContractState<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        is_paused: bool,
        platform_fee_percentage: u64,
        total_games_created: u64,
        total_volume: u64,
        emergency_fund: 0x2::balance::Balance<T0>,
    }

    struct GameRoom<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        total_stake: 0x2::balance::Balance<T0>,
        opponent: 0x1::option::Option<address>,
        stake_amount: u64,
        status: u8,
        winner: 0x1::option::Option<address>,
        created_at: u64,
        dispute_timestamp: 0x1::option::Option<u64>,
    }

    public entry fun admin_refund_game<T0>(arg0: &AdminCap, arg1: &ContractState<T0>, arg2: &mut GameRoom<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1, arg3);
        assert!(arg2.status == 1 || arg2.status == 3, 2);
        let v0 = arg2.stake_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.total_stake, v0), arg3), arg2.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.total_stake, v0), arg3), *0x1::option::borrow<address>(&arg2.opponent));
        arg2.status = 4;
        let v1 = GameRefunded{
            game_id         : 0x2::object::uid_to_inner(&arg2.id),
            creator_refund  : v0,
            opponent_refund : v0,
        };
        0x2::event::emit<GameRefunded>(v1);
    }

    public entry fun admin_resolve_dispute<T0>(arg0: &AdminCap, arg1: &ContractState<T0>, arg2: &mut GameRoom<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1, arg4);
        assert!(arg2.status == 3, 2);
        assert!(arg3 == arg2.creator || arg3 == *0x1::option::borrow<address>(&arg2.opponent), 3);
        let v0 = arg2.stake_amount * 2;
        let v1 = v0 * arg1.platform_fee_percentage / 100;
        let v2 = v0 - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.total_stake, v2), arg4), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.total_stake, v1), arg4), @0x8b541447ab4c498a4414f83275c0091866c6641f51cecde7f9aebf1c75a60759);
        arg2.status = 2;
        0x1::option::fill<address>(&mut arg2.winner, arg3);
        let v3 = GameFinished{
            game_id       : 0x2::object::uid_to_inner(&arg2.id),
            winner        : arg3,
            winner_reward : v2,
            platform_fee  : v1,
        };
        0x2::event::emit<GameFinished>(v3);
    }

    fun assert_admin<T0>(arg0: &AdminCap, arg1: &ContractState<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.admin, 6);
    }

    fun assert_not_paused<T0>(arg0: &ContractState<T0>) {
        assert!(!arg0.is_paused, 7);
    }

    public entry fun change_admin<T0>(arg0: &AdminCap, arg1: &mut ContractState<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1, arg3);
        arg1.admin = arg2;
        let v0 = AdminChanged{
            old_admin : arg1.admin,
            new_admin : arg2,
        };
        0x2::event::emit<AdminChanged>(v0);
    }

    public entry fun change_platform_fee<T0>(arg0: &AdminCap, arg1: &mut ContractState<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1, arg3);
        assert!(arg2 <= 50, 10);
        arg1.platform_fee_percentage = arg2;
        let v0 = FeeChanged{
            old_fee : arg1.platform_fee_percentage,
            new_fee : arg2,
            admin   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeChanged>(v0);
    }

    public entry fun create_game<T0>(arg0: &mut ContractState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 5);
        let v1 = GameRoom<T0>{
            id                : 0x2::object::new(arg3),
            creator           : 0x2::tx_context::sender(arg3),
            total_stake       : 0x2::coin::into_balance<T0>(arg1),
            opponent          : 0x1::option::none<address>(),
            stake_amount      : v0,
            status            : 0,
            winner            : 0x1::option::none<address>(),
            created_at        : 0x2::clock::timestamp_ms(arg2),
            dispute_timestamp : 0x1::option::none<u64>(),
        };
        arg0.total_games_created = arg0.total_games_created + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v2 = GameRoomCreated{
            game_id      : 0x2::object::uid_to_inner(&v1.id),
            creator      : 0x2::tx_context::sender(arg3),
            stake_amount : v0,
        };
        0x2::event::emit<GameRoomCreated>(v2);
        0x2::transfer::share_object<GameRoom<T0>>(v1);
    }

    public entry fun dispute_game<T0>(arg0: &mut GameRoom<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.creator || v0 == *0x1::option::borrow<address>(&arg0.opponent), 3);
        arg0.status = 3;
        0x1::option::fill<u64>(&mut arg0.dispute_timestamp, 0x2::clock::timestamp_ms(arg1));
        let v1 = GameDisputed{
            game_id   : 0x2::object::uid_to_inner(&arg0.id),
            disputer  : v0,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<GameDisputed>(v1);
    }

    public entry fun emergency_withdraw<T0>(arg0: &AdminCap, arg1: &mut ContractState<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.emergency_fund, arg2), arg3), arg1.admin);
    }

    public entry fun finish_game<T0>(arg0: &mut ContractState<T0>, arg1: &mut GameRoom<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T0>(arg0);
        assert!(arg1.status == 1, 2);
        assert!(arg1.status != 2, 8);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = *0x1::option::borrow<address>(&arg1.opponent);
        assert!(v0 == arg1.creator || v0 == v1, 6);
        assert!(arg2 == arg1.creator || arg2 == v1, 3);
        let v2 = arg1.stake_amount * 2;
        let v3 = v2 * arg0.platform_fee_percentage / 100;
        let v4 = v2 - v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.total_stake, v4), arg3), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.total_stake, v3), arg3), @0x8b541447ab4c498a4414f83275c0091866c6641f51cecde7f9aebf1c75a60759);
        arg1.status = 2;
        0x1::option::fill<address>(&mut arg1.winner, arg2);
        let v5 = GameFinished{
            game_id       : 0x2::object::uid_to_inner(&arg1.id),
            winner        : arg2,
            winner_reward : v4,
            platform_fee  : v3,
        };
        0x2::event::emit<GameFinished>(v5);
    }

    public fun get_contract_admin<T0>(arg0: &ContractState<T0>) : address {
        arg0.admin
    }

    public fun get_created_at<T0>(arg0: &GameRoom<T0>) : u64 {
        arg0.created_at
    }

    public fun get_creator<T0>(arg0: &GameRoom<T0>) : address {
        arg0.creator
    }

    public fun get_game_status<T0>(arg0: &GameRoom<T0>) : u8 {
        arg0.status
    }

    public fun get_opponent<T0>(arg0: &GameRoom<T0>) : 0x1::option::Option<address> {
        arg0.opponent
    }

    public fun get_platform_fee_percentage<T0>(arg0: &ContractState<T0>) : u64 {
        arg0.platform_fee_percentage
    }

    public fun get_stake_amount<T0>(arg0: &GameRoom<T0>) : u64 {
        arg0.stake_amount
    }

    public fun get_total_games_created<T0>(arg0: &ContractState<T0>) : u64 {
        arg0.total_games_created
    }

    public fun get_total_stake_value<T0>(arg0: &GameRoom<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_stake)
    }

    public fun get_total_volume<T0>(arg0: &ContractState<T0>) : u64 {
        arg0.total_volume
    }

    public fun get_winner<T0>(arg0: &GameRoom<T0>) : 0x1::option::Option<address> {
        arg0.winner
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_contract<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ContractState<T0>{
            id                      : 0x2::object::new(arg1),
            admin                   : 0x2::tx_context::sender(arg1),
            is_paused               : false,
            platform_fee_percentage : 10,
            total_games_created     : 0,
            total_volume            : 0,
            emergency_fund          : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<ContractState<T0>>(v0);
    }

    public fun is_contract_paused<T0>(arg0: &ContractState<T0>) : bool {
        arg0.is_paused
    }

    public entry fun join_game<T0>(arg0: &mut ContractState<T0>, arg1: &mut GameRoom<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T0>(arg0);
        assert!(arg1.status == 0, 1);
        assert!(0x2::coin::value<T0>(&arg2) == arg1.stake_amount, 5);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 != arg1.creator, 3);
        0x1::option::fill<address>(&mut arg1.opponent, v0);
        0x2::balance::join<T0>(&mut arg1.total_stake, 0x2::coin::into_balance<T0>(arg2));
        arg1.status = 1;
        arg0.total_volume = arg0.total_volume + arg1.stake_amount;
        let v1 = GameRoomJoined{
            game_id  : 0x2::object::uid_to_inner(&arg1.id),
            opponent : v0,
        };
        0x2::event::emit<GameRoomJoined>(v1);
    }

    public entry fun pause_contract<T0>(arg0: &AdminCap, arg1: &mut ContractState<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1, arg3);
        arg1.is_paused = true;
        let v0 = ContractPaused{
            admin     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ContractPaused>(v0);
    }

    public entry fun unpause_contract<T0>(arg0: &AdminCap, arg1: &mut ContractState<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1, arg3);
        arg1.is_paused = false;
        let v0 = ContractUnpaused{
            admin     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ContractUnpaused>(v0);
    }

    // decompiled from Move bytecode v6
}

