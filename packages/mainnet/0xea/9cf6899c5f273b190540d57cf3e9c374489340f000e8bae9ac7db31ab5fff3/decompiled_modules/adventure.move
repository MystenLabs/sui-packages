module 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::adventure {
    struct PlayAdventureEvent has copy, drop {
        player: address,
        stake_amount: u64,
        difficulty: u8,
    }

    struct PlayAdventureResult has copy, drop {
        player: address,
        adventure_id: 0x2::object::ID,
        battle_odds: u64,
        result: u64,
        bet_size: u64,
        bet_returned: u64,
    }

    struct EndAdventureEvent has copy, drop {
        player: address,
        bet_size: u64,
        locked_stake_amount: u64,
        unlocked_stake_amount: u64,
    }

    struct Adventure has key {
        id: 0x2::object::UID,
        game_battle: vector<u64>,
        payout_vector: vector<u64>,
        unlock_percentage: vector<u64>,
        start_stake_amount: u64,
        total_stake_amount: u64,
        locked_stake_amount: u64,
        unlocked_stake_amount: u64,
        is_active: bool,
    }

    struct AdventureSettings has store, key {
        id: 0x2::object::UID,
        easy_game: vector<u64>,
        easy_payout: vector<u64>,
        medium_game: vector<u64>,
        medium_payout: vector<u64>,
        hard_game: vector<u64>,
        hard_payout: vector<u64>,
        min_bet_percentage: u64,
        play_count: 0x2::table::Table<0x2::object::ID, u64>,
    }

    fun assert_and_increment_play_count(arg0: &mut AdventureSettings, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::x_up::XUP) {
        let v0 = 0x2::object::id<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::x_up::XUP>(arg1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.play_count, v0)) {
            let v1 = 0x2::table::remove<0x2::object::ID, u64>(&mut arg0.play_count, v0);
            if (v1 >= 5) {
                err_too_many_plays();
            };
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.play_count, v0, v1 + 1);
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.play_count, v0, 1);
        };
    }

    fun assert_is_active(arg0: &Adventure) {
        if (!arg0.is_active) {
            err_adventure_not_active();
        };
    }

    public fun end_adventure(arg0: Adventure, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: &mut 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::x_up::UPTreasury, arg3: &mut 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::x_up::XUP, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>> {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        let Adventure {
            id                    : v0,
            game_battle           : _,
            payout_vector         : _,
            unlock_percentage     : _,
            start_stake_amount    : v4,
            total_stake_amount    : _,
            locked_stake_amount   : v6,
            unlocked_stake_amount : v7,
            is_active             : _,
        } = arg0;
        0x2::object::delete(v0);
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::x_up::set_amount(arg3, 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::x_up::amount(arg3) + v6);
        let v9 = EndAdventureEvent{
            player                : 0x2::tx_context::sender(arg4),
            bet_size              : v4,
            locked_stake_amount   : v6,
            unlocked_stake_amount : v7,
        };
        0x2::event::emit<EndAdventureEvent>(v9);
        if (v7 > 0) {
            0x1::option::some<0x2::coin::Coin<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>>(0x2::coin::from_balance<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(0x2::balance::split<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::x_up::borrow_balance_mut(arg2), v7), arg4))
        } else {
            0x1::option::none<0x2::coin::Coin<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>>()
        }
    }

    fun err_adventure_not_active() {
        abort 3
    }

    fun err_invalid_difficulty() {
        abort 0
    }

    fun err_invalid_stake() {
        abort 1
    }

    fun err_not_enough_xup() {
        abort 4
    }

    fun err_too_many_plays() {
        abort 2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdventureSettings{
            id                 : 0x2::object::new(arg0),
            easy_game          : vector[52, 62, 62, 82, 82],
            easy_payout        : vector[200, 166, 166, 120, 120],
            medium_game        : vector[52, 52, 62, 62, 77],
            medium_payout      : vector[200, 200, 166, 166, 125],
            hard_game          : vector[52, 52, 52, 62, 62],
            hard_payout        : vector[200, 200, 200, 166, 166],
            min_bet_percentage : 25,
            play_count         : 0x2::table::new<0x2::object::ID, u64>(arg0),
        };
        0x2::transfer::public_share_object<AdventureSettings>(v0);
    }

    entry fun play_adventure(arg0: &mut Adventure, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_active(arg0);
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = 0x1::vector::pop_back<u64>(&mut arg0.game_battle);
        let v2 = 0x2::random::generate_u64_in_range(&mut v0, 1, 100);
        let v3 = if (v2 <= v1) {
            let v4 = arg0.total_stake_amount * 0x1::vector::pop_back<u64>(&mut arg0.payout_vector) / 100;
            let v5 = v4 * 0x1::vector::pop_back<u64>(&mut arg0.unlock_percentage) / 100;
            arg0.total_stake_amount = v4;
            arg0.locked_stake_amount = v4 - v5;
            arg0.unlocked_stake_amount = v5;
            v4
        } else {
            arg0.locked_stake_amount = 0;
            arg0.unlocked_stake_amount = 0;
            arg0.total_stake_amount = 0;
            arg0.is_active = false;
            0
        };
        let v6 = PlayAdventureResult{
            player       : 0x2::tx_context::sender(arg3),
            adventure_id : 0x2::object::id<Adventure>(arg0),
            battle_odds  : v1,
            result       : v2,
            bet_size     : arg0.total_stake_amount,
            bet_returned : v3,
        };
        0x2::event::emit<PlayAdventureResult>(v6);
    }

    public fun play_count(arg0: &AdventureSettings, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.play_count, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.play_count, arg1)
        } else {
            0
        }
    }

    public fun start_adventure(arg0: &mut AdventureSettings, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: &mut 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::x_up::XUP, arg3: u64, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        assert_and_increment_play_count(arg0, arg2);
        if (arg3 < 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::x_up::amount_unclaimed(arg2) * arg0.min_bet_percentage / 100) {
            err_invalid_stake();
        };
        let v0 = if (arg4 != 0) {
            if (arg4 != 1) {
                arg4 != 2
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            err_invalid_difficulty();
        };
        if (0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::x_up::amount_unclaimed(arg2) < arg3) {
            err_not_enough_xup();
        };
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::x_up::set_amount(arg2, 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::x_up::amount(arg2) - arg3);
        let v1 = if (arg4 == 0) {
            vector[52, 62, 62, 82, 82]
        } else if (arg4 == 1) {
            vector[52, 52, 62, 62, 77]
        } else {
            vector[52, 52, 52, 62, 62]
        };
        let v2 = if (arg4 == 0) {
            vector[200, 166, 166, 120, 120]
        } else if (arg4 == 1) {
            vector[200, 200, 166, 166, 125]
        } else {
            vector[200, 200, 200, 166, 166]
        };
        let v3 = Adventure{
            id                    : 0x2::object::new(arg5),
            game_battle           : v1,
            payout_vector         : v2,
            unlock_percentage     : vector[100, 10, 5, 2, 1],
            start_stake_amount    : arg3,
            total_stake_amount    : arg3,
            locked_stake_amount   : arg3,
            unlocked_stake_amount : 0,
            is_active             : true,
        };
        let v4 = PlayAdventureEvent{
            player       : 0x2::tx_context::sender(arg5),
            stake_amount : arg3,
            difficulty   : arg4,
        };
        0x2::event::emit<PlayAdventureEvent>(v4);
        0x2::transfer::transfer<Adventure>(v3, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

