module 0xf5ed75abb7d627c9f58e6761f0a9c1c3c219472324e2e9554ab2d7c5f9834aab::sbbbs {
    struct BetCommitment has store, key {
        id: 0x2::object::UID,
        player: address,
        commitment_hash: vector<u8>,
        bet_amount: u64,
        bet_type: u8,
        bet_value: u64,
        locked_amount: u64,
        committed_at: u64,
        is_revealed: bool,
    }

    struct GameRecord has copy, drop, store {
        player: address,
        bet_amount: u64,
        bet_type: u8,
        bet_value: u64,
        dice_values: vector<u64>,
        total_points: u64,
        is_win: bool,
        payout: u64,
        timestamp: u64,
    }

    struct DiceGameContract has store, key {
        id: 0x2::object::UID,
        banker: address,
        contract_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_locked_balance: u64,
        game_records: vector<GameRecord>,
        total_games: u64,
        total_payout: u64,
        min_reveal_delay: u64,
        max_reveal_timeout: u64,
    }

    struct CommitmentCreatedEvent has copy, drop {
        commitment_id: address,
        player: address,
        bet_amount: u64,
        timestamp: u64,
    }

    struct GamePlayedEvent has copy, drop {
        player: address,
        bet_amount: u64,
        bet_type: u8,
        bet_value: u64,
        dice_values: vector<u64>,
        total_points: u64,
        is_win: bool,
        payout: u64,
        timestamp: u64,
    }

    struct DepositEvent has copy, drop {
        banker: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        banker: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct BankerChangedEvent has copy, drop {
        old_banker: address,
        new_banker: address,
        deposit_amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    public entry fun become_new_banker(arg0: &mut DiceGameContract, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.contract_balance) == 0, 109);
        assert!(arg0.total_locked_balance == 0, 110);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000000000, 111);
        let v1 = 0x2::tx_context::sender(arg3);
        arg0.banker = v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.contract_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = BankerChangedEvent{
            old_banker     : arg0.banker,
            new_banker     : v1,
            deposit_amount : v0,
            new_balance    : 0x2::balance::value<0x2::sui::SUI>(&arg0.contract_balance),
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BankerChangedEvent>(v2);
    }

    fun calculate_total(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    fun check_big_small(arg0: &vector<u64>, arg1: u64, arg2: bool, arg3: u64) : (bool, u64) {
        if (is_any_triple(arg0)) {
            return (false, 0)
        };
        if (arg2 == arg1 >= 11) {
            return (true, arg3 * (1 + 1))
        };
        (false, 0)
    }

    fun check_odd_even(arg0: u64, arg1: bool, arg2: u64) : (bool, u64) {
        if (arg1 == arg0 % 2 == 1) {
            return (true, arg2 * (1 + 1))
        };
        (false, 0)
    }

    public entry fun commit_bet(arg0: &mut DiceGameContract, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 103);
        validate_bet(arg2, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.contract_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        let v1 = v0 * (get_max_payout_for_bet_type(arg2, arg3) + 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.contract_balance) - arg0.total_locked_balance >= v1, 108);
        arg0.total_locked_balance = arg0.total_locked_balance + v1;
        let v2 = 0x2::object::new(arg6);
        let v3 = BetCommitment{
            id              : v2,
            player          : 0x2::tx_context::sender(arg6),
            commitment_hash : arg1,
            bet_amount      : v0,
            bet_type        : arg2,
            bet_value       : arg3,
            locked_amount   : v1,
            committed_at    : 0x2::clock::timestamp_ms(arg5),
            is_revealed     : false,
        };
        0x2::transfer::public_share_object<BetCommitment>(v3);
        let v4 = CommitmentCreatedEvent{
            commitment_id : 0x2::object::uid_to_address(&v2),
            player        : 0x2::tx_context::sender(arg6),
            bet_amount    : v0,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CommitmentCreatedEvent>(v4);
    }

    public entry fun deposit(arg0: &mut DiceGameContract, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.banker, 100);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.contract_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = DepositEvent{
            banker      : arg0.banker,
            amount      : v0,
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.contract_balance) + v0,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun determine_game_result_by_type(arg0: u8, arg1: u64, arg2: &vector<u64>, arg3: u64, arg4: u64) : (bool, u64) {
        if (arg0 == 1) {
            return check_big_small(arg2, arg3, true, arg4)
        };
        if (arg0 == 0) {
            return check_big_small(arg2, arg3, false, arg4)
        };
        if (arg0 == 2) {
            return check_odd_even(arg3, true, arg4)
        };
        if (arg0 == 3) {
            return check_odd_even(arg3, false, arg4)
        };
        (false, 0)
    }

    public fun get_available_balance(arg0: &DiceGameContract) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.contract_balance) - arg0.total_locked_balance
    }

    public fun get_contract_info(arg0: &DiceGameContract) : (address, u64, u64, u64, u64) {
        (arg0.banker, 0x2::balance::value<0x2::sui::SUI>(&arg0.contract_balance), arg0.total_locked_balance, arg0.total_games, arg0.total_payout)
    }

    fun get_max_payout_for_bet_type(arg0: u8, arg1: u64) : u64 {
        if (arg0 == 1 || arg0 == 0) {
            1
        } else if (arg0 == 2 || arg0 == 3) {
            1
        } else {
            0
        }
    }

    public fun get_player_games(arg0: &DiceGameContract, arg1: address) : vector<GameRecord> {
        let v0 = 0x1::vector::empty<GameRecord>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<GameRecord>(&arg0.game_records)) {
            let v2 = *0x1::vector::borrow<GameRecord>(&arg0.game_records, v1);
            if (v2.player == arg1) {
                0x1::vector::push_back<GameRecord>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_recent_games(arg0: &DiceGameContract, arg1: u64) : vector<GameRecord> {
        let v0 = 0x1::vector::length<GameRecord>(&arg0.game_records);
        let v1 = 0x1::vector::empty<GameRecord>();
        if (v0 == 0) {
            return v1
        };
        let v2 = if (arg1 > v0) {
            v0
        } else {
            arg1
        };
        let v3 = v0 - v2;
        while (v3 < v0) {
            0x1::vector::push_back<GameRecord>(&mut v1, *0x1::vector::borrow<GameRecord>(&arg0.game_records, v3));
            v3 = v3 + 1;
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DiceGameContract{
            id                   : 0x2::object::new(arg0),
            banker               : 0x2::tx_context::sender(arg0),
            contract_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            total_locked_balance : 0,
            game_records         : 0x1::vector::empty<GameRecord>(),
            total_games          : 0,
            total_payout         : 0,
            min_reveal_delay     : 5000,
            max_reveal_timeout   : 600000,
        };
        0x2::transfer::public_share_object<DiceGameContract>(v0);
    }

    fun is_any_triple(arg0: &vector<u64>) : bool {
        if (0x1::vector::length<u64>(arg0) != 3) {
            return false
        };
        let v0 = *0x1::vector::borrow<u64>(arg0, 1);
        *0x1::vector::borrow<u64>(arg0, 0) == v0 && v0 == *0x1::vector::borrow<u64>(arg0, 2)
    }

    public entry fun reveal_and_play(arg0: &mut DiceGameContract, arg1: &mut BetCommitment, arg2: u8, arg3: u64, arg4: vector<u8>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.player == 0x2::tx_context::sender(arg7), 106);
        assert!(!arg1.is_revealed, 104);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 >= arg1.committed_at + arg0.min_reveal_delay, 105);
        assert!(arg2 == arg1.bet_type, 112);
        assert!(arg3 == arg1.bet_value, 113);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, arg2);
        let v2 = 0;
        while (v2 < 8) {
            0x1::vector::push_back<u8>(&mut v1, ((arg3 >> v2 * 8 & 255) as u8));
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v1, arg4);
        assert!(0x2::hash::keccak256(&v1) == arg1.commitment_hash, 103);
        let v3 = arg1.bet_amount;
        let v4 = 0x2::random::new_generator(arg5, arg7);
        let v5 = &mut v4;
        let v6 = roll_three_dice(v5);
        let v7 = calculate_total(&v6);
        let (v8, v9) = determine_game_result_by_type(arg2, arg3, &v6, v7, v3);
        if (v8) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.contract_balance, v9), arg7), arg1.player);
            arg0.total_payout = arg0.total_payout + v9;
        };
        arg0.total_locked_balance = arg0.total_locked_balance - arg1.locked_amount;
        let v10 = GameRecord{
            player       : arg1.player,
            bet_amount   : v3,
            bet_type     : arg2,
            bet_value    : arg3,
            dice_values  : v6,
            total_points : v7,
            is_win       : v8,
            payout       : v9,
            timestamp    : v0,
        };
        0x1::vector::push_back<GameRecord>(&mut arg0.game_records, v10);
        arg0.total_games = arg0.total_games + 1;
        let v11 = GamePlayedEvent{
            player       : arg1.player,
            bet_amount   : v3,
            bet_type     : arg2,
            bet_value    : arg3,
            dice_values  : v6,
            total_points : v7,
            is_win       : v8,
            payout       : v9,
            timestamp    : v0,
        };
        0x2::event::emit<GamePlayedEvent>(v11);
        arg1.is_revealed = true;
    }

    fun roll_three_dice(arg0: &mut 0x2::random::RandomGenerator) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 3) {
            0x1::vector::push_back<u64>(&mut v0, 0x2::random::generate_u64(arg0) % 6 + 1);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun unlock_expired_commitment(arg0: &mut DiceGameContract, arg1: &mut BetCommitment, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_revealed, 104);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.committed_at + arg0.max_reveal_timeout, 107);
        arg0.total_locked_balance = arg0.total_locked_balance - arg1.locked_amount;
        arg1.is_revealed = true;
    }

    fun validate_bet(arg0: u8, arg1: u64) {
        assert!(arg0 >= 0 && arg0 <= 3, 112);
        assert!(arg1 == 0, 113);
    }

    public entry fun withdraw(arg0: &mut DiceGameContract, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.banker, 100);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.contract_balance) - arg0.total_locked_balance >= arg1, 108);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.contract_balance, arg1), arg3), arg0.banker);
        let v0 = WithdrawEvent{
            banker      : arg0.banker,
            amount      : arg1,
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.contract_balance),
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

