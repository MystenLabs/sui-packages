module 0xae6df1b582798ca25cf8271151b328b7fd239bff5d38af3743cfd7de2c5e99e3::slot_machine {
    struct SlotOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    struct Winner has store {
        winner: address,
        amount: u64,
    }

    struct Winners has key {
        id: 0x2::object::UID,
        winners: vector<Winner>,
    }

    struct Turn has store, key {
        id: 0x2::object::UID,
        turns_allowed: u64,
        seed1: u64,
        seed2: u64,
        seed3: u64,
        slot1: u64,
        slot2: u64,
        slot3: u64,
        slot4: u64,
        slot5: u64,
        slot6: u64,
    }

    struct SlotMachine has key {
        id: 0x2::object::UID,
        seed1: u64,
        seed2: u64,
        seed3: u64,
        total_jackpot: 0x2::balance::Balance<0x2::sui::SUI>,
        fee: u64,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        win_percent: u64,
        mist_price_for_turn: u64,
        max_mist_for_buy: u64,
        difficulty: u64,
        turn_count: u64,
        last_jackpot: bool,
    }

    public fun burn_turn(arg0: Turn, arg1: &mut 0x2::tx_context::TxContext) {
        let Turn {
            id            : v0,
            turns_allowed : _,
            seed1         : _,
            seed2         : _,
            seed3         : _,
            slot1         : _,
            slot2         : _,
            slot3         : _,
            slot4         : _,
            slot5         : _,
            slot6         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun buy_turn(arg0: &mut SlotMachine, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.mist_price_for_turn, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) <= arg0.max_mist_for_buy, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg1);
        let v1 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg1);
        let v2 = 0x2::balance::split<0x2::sui::SUI>(v1, v0 - v0 * arg0.fee / 100);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_jackpot, v2);
        let v3 = randomSeed(arg3);
        let v4 = randomSeed(arg3);
        let v5 = Turn{
            id            : 0x2::object::new(arg3),
            turns_allowed : 0x2::balance::value<0x2::sui::SUI>(&v2) / arg0.mist_price_for_turn + 1,
            seed1         : 0x2::clock::timestamp_ms(arg2),
            seed2         : v3,
            seed3         : v4,
            slot1         : 0,
            slot2         : 0,
            slot3         : 0,
            slot4         : 0,
            slot5         : 0,
            slot6         : 0,
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::balance::withdraw_all<0x2::sui::SUI>(v1));
        0x2::transfer::transfer<Turn>(v5, 0x2::tx_context::sender(arg3));
    }

    public fun change_difficulty(arg0: &SlotOwnerCap, arg1: &mut SlotMachine, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.difficulty = arg2;
    }

    public fun change_fee(arg0: &SlotOwnerCap, arg1: &mut SlotMachine, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fee = arg2;
    }

    public fun change_last_game(arg0: &SlotOwnerCap, arg1: &mut SlotMachine, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.last_jackpot = arg2;
    }

    public fun change_max(arg0: &SlotOwnerCap, arg1: &mut SlotMachine, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.max_mist_for_buy = arg2;
    }

    public fun change_price(arg0: &SlotOwnerCap, arg1: &mut SlotMachine, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.mist_price_for_turn = arg2;
    }

    public fun change_win_percent(arg0: &SlotOwnerCap, arg1: &mut SlotMachine, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.win_percent = arg2;
    }

    public fun execute_turn(arg0: &mut Turn, arg1: &mut SlotMachine, arg2: &mut Winners, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.turns_allowed > 0, 2);
        arg0.turns_allowed = arg0.turns_allowed - 1;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.total_jackpot);
        let v1 = v0 * arg1.win_percent / 100;
        if (arg1.last_jackpot == true) {
            v1 = v0 * 100 / 100;
        };
        let v2 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.total_jackpot);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.total_jackpot, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.total_jackpot, v1));
        let v3 = randomSeed(arg4);
        let v4 = randomSeed(arg4);
        update_existing_seeds(arg0, arg1, 0x2::clock::timestamp_ms(arg3), v3, v4);
        let v5 = spin_and_check(arg0, arg1);
        if (v5 == true) {
            let v6 = Winner{
                winner : 0x2::tx_context::sender(arg4),
                amount : 0x2::balance::value<0x2::sui::SUI>(&v2),
            };
            0x1::vector::push_back<Winner>(&mut arg2.winners, v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg4), 0x2::tx_context::sender(arg4));
            arg1.turn_count = 0;
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.total_jackpot, v2);
        };
    }

    public fun fill_turn(arg0: &mut Turn, arg1: &mut SlotMachine, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.turns_allowed == 0, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg1.mist_price_for_turn, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) <= arg1.max_mist_for_buy, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg2);
        let v1 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg2);
        let v2 = 0x2::balance::split<0x2::sui::SUI>(v1, v0 - v0 * arg1.fee / 100);
        let v3 = 0x2::balance::withdraw_all<0x2::sui::SUI>(v1);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.total_jackpot, v2);
        0x1::debug::print<u64>(&v0);
        0x1::debug::print<u64>(&v4);
        0x1::debug::print<u64>(&v5);
        let v6 = v5 / arg1.mist_price_for_turn + 1;
        0x1::debug::print<u64>(&v6);
        arg0.turns_allowed = v6;
        let v7 = randomSeed(arg4);
        arg0.seed1 = 0x2::clock::timestamp_ms(arg3);
        arg0.seed2 = v7;
        arg0.seed3 = randomSeed(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fee_balance, v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SlotMachine{
            id                  : 0x2::object::new(arg0),
            seed1               : 0,
            seed2               : 0,
            seed3               : 0,
            total_jackpot       : 0x2::balance::zero<0x2::sui::SUI>(),
            fee                 : 5,
            fee_balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            win_percent         : 50,
            mist_price_for_turn : 500000000,
            max_mist_for_buy    : 50000000000,
            difficulty          : 5,
            turn_count          : 0,
            last_jackpot        : false,
        };
        let v1 = SlotOwnerCap{id: 0x2::object::new(arg0)};
        let v2 = TreasuryCap{id: 0x2::object::new(arg0)};
        let v3 = Winners{
            id      : 0x2::object::new(arg0),
            winners : 0x1::vector::empty<Winner>(),
        };
        0x1::debug::print<SlotMachine>(&v0);
        0x2::transfer::share_object<SlotMachine>(v0);
        0x2::transfer::share_object<Winners>(v3);
        0x2::transfer::transfer<SlotOwnerCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<TreasuryCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun kecc_to_u64(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        loop {
            v0 = v0 + (*0x1::vector::borrow<u8>(arg0, v1) as u64);
            v1 = v1 + 1;
            if (v1 == 0x1::vector::length<u8>(arg0)) {
                break
            };
        };
        v0
    }

    fun randomSeed(arg0: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        let v2 = 0;
        let v3 = 0;
        loop {
            v2 = v2 + (*0x1::vector::borrow<u8>(&v1, v3) as u64);
            v3 = v3 + 1;
            if (v3 == 0x1::vector::length<u8>(&v1)) {
                break
            };
        };
        0x2::object::delete(v0);
        v2
    }

    public fun spin_and_check(arg0: &mut Turn, arg1: &mut SlotMachine) : bool {
        let v0 = arg1.difficulty;
        arg0.slot1 = arg0.slot1 % v0 + 1;
        arg0.slot2 = arg0.slot2 % v0 + 1;
        arg0.slot3 = arg0.slot3 % v0 + 1;
        arg0.slot4 = arg0.slot4 % v0 + 1;
        arg0.slot5 = arg0.slot5 % v0 + 1;
        arg0.slot6 = arg0.slot6 % v0 + 1;
        arg0.slot1 == arg0.slot2 && arg0.slot2 == arg0.slot3 && arg0.slot3 == arg0.slot4 && arg0.slot4 == arg0.slot5 && arg0.slot5 == arg0.slot6
    }

    public fun transfer_slot_owner(arg0: SlotOwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SlotOwnerCap>(arg0, arg1);
    }

    public fun transfer_treasury(arg0: TreasuryCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<TreasuryCap>(arg0, arg1);
    }

    public fun update_existing_seeds(arg0: &mut Turn, arg1: &mut SlotMachine, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = arg0.seed1 + arg1.seed1 + arg2;
        let v1 = arg0.seed2 + arg1.seed2 + arg3;
        let v2 = arg0.seed3 + arg1.seed3 + arg4;
        let v3 = arg1.seed1 + arg2 + arg0.seed3;
        let v4 = arg1.seed2 + arg3 + arg0.seed2;
        let v5 = arg1.seed3 + arg4 + arg0.seed1;
        let v6 = 0x1::bcs::to_bytes<u64>(&v0);
        let v7 = 0x2::hash::keccak256(&v6);
        arg0.seed1 = kecc_to_u64(&v7);
        arg0.slot1 = arg0.seed1;
        let v8 = 0x1::bcs::to_bytes<u64>(&v1);
        let v9 = 0x2::hash::keccak256(&v8);
        arg0.seed2 = kecc_to_u64(&v9);
        arg0.slot2 = arg0.seed2;
        let v10 = 0x1::bcs::to_bytes<u64>(&v2);
        let v11 = 0x2::hash::keccak256(&v10);
        arg0.seed3 = kecc_to_u64(&v11);
        arg0.slot3 = arg0.seed3;
        let v12 = 0x1::bcs::to_bytes<u64>(&v3);
        let v13 = 0x2::hash::keccak256(&v12);
        arg1.seed1 = kecc_to_u64(&v13);
        arg0.slot4 = arg1.seed1;
        let v14 = 0x1::bcs::to_bytes<u64>(&v4);
        let v15 = 0x2::hash::keccak256(&v14);
        arg1.seed2 = kecc_to_u64(&v15);
        arg0.slot5 = arg1.seed2;
        let v16 = 0x1::bcs::to_bytes<u64>(&v5);
        let v17 = 0x2::hash::keccak256(&v16);
        arg1.seed3 = kecc_to_u64(&v17);
        arg0.slot6 = arg1.seed3;
        arg1.turn_count = arg1.turn_count + 1;
    }

    public fun withdraw_fee(arg0: &TreasuryCap, arg1: &mut SlotMachine, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.fee_balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

