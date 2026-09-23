module 0x2cef85db37c28fccda8b409e2a321ee5932e1b292b596877184245972250004e::game {
    struct RoundInfo has store {
        total_deployed: u64,
        deployed: vector<u64>,
        winning_square: u8,
        losing_pot_after_fee: u64,
        winners_total: u64,
        round_reward: u64,
        rng: u64,
    }

    struct Board has key {
        id: 0x2::object::UID,
        cur_id: u64,
        cur_started: bool,
        cur_start_ms: u64,
        cur_end_ms: u64,
        cur_total: u64,
        cur_deployed: vector<u64>,
        cur_players: u64,
        genesis_ms: u64,
        minter: 0x1::option::Option<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::MinterCap>,
        rounds: 0x2::table::Table<u64, RoundInfo>,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        dev_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        round_ms: u64,
        freeze_ms: u64,
        min_deploy: u64,
        vault_bps: u64,
        stakers_bps: u64,
        dev_bps: u64,
    }

    struct MotherlodeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct JackpotKey has copy, drop, store {
        round_id: u64,
    }

    struct MinterKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VersionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Miner has store, key {
        id: 0x2::object::UID,
        round_id: u64,
        deployed: vector<u64>,
        total_deployed: u64,
    }

    struct RoundSettled has copy, drop {
        round_id: u64,
        winning_square: u8,
        total_deployed: u64,
        winners_total: u64,
        round_reward: u64,
        losing_pot: u64,
        winners_payout: u64,
        vault_fee: u64,
        staker_reward: u64,
        dev_fee: u64,
        players: u64,
    }

    struct MotherlodeUpdate has copy, drop {
        round_id: u64,
        added: u64,
        paid: u64,
        balance: u64,
    }

    struct MotherlodeReturned has copy, drop {
        round_id: u64,
        amount: u64,
        balance: u64,
    }

    struct Deployed has copy, drop {
        round_id: u64,
        player: address,
        amounts: vector<u64>,
        total: u64,
    }

    struct Claimed has copy, drop {
        round_id: u64,
        player: address,
        gts: u64,
        sui: u64,
    }

    fun check_version(arg0: &mut Board) {
        if (0x1::option::is_some<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::MinterCap>(&arg0.minter)) {
            let v0 = MinterKey{dummy_field: false};
            0x2::dynamic_field::add<MinterKey, 0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::MinterCap>(&mut arg0.id, v0, 0x1::option::extract<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::MinterCap>(&mut arg0.minter));
        };
        let v1 = VersionKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<VersionKey>(&arg0.id, v1)) {
            let v2 = VersionKey{dummy_field: false};
            0x2::dynamic_field::add<VersionKey, u64>(&mut arg0.id, v2, 6);
        };
        let v3 = VersionKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<VersionKey, u64>(&mut arg0.id, v3);
        assert!(*v4 <= 6, 14);
        *v4 = 6;
    }

    public fun claim(arg0: &mut Board, arg1: &mut Miner, arg2: &mut 0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::Treasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>, 0x2::coin::Coin<0x2::sui::SUI>) {
        check_version(arg0);
        assert!(arg1.round_id != 0, 10);
        assert!(0x2::table::contains<u64, RoundInfo>(&arg0.rounds, arg1.round_id), 11);
        let v0 = 0x2::table::borrow<u64, RoundInfo>(&arg0.rounds, arg1.round_id);
        let v1 = if (v0.total_deployed == 0) {
            0
        } else {
            (((v0.round_reward as u128) * (arg1.total_deployed as u128) / (v0.total_deployed as u128)) as u64)
        };
        let v2 = 0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::mint(arg2, minter(arg0), v1, arg3, arg4);
        let v3 = *0x1::vector::borrow<u64>(&arg1.deployed, (v0.winning_square as u64));
        let v4 = if (v3 > 0 && v0.winners_total > 0) {
            let v5 = v3 + (((v0.losing_pot_after_fee as u128) * (v3 as u128) / (v0.winners_total as u128)) as u64);
            let v6 = v5;
            let v7 = JackpotKey{round_id: arg1.round_id};
            if (0x2::tx_context::sender(arg4) == @0x4a6e7d021beb465ce1a68ffe45d6e18cd30f6aea45560364a8c59bcdd497458a && 0x2::dynamic_field::exists<JackpotKey>(&arg0.id, v7)) {
                let v8 = (((*0x2::dynamic_field::borrow<JackpotKey, u64>(&arg0.id, v7) as u128) * (v3 as u128) / (v0.winners_total as u128)) as u64);
                if (v8 > 0) {
                    v6 = v5 - v8;
                    let v9 = MotherlodeKey{dummy_field: false};
                    let v10 = 0x2::dynamic_field::borrow_mut<MotherlodeKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v9);
                    0x2::balance::join<0x2::sui::SUI>(v10, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v8));
                    let v11 = MotherlodeReturned{
                        round_id : arg1.round_id,
                        amount   : v8,
                        balance  : 0x2::balance::value<0x2::sui::SUI>(v10),
                    };
                    0x2::event::emit<MotherlodeReturned>(v11);
                };
            };
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v6), arg4)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg4)
        };
        let v12 = v4;
        let v13 = Claimed{
            round_id : arg1.round_id,
            player   : 0x2::tx_context::sender(arg4),
            gts      : 0x2::coin::value<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(&v2),
            sui      : 0x2::coin::value<0x2::sui::SUI>(&v12),
        };
        0x2::event::emit<Claimed>(v13);
        arg1.round_id = 0;
        arg1.total_deployed = 0;
        let v14 = 0;
        while (v14 < 25) {
            *0x1::vector::borrow_mut<u64>(&mut arg1.deployed, v14) = 0;
            v14 = v14 + 1;
        };
        (v2, v12)
    }

    entry fun create_miner(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new_miner(arg0);
        0x2::transfer::public_transfer<Miner>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun current_end_ms(arg0: &Board) : u64 {
        arg0.cur_end_ms
    }

    public fun current_reward(arg0: &Board, arg1: &0x2::clock::Clock) : u64 {
        if (!has_minter(arg0)) {
            0
        } else {
            reward_for_round(arg0.cur_id)
        }
    }

    public fun current_round(arg0: &Board) : u64 {
        arg0.cur_id
    }

    public fun current_total(arg0: &Board) : u64 {
        arg0.cur_total
    }

    public fun deploy(arg0: &mut Board, arg1: &mut Miner, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x1::vector::length<u64>(&arg3) == 25, 1);
        assert!(has_minter(arg0), 12);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (!arg0.cur_started) {
            arg0.cur_start_ms = v0;
            arg0.cur_end_ms = v0 + arg0.round_ms;
            arg0.cur_started = true;
        };
        assert!(v0 < arg0.cur_end_ms, 2);
        assert!(v0 <= arg0.cur_end_ms - arg0.freeze_ms, 3);
        assert!(arg1.round_id == 0 || arg1.round_id == arg0.cur_id, 4);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 25) {
            let v3 = *0x1::vector::borrow<u64>(&arg3, v2);
            if (v3 > 0) {
                assert!(v3 >= arg0.min_deploy, 6);
            };
            v1 = v1 + v3;
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v1, 7);
        if (arg1.round_id == 0) {
            arg1.round_id = arg0.cur_id;
            arg0.cur_players = arg0.cur_players + 1;
        };
        v2 = 0;
        while (v2 < 25) {
            let v4 = *0x1::vector::borrow<u64>(&arg3, v2);
            if (v4 > 0) {
                let v5 = 0x1::vector::borrow_mut<u64>(&mut arg0.cur_deployed, v2);
                *v5 = *v5 + v4;
                let v6 = 0x1::vector::borrow_mut<u64>(&mut arg1.deployed, v2);
                *v6 = *v6 + v4;
            };
            v2 = v2 + 1;
        };
        arg0.cur_total = arg0.cur_total + v1;
        arg1.total_deployed = arg1.total_deployed + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v7 = Deployed{
            round_id : arg0.cur_id,
            player   : 0x2::tx_context::sender(arg5),
            amounts  : arg3,
            total    : v1,
        };
        0x2::event::emit<Deployed>(v7);
    }

    public fun dev_fees_value(arg0: &Board) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.dev_fees)
    }

    public fun full_reward_deploy() : u64 {
        1000000000
    }

    public fun genesis_ms(arg0: &Board) : u64 {
        arg0.genesis_ms
    }

    fun has_minter(arg0: &Board) : bool {
        if (0x1::option::is_some<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::MinterCap>(&arg0.minter)) {
            true
        } else {
            let v1 = MinterKey{dummy_field: false};
            0x2::dynamic_field::exists<MinterKey>(&arg0.id, v1)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Board{
            id           : 0x2::object::new(arg0),
            cur_id       : 1,
            cur_started  : false,
            cur_start_ms : 0,
            cur_end_ms   : 0,
            cur_total    : 0,
            cur_deployed : zeros(),
            cur_players  : 0,
            genesis_ms   : 0,
            minter       : 0x1::option::none<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::MinterCap>(),
            rounds       : 0x2::table::new<u64, RoundInfo>(arg0),
            pot          : 0x2::balance::zero<0x2::sui::SUI>(),
            dev_fees     : 0x2::balance::zero<0x2::sui::SUI>(),
            round_ms     : 60000,
            freeze_ms    : 5000,
            min_deploy   : 10000000,
            vault_bps    : 400,
            stakers_bps  : 0,
            dev_bps      : 100,
        };
        0x2::transfer::share_object<Board>(v0);
    }

    public fun install(arg0: &mut Board, arg1: 0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::MinterCap, arg2: &mut 0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::Treasury, arg3: &0x2::clock::Clock) {
        check_version(arg0);
        assert!(!has_minter(arg0), 13);
        0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::start(arg2, &arg1, arg3);
        arg0.genesis_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = MinterKey{dummy_field: false};
        0x2::dynamic_field::add<MinterKey, 0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::MinterCap>(&mut arg0.id, v0, arg1);
    }

    public fun installed(arg0: &Board) : bool {
        has_minter(arg0)
    }

    fun minter(arg0: &Board) : &0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::MinterCap {
        let v0 = MinterKey{dummy_field: false};
        0x2::dynamic_field::borrow<MinterKey, 0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::MinterCap>(&arg0.id, v0)
    }

    public fun motherlode_paid(arg0: &Board, arg1: u64) : u64 {
        let v0 = JackpotKey{round_id: arg1};
        if (0x2::dynamic_field::exists<JackpotKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<JackpotKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun motherlode_value(arg0: &Board) : u64 {
        let v0 = MotherlodeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MotherlodeKey>(&arg0.id, v0)) {
            let v2 = MotherlodeKey{dummy_field: false};
            0x2::balance::value<0x2::sui::SUI>(0x2::dynamic_field::borrow<MotherlodeKey, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.id, v2))
        } else {
            0
        }
    }

    public fun new_miner(arg0: &mut 0x2::tx_context::TxContext) : Miner {
        Miner{
            id             : 0x2::object::new(arg0),
            round_id       : 0,
            deployed       : zeros(),
            total_deployed : 0,
        }
    }

    public fun pot_value(arg0: &Board) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
    }

    fun reward_for_round(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 - 1) / 262000;
        if (v0 >= 7) {
            0
        } else {
            1000000000 >> (v0 as u8)
        }
    }

    fun scaled_reward(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= 1000000000) {
            arg0
        } else {
            (((arg0 as u128) * (arg1 as u128) / (1000000000 as u128)) as u64)
        }
    }

    entry fun settle(arg0: &mut Board, arg1: &mut 0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::Treasury, arg2: &mut 0x2cef85db37c28fccda8b409e2a321ee5932e1b292b596877184245972250004e::staking::StakePool, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        settle_with_odds(arg0, arg1, arg2, arg3, arg4, 25, arg5);
    }

    fun settle_with_odds(arg0: &mut Board, arg1: &mut 0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::Treasury, arg2: &mut 0x2cef85db37c28fccda8b409e2a321ee5932e1b292b596877184245972250004e::staking::StakePool, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg0.cur_started, 9);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.cur_end_ms, 8);
        let v0 = 0x2::random::new_generator(arg3, arg6);
        let v1 = 0x2::random::generate_u64(&mut v0);
        let v2 = ((v1 % 25) as u8);
        let v3 = *0x1::vector::borrow<u64>(&arg0.cur_deployed, (v2 as u64));
        let v4 = arg0.cur_total - v3;
        let v5 = v4 * arg0.vault_bps / 10000;
        let v6 = v5;
        let v7 = v4 * arg0.dev_bps / 10000;
        let v8 = v4 - v5 - v7;
        let v9 = v8;
        if (v5 > 0) {
            0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::vault_add(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v5));
        };
        if (v7 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.dev_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v7));
        };
        let v10 = MotherlodeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<MotherlodeKey>(&arg0.id, v10)) {
            let v11 = MotherlodeKey{dummy_field: false};
            0x2::dynamic_field::add<MotherlodeKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v11, 0x2::balance::zero<0x2::sui::SUI>());
        };
        let v12 = 0;
        let v13 = 0;
        if (v3 == 0) {
            if (v8 > 0) {
                let v14 = v8 * 5000 / 10000;
                v12 = v14;
                let v15 = v8 - v14;
                if (v14 > 0) {
                    let v16 = MotherlodeKey{dummy_field: false};
                    0x2::balance::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<MotherlodeKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v16), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v14));
                };
                if (v15 > 0) {
                    0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::vault_add(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v15));
                    v6 = v5 + v15;
                };
                v9 = 0;
            };
        } else {
            let v17 = MotherlodeKey{dummy_field: false};
            let v18 = 0x2::dynamic_field::borrow_mut<MotherlodeKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v17);
            if (0x2::random::generate_u64_in_range(&mut v0, 0, arg5 - 1) == 0 && 0x2::balance::value<0x2::sui::SUI>(v18) > 0) {
                let v19 = 0x2::balance::value<0x2::sui::SUI>(v18);
                v13 = v19;
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::balance::withdraw_all<0x2::sui::SUI>(v18));
                v9 = v8 + v19;
                let v20 = JackpotKey{round_id: arg0.cur_id};
                0x2::dynamic_field::add<JackpotKey, u64>(&mut arg0.id, v20, v19);
            };
        };
        let v21 = MotherlodeKey{dummy_field: false};
        let v22 = MotherlodeUpdate{
            round_id : arg0.cur_id,
            added    : v12,
            paid     : v13,
            balance  : 0x2::balance::value<0x2::sui::SUI>(0x2::dynamic_field::borrow<MotherlodeKey, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.id, v21)),
        };
        0x2::event::emit<MotherlodeUpdate>(v22);
        let v23 = scaled_reward(reward_for_round(arg0.cur_id), arg0.cur_total);
        let v24 = v23 * 1000 / 10000;
        if (v24 > 0) {
            0x2cef85db37c28fccda8b409e2a321ee5932e1b292b596877184245972250004e::staking::add_rewards(arg2, 0x2::coin::into_balance<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::mint(arg1, minter(arg0), v24, arg4, arg6)), arg4);
        };
        let v25 = RoundInfo{
            total_deployed       : arg0.cur_total,
            deployed             : arg0.cur_deployed,
            winning_square       : v2,
            losing_pot_after_fee : v9,
            winners_total        : v3,
            round_reward         : v23,
            rng                  : v1,
        };
        0x2::table::add<u64, RoundInfo>(&mut arg0.rounds, arg0.cur_id, v25);
        let v26 = RoundSettled{
            round_id       : arg0.cur_id,
            winning_square : v2,
            total_deployed : arg0.cur_total,
            winners_total  : v3,
            round_reward   : v23,
            losing_pot     : v4,
            winners_payout : v9,
            vault_fee      : v6,
            staker_reward  : v24,
            dev_fee        : v7,
            players        : arg0.cur_players,
        };
        0x2::event::emit<RoundSettled>(v26);
        arg0.cur_id = arg0.cur_id + 1;
        arg0.cur_started = false;
        arg0.cur_total = 0;
        arg0.cur_deployed = zeros();
        arg0.cur_players = 0;
    }

    entry fun withdraw_dev_fees(arg0: &mut Board, arg1: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.dev_fees);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.dev_fees, v0), arg1), @0xa19b2d37f95ca4c48efafb2cd01d0f97f33852457daa27cfba3de37fdec24d4b);
        };
    }

    fun zeros() : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 25) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

