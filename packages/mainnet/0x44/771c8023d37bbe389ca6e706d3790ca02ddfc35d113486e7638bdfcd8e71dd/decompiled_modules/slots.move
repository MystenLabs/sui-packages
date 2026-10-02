module 0x44771c8023d37bbe389ca6e706d3790ca02ddfc35d113486e7638bdfcd8e71dd::slots {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SlotHouse<phantom T0> has key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<T0>,
        min_bet: u64,
        max_bet: u64,
        paused: bool,
        round: u64,
        locked_reserve: u64,
    }

    struct SlotCommitment<phantom T0> has key {
        id: 0x2::object::UID,
        house_id: 0x2::object::ID,
        player: address,
        stake: 0x2::balance::Balance<T0>,
        wager: u64,
        game: u8,
        reserve: u64,
        reveal_deadline_ms: u64,
    }

    struct SlotPayout<phantom T0> has key {
        id: 0x2::object::UID,
        player: address,
        amount: u64,
        payout: 0x2::balance::Balance<T0>,
    }

    struct SlotHouseCreatedEvent has copy, drop {
        house_id: 0x2::object::ID,
        asset: u8,
        min_bet: u64,
        max_bet: u64,
    }

    struct SlotHouseFundedEvent has copy, drop {
        house_id: 0x2::object::ID,
        asset: u8,
        amount: u64,
    }

    struct SlotHousePauseEvent has copy, drop {
        house_id: 0x2::object::ID,
        paused: bool,
    }

    struct SlotHouseLimitsEvent has copy, drop {
        house_id: 0x2::object::ID,
        min_bet: u64,
        max_bet: u64,
    }

    struct SlotHouseWithdrawalEvent has copy, drop {
        house_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct SlotRoundCommittedEvent has copy, drop {
        commitment_id: 0x2::object::ID,
        house_id: 0x2::object::ID,
        player: address,
        game: u8,
        stake: u64,
        reserve: u64,
        reveal_deadline_ms: u64,
    }

    struct SlotRoundEvent has copy, drop {
        player: address,
        game: u8,
        stake: u64,
        base_payout: u64,
        bonus_payout: u64,
        payout: u64,
        fee: u64,
        won: bool,
        round: u64,
        reels: vector<u8>,
        winning_lines: vector<u8>,
        bonus_kind: u8,
        bonus_grids: vector<vector<u8>>,
        bonus_lines: vector<vector<u8>>,
        bonus_payouts: vector<u64>,
        bonus_multipliers: vector<u8>,
        expanded_reels: vector<u8>,
        bonus_prize_codes: vector<u8>,
    }

    struct SlotPayoutCreatedEvent has copy, drop {
        payout_id: 0x2::object::ID,
        player: address,
        amount: u64,
        round: u64,
    }

    struct SlotRoundExpiredEvent has copy, drop {
        commitment_id: 0x2::object::ID,
        player: address,
        game: u8,
        stake: u64,
        round: u64,
    }

    public entry fun claim_slot_payout<T0>(arg0: SlotPayout<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let SlotPayout {
            id     : v0,
            player : v1,
            amount : _,
            payout : v3,
        } = arg0;
        assert!(v1 == 0x2::tx_context::sender(arg1), 6);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg1), v1);
    }

    public entry fun commit_slot_spin<T0>(arg0: &mut SlotHouse<T0>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg1 <= 4, 5);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg0.min_bet && v0 <= arg0.max_bet, 0);
        let v1 = v0 * 250 / 10000;
        assert!(v1 > 0, 0);
        let v2 = v0 * 2500 / 100 + v1;
        assert!(0x2::balance::value<T0>(&arg0.vault) >= arg0.locked_reserve + v2, 2);
        arg0.locked_reserve = arg0.locked_reserve + v2;
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = 0x2::object::uid_to_inner(&arg0.id);
        let v5 = SlotCommitment<T0>{
            id                 : 0x2::object::new(arg4),
            house_id           : v4,
            player             : v3,
            stake              : 0x2::coin::into_balance<T0>(arg2),
            wager              : v0,
            game               : arg1,
            reserve            : v2,
            reveal_deadline_ms : 0x2::clock::timestamp_ms(arg3) + 300000,
        };
        let v6 = SlotRoundCommittedEvent{
            commitment_id      : 0x2::object::uid_to_inner(&v5.id),
            house_id           : v4,
            player             : v3,
            game               : arg1,
            stake              : v0,
            reserve            : v2,
            reveal_deadline_ms : v5.reveal_deadline_ms,
        };
        0x2::event::emit<SlotRoundCommittedEvent>(v6);
        0x2::transfer::transfer<SlotCommitment<T0>>(v5, v3);
    }

    public entry fun create_jason_house(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SlotHouse<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>{
            id             : 0x2::object::new(arg1),
            vault          : 0x2::balance::zero<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(),
            min_bet        : 1000000,
            max_bet        : 10000000000,
            paused         : true,
            round          : 0,
            locked_reserve : 0,
        };
        let v1 = SlotHouseCreatedEvent{
            house_id : 0x2::object::uid_to_inner(&v0.id),
            asset    : 1,
            min_bet  : 1000000,
            max_bet  : 10000000000,
        };
        0x2::event::emit<SlotHouseCreatedEvent>(v1);
        0x2::transfer::share_object<SlotHouse<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>>(v0);
    }

    public entry fun create_sui_house(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SlotHouse<0x2::sui::SUI>{
            id             : 0x2::object::new(arg1),
            vault          : 0x2::balance::zero<0x2::sui::SUI>(),
            min_bet        : 1000000,
            max_bet        : 100000000,
            paused         : true,
            round          : 0,
            locked_reserve : 0,
        };
        let v1 = SlotHouseCreatedEvent{
            house_id : 0x2::object::uid_to_inner(&v0.id),
            asset    : 0,
            min_bet  : 1000000,
            max_bet  : 100000000,
        };
        0x2::event::emit<SlotHouseCreatedEvent>(v1);
        0x2::transfer::share_object<SlotHouse<0x2::sui::SUI>>(v0);
    }

    public entry fun deposit_jason(arg0: &mut SlotHouse<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg1: &AdminCap, arg2: 0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>) {
        0x2::balance::join<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg0.vault, 0x2::coin::into_balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg2));
        let v0 = SlotHouseFundedEvent{
            house_id : 0x2::object::uid_to_inner(&arg0.id),
            asset    : 1,
            amount   : 0x2::coin::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg2),
        };
        0x2::event::emit<SlotHouseFundedEvent>(v0);
    }

    public entry fun deposit_sui(arg0: &mut SlotHouse<0x2::sui::SUI>, arg1: &AdminCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = SlotHouseFundedEvent{
            house_id : 0x2::object::uid_to_inner(&arg0.id),
            asset    : 0,
            amount   : 0x2::coin::value<0x2::sui::SUI>(&arg2),
        };
        0x2::event::emit<SlotHouseFundedEvent>(v0);
    }

    fun draw_grid(arg0: &mut 0x2::random::RandomGenerator) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 15) {
            0x1::vector::push_back<u8>(&mut v0, draw_symbol(arg0));
            v1 = v1 + 1;
        };
        v0
    }

    fun draw_symbol(arg0: &mut 0x2::random::RandomGenerator) : u8 {
        let v0 = 0x2::random::generate_u8_in_range(arg0, 0, 100);
        if (v0 < 60) {
            v0 / 12
        } else if (v0 < 72) {
            5
        } else if (v0 < 90) {
            6
        } else {
            7
        }
    }

    public entry fun expire_slot_spin<T0>(arg0: SlotCommitment<T0>, arg1: &mut SlotHouse<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.reveal_deadline_ms, 7);
        let SlotCommitment {
            id                 : v0,
            house_id           : v1,
            player             : v2,
            stake              : v3,
            wager              : v4,
            game               : v5,
            reserve            : v6,
            reveal_deadline_ms : _,
        } = arg0;
        let v8 = v0;
        assert!(v1 == 0x2::object::uid_to_inner(&arg1.id), 9);
        assert!(v6 <= arg1.locked_reserve, 2);
        arg1.locked_reserve = arg1.locked_reserve - v6;
        0x2::balance::join<T0>(&mut arg1.vault, v3);
        let v9 = v4 * 250 / 10000;
        assert!(v9 <= 0x2::balance::value<T0>(&arg1.vault), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vault, v9), arg3), @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4);
        arg1.round = arg1.round + 1;
        0x2::object::delete(v8);
        let v10 = SlotRoundExpiredEvent{
            commitment_id : 0x2::object::uid_to_inner(&v8),
            player        : v2,
            game          : v5,
            stake         : v4,
            round         : arg1.round,
        };
        0x2::event::emit<SlotRoundExpiredEvent>(v10);
    }

    fun grid_payout(arg0: &vector<u8>, arg1: u64, arg2: u64, arg3: u8) : (u64, vector<u8>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 10) {
            let v3 = *arg0;
            if (arg3 < 5) {
                let v4 = 0;
                while (v4 < 3) {
                    *0x1::vector::borrow_mut<u8>(&mut v3, ((arg3 * 3 + v4) as u64)) = 6;
                    v4 = v4 + 1;
                };
            };
            let v5 = line_payout(&v3, arg1, arg2, v2);
            if (v5 > 0) {
                0x1::vector::push_back<u8>(&mut v1, v2);
                v0 = v0 + v5;
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun line_payout(arg0: &vector<u8>, arg1: u64, arg2: u64, arg3: u8) : u64 {
        let v0 = 6;
        let v1 = 0;
        while (v1 < 5 && v0 == 6) {
            let v2 = *0x1::vector::borrow<u8>(arg0, ((v1 * 3 + line_row(arg3, v1)) as u64));
            if (v2 != 6) {
                v0 = v2;
            };
            v1 = v1 + 1;
        };
        if (v0 == 7) {
            return 0
        };
        let v3 = 0;
        let v4 = 0;
        while (v4 < 5) {
            let v5 = *0x1::vector::borrow<u8>(arg0, ((v4 * 3 + line_row(arg3, v4)) as u64));
            if (v5 == 7 || v5 != 6 && v5 != v0) {
                v4 = 5;
                continue
            };
            v3 = v3 + 1;
            v4 = v4 + 1;
        };
        let v6 = if (v3 >= 5) {
            300
        } else if (v3 == 4) {
            60
        } else if (v3 == 3) {
            18
        } else {
            0
        };
        if (v6 == 0) {
            0
        } else {
            arg1 * v6 * arg2 / 10000
        }
    }

    fun line_row(arg0: u8, arg1: u8) : u8 {
        if (arg0 == 0) {
            1
        } else if (arg0 == 1) {
            0
        } else if (arg0 == 2) {
            2
        } else if (arg0 == 3) {
            if (arg1 == 2) {
                1
            } else {
                0
            }
        } else if (arg0 == 4) {
            if (arg1 == 2) {
                1
            } else {
                2
            }
        } else if (arg0 == 5) {
            if (arg1 == 0 || arg1 == 4) {
                0
            } else {
                1
            }
        } else if (arg0 == 6) {
            if (arg1 == 0 || arg1 == 4) {
                2
            } else {
                1
            }
        } else if (arg0 == 7) {
            let v1 = if (arg1 == 1) {
                true
            } else if (arg1 == 2) {
                true
            } else {
                arg1 == 3
            };
            if (v1) {
                0
            } else {
                1
            }
        } else if (arg0 == 8) {
            let v2 = if (arg1 == 1) {
                true
            } else if (arg1 == 2) {
                true
            } else {
                arg1 == 3
            };
            if (v2) {
                2
            } else {
                1
            }
        } else if (arg0 == 9) {
            if (arg1 == 1 || arg1 == 3) {
                1
            } else {
                0
            }
        } else {
            1
        }
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun min_u8(arg0: u8, arg1: u8) : u8 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun resolve_bonus(arg0: &mut 0x2::random::RandomGenerator, arg1: u8, arg2: &vector<u8>, arg3: u64, arg4: u64) : (u8, vector<vector<u8>>, vector<vector<u8>>, vector<u64>, vector<u8>, vector<u8>, vector<u8>) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0x1::vector::empty<u8>();
        if (!(scatter_count(arg2) >= 3)) {
            return (0, v0, v1, v2, v3, v4, v5)
        };
        if (arg1 == 1) {
            let v6 = 0;
            let v7 = 0;
            while (v6 < 3) {
                let v8 = 0x2::random::generate_u8_in_range(arg0, 0, 7);
                let v9 = if (v8 < 2) {
                    0
                } else if (v8 < 4) {
                    10
                } else if (v8 < 6) {
                    20
                } else if (v8 == 6) {
                    30
                } else {
                    50
                };
                let v10 = min_u64(arg3 * v9 / 100, arg4 - v7);
                v7 = v7 + v10;
                0x1::vector::push_back<vector<u8>>(&mut v0, 0x1::vector::empty<u8>());
                0x1::vector::push_back<vector<u8>>(&mut v1, 0x1::vector::empty<u8>());
                0x1::vector::push_back<u64>(&mut v2, v10);
                0x1::vector::push_back<u8>(&mut v3, 0);
                0x1::vector::push_back<u8>(&mut v4, 255);
                0x1::vector::push_back<u8>(&mut v5, v8);
                v6 = v6 + 1;
            };
        } else {
            let v11 = if (arg1 == 0) {
                4
            } else if (arg1 == 2) {
                4
            } else if (arg1 == 3) {
                3
            } else {
                4
            };
            let v12 = 0;
            let v13 = 0;
            let v14 = v11;
            while (v12 < v14 && v12 < 10) {
                let v15 = draw_grid(arg0);
                let v16 = if (arg1 == 0) {
                    true
                } else if (arg1 == 2) {
                    true
                } else {
                    arg1 == 4
                };
                let v17 = if (v16) {
                    0x2::random::generate_u8_in_range(arg0, 0, 4)
                } else {
                    255
                };
                let v18 = if (arg1 == 3) {
                    ((v12 + 1) as u8)
                } else {
                    1
                };
                let v19 = if (arg1 == 3) {
                    20
                } else if (arg1 == 4) {
                    15
                } else {
                    25
                };
                let (v20, v21) = grid_payout(&v15, arg3 * v19 / 100, (v18 as u64) * 100, v17);
                let v22 = min_u64(v20, arg4 - v13);
                v13 = v13 + v22;
                0x1::vector::push_back<vector<u8>>(&mut v0, v15);
                0x1::vector::push_back<vector<u8>>(&mut v1, v21);
                0x1::vector::push_back<u64>(&mut v2, v22);
                0x1::vector::push_back<u8>(&mut v3, v18);
                0x1::vector::push_back<u8>(&mut v4, v17);
                0x1::vector::push_back<u8>(&mut v5, 255);
                if (should_retrigger_jadefire(arg1, v12, &v15)) {
                    let v23 = v14 + 1;
                    v14 = min_u8(v23, 10);
                };
                v12 = v12 + 1;
            };
        };
        (arg1 + 1, v0, v1, v2, v3, v4, v5)
    }

    public entry fun reveal_slot_spin<T0>(arg0: SlotCommitment<T0>, arg1: &mut SlotHouse<T0>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.player == 0x2::tx_context::sender(arg4), 6);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg0.reveal_deadline_ms, 7);
        let SlotCommitment {
            id                 : v0,
            house_id           : v1,
            player             : v2,
            stake              : v3,
            wager              : v4,
            game               : v5,
            reserve            : v6,
            reveal_deadline_ms : _,
        } = arg0;
        assert!(v1 == 0x2::object::uid_to_inner(&arg1.id), 9);
        let v8 = 0x2::random::new_generator(arg2, arg4);
        let v9 = &mut v8;
        let v10 = draw_grid(v9);
        let (v11, v12) = grid_payout(&v10, v4, 100, 255);
        let v13 = v4 * 2500 / 100;
        let v14 = min_u64(v11, v13);
        let v15 = &mut v8;
        let (v16, v17, v18, v19, v20, v21, v22) = resolve_bonus(v15, v5, &v10, v4, v13 - v14);
        let v23 = v19;
        let v24 = 0;
        let v25 = 0;
        while (v25 < 0x1::vector::length<u64>(&v23)) {
            v24 = v24 + *0x1::vector::borrow<u64>(&v23, v25);
            v25 = v25 + 1;
        };
        let v26 = v14 + v24;
        let v27 = v4 * 250 / 10000;
        assert!(v6 <= arg1.locked_reserve, 2);
        arg1.locked_reserve = arg1.locked_reserve - v6;
        0x2::balance::join<T0>(&mut arg1.vault, v3);
        let v28 = 0x2::balance::value<T0>(&arg1.vault);
        assert!(v26 <= v6 && v27 <= v6 - v26, 2);
        assert!(v26 <= v28 && v27 <= v28 - v26, 2);
        arg1.round = arg1.round + 1;
        if (v26 > 0) {
            let v29 = 0x2::object::new(arg4);
            let v30 = SlotPayout<T0>{
                id     : v29,
                player : v2,
                amount : v26,
                payout : 0x2::balance::split<T0>(&mut arg1.vault, v26),
            };
            0x2::transfer::transfer<SlotPayout<T0>>(v30, v2);
            let v31 = SlotPayoutCreatedEvent{
                payout_id : 0x2::object::uid_to_inner(&v29),
                player    : v2,
                amount    : v26,
                round     : arg1.round,
            };
            0x2::event::emit<SlotPayoutCreatedEvent>(v31);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vault, v27), arg4), @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4);
        0x2::object::delete(v0);
        let v32 = SlotRoundEvent{
            player            : v2,
            game              : v5,
            stake             : v4,
            base_payout       : v14,
            bonus_payout      : v24,
            payout            : v26,
            fee               : v27,
            won               : v26 > 0,
            round             : arg1.round,
            reels             : v10,
            winning_lines     : v12,
            bonus_kind        : v16,
            bonus_grids       : v17,
            bonus_lines       : v18,
            bonus_payouts     : v23,
            bonus_multipliers : v20,
            expanded_reels    : v21,
            bonus_prize_codes : v22,
        };
        0x2::event::emit<SlotRoundEvent>(v32);
    }

    fun scatter_count(arg0: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v1) == 7) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun set_jason_limits(arg0: &mut SlotHouse<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg1: &AdminCap, arg2: u64, arg3: u64) {
        assert!(arg2 > 0 && arg3 >= arg2, 4);
        assert!(arg3 <= 10000000000, 4);
        arg0.min_bet = arg2;
        arg0.max_bet = arg3;
        let v0 = SlotHouseLimitsEvent{
            house_id : 0x2::object::uid_to_inner(&arg0.id),
            min_bet  : arg2,
            max_bet  : arg3,
        };
        0x2::event::emit<SlotHouseLimitsEvent>(v0);
    }

    public entry fun set_paused<T0>(arg0: &mut SlotHouse<T0>, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = SlotHousePauseEvent{
            house_id : 0x2::object::uid_to_inner(&arg0.id),
            paused   : arg2,
        };
        0x2::event::emit<SlotHousePauseEvent>(v0);
    }

    public entry fun set_sui_limits(arg0: &mut SlotHouse<0x2::sui::SUI>, arg1: &AdminCap, arg2: u64, arg3: u64) {
        assert!(arg2 > 0 && arg3 >= arg2, 4);
        assert!(arg3 <= 100000000, 4);
        arg0.min_bet = arg2;
        arg0.max_bet = arg3;
        let v0 = SlotHouseLimitsEvent{
            house_id : 0x2::object::uid_to_inner(&arg0.id),
            min_bet  : arg2,
            max_bet  : arg3,
        };
        0x2::event::emit<SlotHouseLimitsEvent>(v0);
    }

    fun should_retrigger_jadefire(arg0: u8, arg1: u8, arg2: &vector<u8>) : bool {
        if (arg0 == 4) {
            if (arg1 < 6) {
                scatter_count(arg2) >= 3
            } else {
                false
            }
        } else {
            false
        }
    }

    public entry fun withdraw<T0>(arg0: &mut SlotHouse<T0>, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 3);
        assert!(arg3 != @0x0, 8);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.vault) && 0x2::balance::value<T0>(&arg0.vault) - arg2 >= arg0.locked_reserve, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg2), arg4), arg3);
        let v0 = SlotHouseWithdrawalEvent{
            house_id  : 0x2::object::uid_to_inner(&arg0.id),
            recipient : arg3,
            amount    : arg2,
        };
        0x2::event::emit<SlotHouseWithdrawalEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

