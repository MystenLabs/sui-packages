module 0xf82157a989de9ffbb7a1f0fd9a8bed90c56d180b24db88e8312f6b736090e151::deathroll {
    struct GameObj has store, key {
        id: 0x2::object::UID,
        dev: address,
        fee: u16,
        map: 0x2::table::Table<address, 0x2::coin::Coin<0x2::sui::SUI>>,
        currentgames: 0x2::vec_set::VecSet<BattleInfo>,
    }

    struct BattleInfo has copy, drop, store {
        id: address,
        stake: u64,
    }

    struct ResultObj has copy, drop {
        stake: u64,
        winner: address,
        loser: address,
        game_data: vector<u8>,
    }

    struct Roll has copy, drop {
        id: address,
        isDefendersTurn: bool,
        value: u8,
    }

    struct InitialRoll has copy, drop {
        attacker: address,
        attacker_roll: u8,
        defender: address,
        defender_roll: u8,
    }

    struct Outcome has copy, drop {
        winner: address,
        loser: address,
        game_data: vector<u8>,
        stake: u64,
    }

    fun add(arg0: &mut GameObj, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::table::add<address, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.map, arg1, arg2);
    }

    public fun contains(arg0: &GameObj, arg1: address) : bool {
        0x2::table::contains<address, 0x2::coin::Coin<0x2::sui::SUI>>(&arg0.map, arg1)
    }

    fun remove(arg0: &mut GameObj, arg1: address) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::table::remove<address, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.map, arg1)
    }

    fun Start_Battle(arg0: &mut GameObj, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: address, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) : ResultObj {
        let v0 = remove(arg0, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 0x2::coin::value<0x2::sui::SUI>(&v0), 3);
        0x2::coin::join<0x2::sui::SUI>(&mut v0, arg1);
        let v1 = roll_dice(arg4, arg5, 100);
        let v2 = roll_dice(arg4, arg5, 100);
        let v3 = false;
        let v4 = InitialRoll{
            attacker      : arg2,
            attacker_roll : v2,
            defender      : arg3,
            defender_roll : v1,
        };
        0x2::event::emit<InitialRoll>(v4);
        if (v1 > v2) {
            v3 = true;
        };
        while (v1 == v2) {
            let v5 = InitialRoll{
                attacker      : arg2,
                attacker_roll : v2,
                defender      : arg3,
                defender_roll : v1,
            };
            0x2::event::emit<InitialRoll>(v5);
            if (v1 > v2) {
                v3 = true;
            };
            v1 = roll_dice(arg4, arg5, 100);
            v2 = roll_dice(arg4, arg5, 100);
        };
        let v6 = 0x1::vector::empty<u8>();
        let v7 = roll_dice(arg4, arg5, 100);
        0x1::vector::push_back<u8>(&mut v6, v7);
        let v8 = if (v3) {
            arg3
        } else {
            arg2
        };
        let v9 = Roll{
            id              : v8,
            isDefendersTurn : v3,
            value           : v7,
        };
        0x2::event::emit<Roll>(v9);
        while (v7 != 1) {
            let v10 = !v3;
            v3 = v10;
            let v11 = roll_dice(arg4, arg5, v7);
            v7 = v11;
            0x1::vector::push_back<u8>(&mut v6, v11);
            if (v10) {
                v8 = arg3;
            } else {
                v8 = arg2;
            };
            let v12 = Roll{
                id              : v8,
                isDefendersTurn : v10,
                value           : v11,
            };
            0x2::event::emit<Roll>(v12);
        };
        let v13 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let (v14, v15) = if (!v3) {
            (arg2, arg3)
        } else {
            (arg3, arg2)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0), arg5), v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, fee_amount(v13, 100), arg5), @0xefc4b16a7359dad679a3fac16146f04ae9abba9756033d7a18a24b9f19cb3c96);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        ResultObj{
            stake     : v13,
            winner    : v15,
            loser     : v14,
            game_data : v6,
        }
    }

    public entry fun SuiRoll_Cancel_Battle(arg0: &mut GameObj, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(contains(arg0, v0), 4);
        let v1 = remove(arg0, v0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v1), v2, arg1), v0);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        let v3 = BattleInfo{
            id    : v0,
            stake : v2,
        };
        0x2::vec_set::remove<BattleInfo>(get_games(arg0), &v3);
        let v4 = Outcome{
            winner    : @0x0,
            loser     : v0,
            game_data : 0x1::vector::empty<u8>(),
            stake     : 0,
        };
        0x2::event::emit<Outcome>(v4);
    }

    public entry fun SuiRoll_Complete_Battle(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut GameObj, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(contains(arg2, arg0), 4);
        let v2 = Start_Battle(arg2, arg1, v0, arg0, arg3, arg4);
        let v3 = Outcome{
            winner    : v2.winner,
            loser     : v2.loser,
            game_data : v2.game_data,
            stake     : v1,
        };
        0x2::event::emit<Outcome>(v3);
        let v4 = BattleInfo{
            id    : arg0,
            stake : v1,
        };
        0x2::vec_set::remove<BattleInfo>(get_games(arg2), &v4);
    }

    public entry fun SuiRoll_Create_Battle(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut GameObj, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 1);
        assert!(!contains(arg1, v0), 2);
        let v1 = BattleInfo{
            id    : v0,
            stake : 0x2::coin::value<0x2::sui::SUI>(&arg0),
        };
        add(arg1, v0, arg0);
        0x2::vec_set::insert<BattleInfo>(get_games(arg1), v1);
    }

    public fun fee_amount(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun get_current_games(arg0: &GameObj) : &0x2::vec_set::VecSet<BattleInfo> {
        &arg0.currentgames
    }

    fun get_games(arg0: &mut GameObj) : &mut 0x2::vec_set::VecSet<BattleInfo> {
        &mut arg0.currentgames
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameObj{
            id           : 0x2::object::new(arg0),
            dev          : @0xefc4b16a7359dad679a3fac16146f04ae9abba9756033d7a18a24b9f19cb3c96,
            fee          : 100,
            map          : 0x2::table::new<address, 0x2::coin::Coin<0x2::sui::SUI>>(arg0),
            currentgames : 0x2::vec_set::empty<BattleInfo>(),
        };
        0x2::transfer::public_share_object<GameObj>(v0);
    }

    fun roll_dice(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext, arg2: u8) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u8_in_range(&mut v0, 1, arg2)
    }

    // decompiled from Move bytecode v6
}

