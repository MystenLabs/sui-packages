module 0x7e34d466b6f4464fd20722cd955f4b34e730cff1c5d06cf5b64e47e7b601ddda::deathroll {
    struct GameObj has store, key {
        id: 0x2::object::UID,
        dev: address,
        fee: u16,
        map: 0x2::table::Table<address, BattleObj>,
        results: vector<ResultObj>,
        currentgames: vector<BattleInfo>,
    }

    struct BattleObj has store, key {
        id: 0x2::object::UID,
        stake: 0x2::coin::Coin<0x2::sui::SUI>,
        game_index: u64,
    }

    struct BattleInfo has copy, drop, store {
        id: address,
        stake: u64,
        game_index: u64,
    }

    struct ResultObj has store, key {
        id: 0x2::object::UID,
        stake: u64,
        winner: address,
        loser: address,
        game_data: vector<u8>,
        game_index: u64,
        game: BattleObj,
    }

    struct Roll has copy, drop {
        id: address,
        isDefendersTurn: bool,
        value: u8,
    }

    struct Outcome has copy, drop {
        winner: address,
        loser: address,
        game_data: vector<u8>,
    }

    struct FightingCapability has key {
        id: 0x2::object::UID,
    }

    fun remove(arg0: &mut GameObj, arg1: address) : BattleObj {
        0x2::table::remove<address, BattleObj>(&mut arg0.map, arg1)
    }

    fun add(arg0: &mut GameObj, arg1: address, arg2: BattleObj) {
        0x2::table::add<address, BattleObj>(&mut arg0.map, arg1, arg2);
    }

    public fun contains(arg0: &GameObj, arg1: address) : bool {
        0x2::table::contains<address, BattleObj>(&arg0.map, arg1)
    }

    public entry fun Accept_Battle(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut GameObj, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(contains(arg2, arg0), 4);
        let v1 = Start_Battle(arg2, arg1, v0, arg0, arg3, arg4);
        let v2 = get_results(arg2);
        let v3 = Outcome{
            winner    : v1.winner,
            loser     : v1.loser,
            game_data : v1.game_data,
        };
        0x2::event::emit<Outcome>(v3);
        0x1::vector::push_back<ResultObj>(v2, v1);
        0x1::vector::remove<BattleInfo>(get_games(arg2), v1.game_index - 1);
    }

    public entry fun Cancel_Battle(arg0: &mut GameObj, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(contains(arg0, v0), 4);
        let v1 = remove(arg0, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v1.stake), 0x2::coin::value<0x2::sui::SUI>(&v1.stake), arg1), v0);
        let v2 = get_games(arg0);
        0x1::vector::remove<BattleInfo>(v2, v1.game_index - 1);
        let v3 = ResultObj{
            id         : 0x2::object::new(arg1),
            stake      : 0,
            winner     : @0x0,
            loser      : v0,
            game_data  : 0x1::vector::empty<u8>(),
            game_index : 0,
            game       : v1,
        };
        let v4 = Outcome{
            winner    : v3.winner,
            loser     : v3.loser,
            game_data : v3.game_data,
        };
        0x2::event::emit<Outcome>(v4);
        0x1::vector::push_back<ResultObj>(get_results(arg0), v3);
    }

    public entry fun Create_Battle(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut GameObj, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::balance<0x2::sui::SUI>(&arg0);
        assert!(0x2::balance::value<0x2::sui::SUI>(v1) > 0, 1);
        assert!(!contains(arg1, v0), 2);
        let v2 = 0x1::vector::length<BattleInfo>(get_current_games(arg1));
        let v3 = BattleInfo{
            id         : 0x2::tx_context::sender(arg2),
            stake      : 0x2::balance::value<0x2::sui::SUI>(v1),
            game_index : v2 + 1,
        };
        let v4 = BattleObj{
            id         : 0x2::object::new(arg2),
            stake      : arg0,
            game_index : v2 + 1,
        };
        add(arg1, v0, v4);
        0x1::vector::push_back<BattleInfo>(get_games(arg1), v3);
    }

    fun Start_Battle(arg0: &mut GameObj, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: address, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) : ResultObj {
        let v0 = remove(arg0, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 0x2::coin::value<0x2::sui::SUI>(&v0.stake), 3);
        0x2::coin::join<0x2::sui::SUI>(&mut v0.stake, arg1);
        let v1 = 0;
        let v2 = 1;
        let v3 = false;
        while (v1 != v2) {
            v1 = roll_dice(arg4, arg5, 100);
            v2 = roll_dice(arg4, arg5, 100);
            if (v1 > v2) {
                v3 = true;
            };
        };
        let v4 = 0x1::vector::empty<u8>();
        let v5 = roll_dice(arg4, arg5, 100);
        0x1::vector::push_back<u8>(&mut v4, v5);
        let v6 = Roll{
            id              : arg3,
            isDefendersTurn : v3,
            value           : v5,
        };
        0x2::event::emit<Roll>(v6);
        while (v5 != 1) {
            let v7 = !v3;
            v3 = v7;
            let v8 = roll_dice(arg4, arg5, v5);
            v5 = v8;
            0x1::vector::push_back<u8>(&mut v4, v8);
            let v9 = Roll{
                id              : arg3,
                isDefendersTurn : v7,
                value           : v8,
            };
            0x2::event::emit<Roll>(v9);
        };
        let v10 = 0x2::coin::value<0x2::sui::SUI>(&v0.stake);
        let (v11, v12) = if (!v3) {
            (arg2, arg3)
        } else {
            (arg3, arg2)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0.stake, fee_amount(v10, 500), arg5), @0xefc4b16a7359dad679a3fac16146f04ae9abba9756033d7a18a24b9f19cb3c96);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v0.stake), 0x2::coin::value<0x2::sui::SUI>(&v0.stake), arg5), v12);
        ResultObj{
            id         : 0x2::object::new(arg5),
            stake      : v10,
            winner     : v12,
            loser      : v11,
            game_data  : v4,
            game_index : v0.game_index,
            game       : v0,
        }
    }

    public fun fee_amount(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun get_current_games(arg0: &GameObj) : &vector<BattleInfo> {
        &arg0.currentgames
    }

    public fun get_finished_games(arg0: &GameObj) : &vector<ResultObj> {
        &arg0.results
    }

    fun get_games(arg0: &mut GameObj) : &mut vector<BattleInfo> {
        &mut arg0.currentgames
    }

    fun get_results(arg0: &mut GameObj) : &mut vector<ResultObj> {
        &mut arg0.results
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameObj{
            id           : 0x2::object::new(arg0),
            dev          : @0xefc4b16a7359dad679a3fac16146f04ae9abba9756033d7a18a24b9f19cb3c96,
            fee          : 500,
            map          : 0x2::table::new<address, BattleObj>(arg0),
            results      : 0x1::vector::empty<ResultObj>(),
            currentgames : 0x1::vector::empty<BattleInfo>(),
        };
        0x2::transfer::public_share_object<GameObj>(v0);
    }

    fun roll_dice(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext, arg2: u8) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u8_in_range(&mut v0, 1, arg2)
    }

    // decompiled from Move bytecode v6
}

