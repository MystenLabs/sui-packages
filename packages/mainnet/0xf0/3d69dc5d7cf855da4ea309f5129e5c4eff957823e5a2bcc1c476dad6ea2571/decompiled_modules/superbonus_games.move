module 0xf03d69dc5d7cf855da4ea309f5129e5c4eff957823e5a2bcc1c476dad6ea2571::superbonus_games {
    struct GameTreasury has key {
        id: 0x2::object::UID,
    }

    struct GameAdmin has key {
        id: 0x2::object::UID,
    }

    struct GameConfig has key {
        id: 0x2::object::UID,
        mines_bonus_chance: u64,
        mines_bonus_multiplier: u64,
        keno_bonus_chance: u64,
        keno_bonus_multiplier: u64,
        quants_bonus_chance: u64,
        quants_bonus_multiplier: u64,
    }

    struct GameResult has copy, drop {
        player: address,
        mine_count: u8,
        bet_amount: u64,
        selected_tiles: vector<vector<u64>>,
        mine_positions: vector<vector<u64>>,
        hit_mine: bool,
        payout_amount: u64,
        multiplier: u64,
        coin_type: 0x1::type_name::TypeName,
        seed: vector<u8>,
        bonus_activated: bool,
        bonus_cell: vector<u64>,
        bonus_amount: u64,
    }

    struct KenoMode has copy, drop {
        mode_type: u8,
    }

    struct KenoResult has copy, drop {
        player: address,
        mode: u8,
        bet_amount: u64,
        selected_numbers: vector<u64>,
        drawn_numbers: vector<u64>,
        matches: u64,
        payout_amount: u64,
        multiplier: u64,
        coin_type: 0x1::type_name::TypeName,
        seed: vector<u8>,
        bonus_activated: bool,
        bonus_number: u64,
        bonus_amount: u64,
    }

    struct QuantChestsResult has copy, drop {
        player: address,
        bet_amount: u64,
        selected_number: u64,
        chest_order: vector<u64>,
        multipliers: vector<u64>,
        payout_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        seed: vector<u8>,
        bonus_activated: bool,
        bonus_chest: u64,
        bonus_amount: u64,
    }

    public fun balance<T0>(arg0: &GameTreasury) : u64 {
        let v0 = coin_type_name<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public entry fun transfer<T0>(arg0: &mut GameTreasury, arg1: &GameAdmin, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    fun calculate_multiplier(arg0: u8, arg1: u64) : u64 {
        let v0 = 25 - (arg0 as u64);
        assert!(v0 > 0, 0);
        assert!(arg1 <= v0, 1);
        let v1 = 10000;
        let v2 = 25;
        let v3 = 0;
        while (v3 < arg1) {
            assert!(v2 > 0, 5);
            let v4 = (v0 as u128) * (10000 as u128) / (v2 as u128);
            assert!(v4 > 0, 5);
            let v5 = (v1 as u128) * (10000 as u128) * (10000 as u128) / v4 * ((10000 - 100) as u128) / (10000 as u128) / (10000 as u128);
            v1 = (v5 as u64);
            v0 = v0 - 1;
            v2 = v2 - 1;
            v3 = v3 + 1;
        };
        assert!(v1 > 0, 5);
        v1
    }

    fun check_bonus_activation(arg0: &vector<u8>, arg1: u64) : bool {
        if (arg1 == 0) {
            return false
        };
        let v0 = if (!0x1::vector::is_empty<u8>(arg0)) {
            ((*0x1::vector::borrow<u8>(arg0, 0) % 100) as u64)
        } else {
            0
        };
        v0 < arg1 / 100
    }

    fun check_hit_mine(arg0: &vector<vector<u64>>, arg1: &vector<vector<u64>>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u64>>(arg1)) {
            if (is_mine(arg0, 0x1::vector::borrow<vector<u64>>(arg1, v0))) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun coin_type_name<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::get<T0>()
    }

    fun count_matches(arg0: &vector<u64>, arg1: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            let v2 = 0;
            while (v2 < 0x1::vector::length<u64>(arg1)) {
                if (*0x1::vector::borrow<u64>(arg0, v1) == *0x1::vector::borrow<u64>(arg1, v2)) {
                    v0 = v0 + 1;
                    break
                };
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun deposit<T0>(arg0: &mut GameTreasury, arg1: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 7);
        let v0 = coin_type_name<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun find_position_in_vector(arg0: &vector<u64>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 15
    }

    fun game_withdraw<T0>(arg0: &mut GameTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 7);
        let v0 = coin_type_name<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 8);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 8);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
    }

    fun generate_bonus_cell(arg0: &vector<u8>, arg1: &vector<vector<u64>>, arg2: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = get_all_possible_coordinates();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u64>>(&v0)) {
            let v2 = 0;
            let v3 = false;
            while (v2 < 0x1::vector::length<vector<u64>>(arg1) && !v3) {
                if (is_same_tile(0x1::vector::borrow<vector<u64>>(&v0, v1), 0x1::vector::borrow<vector<u64>>(arg1, v2))) {
                    v3 = true;
                };
                v2 = v2 + 1;
            };
            if (v3) {
                0x1::vector::swap_remove<vector<u64>>(&mut v0, v1);
                continue
            };
            v1 = v1 + 1;
        };
        let v4 = if (!0x1::vector::is_empty<u8>(arg0)) {
            (*0x1::vector::borrow<u8>(arg0, 0) as u64)
        } else {
            0
        };
        *0x1::vector::borrow<vector<u64>>(&v0, ((*0x1::vector::borrow<u8>(0x2::tx_context::digest(arg2), 0) as u64) + v4) % 0x1::vector::length<vector<u64>>(&v0))
    }

    fun generate_bonus_chest(arg0: &vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 1;
        while (v1 <= 9) {
            if (v1 != arg1) {
                0x1::vector::push_back<u64>(&mut v0, v1);
            };
            v1 = v1 + 1;
        };
        let v2 = if (!0x1::vector::is_empty<u8>(arg0)) {
            (*0x1::vector::borrow<u8>(arg0, 0) as u64)
        } else {
            0
        };
        *0x1::vector::borrow<u64>(&v0, ((*0x1::vector::borrow<u8>(0x2::tx_context::digest(arg2), 0) as u64) + v2) % 0x1::vector::length<u64>(&v0))
    }

    fun generate_bonus_keno_number(arg0: &vector<u8>, arg1: &vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 1;
        while (v1 <= 40) {
            if (!0x1::vector::contains<u64>(arg1, &v1)) {
                0x1::vector::push_back<u64>(&mut v0, v1);
            };
            v1 = v1 + 1;
        };
        let v2 = if (!0x1::vector::is_empty<u8>(arg0)) {
            (*0x1::vector::borrow<u8>(arg0, 0) as u64)
        } else {
            0
        };
        *0x1::vector::borrow<u64>(&v0, ((*0x1::vector::borrow<u8>(0x2::tx_context::digest(arg2), 0) as u64) + v2) % 0x1::vector::length<u64>(&v0))
    }

    fun generate_chest_order_and_multipliers(arg0: &vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : (vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 1;
        while (v1 <= 9) {
            0x1::vector::push_back<u64>(&mut v0, v1);
            v1 = v1 + 1;
        };
        v1 = 0x1::vector::length<u64>(&v0);
        while (v1 > 1) {
            let v2 = v1 - 1;
            v1 = v2;
            let v3 = if (v2 < 0x1::vector::length<u8>(arg0)) {
                (*0x1::vector::borrow<u8>(arg0, v2) as u64)
            } else {
                0
            };
            let v4 = ((v2 as u64) + (*0x1::vector::borrow<u8>(0x2::tx_context::digest(arg1), 0) as u64) + v3) % (v2 + 1);
            *0x1::vector::borrow_mut<u64>(&mut v0, v2) = *0x1::vector::borrow<u64>(&v0, v4);
            *0x1::vector::borrow_mut<u64>(&mut v0, v4) = *0x1::vector::borrow<u64>(&v0, v2);
        };
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, 24000);
        v1 = 0;
        while (v1 < 3) {
            0x1::vector::push_back<u64>(&mut v5, 18000);
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 5) {
            0x1::vector::push_back<u64>(&mut v5, 2000);
            v1 = v1 + 1;
        };
        v1 = 0x1::vector::length<u64>(&v5);
        while (v1 > 1) {
            let v6 = v1 - 1;
            v1 = v6;
            let v7 = if (v6 < 0x1::vector::length<u8>(arg0)) {
                (*0x1::vector::borrow<u8>(arg0, v6) as u64)
            } else {
                0
            };
            let v8 = ((v6 as u64) + (*0x1::vector::borrow<u8>(0x2::tx_context::digest(arg1), 0) as u64) + v7) % (v6 + 1);
            *0x1::vector::borrow_mut<u64>(&mut v5, v6) = *0x1::vector::borrow<u64>(&v5, v8);
            *0x1::vector::borrow_mut<u64>(&mut v5, v8) = *0x1::vector::borrow<u64>(&v5, v6);
        };
        (v0, v5)
    }

    fun generate_keno_numbers(arg0: &vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 1;
        while (v2 <= 40) {
            0x1::vector::push_back<u64>(&mut v1, v2);
            v2 = v2 + 1;
        };
        v2 = 0x1::vector::length<u64>(&v1);
        while (v2 > 1) {
            let v3 = v2 - 1;
            v2 = v3;
            let v4 = if (v3 < 0x1::vector::length<u8>(arg0)) {
                (*0x1::vector::borrow<u8>(arg0, v3) as u64)
            } else {
                0
            };
            let v5 = ((v3 as u64) + (*0x1::vector::borrow<u8>(0x2::tx_context::digest(arg1), 0) as u64) + v4) % (v3 + 1);
            *0x1::vector::borrow_mut<u64>(&mut v1, v3) = *0x1::vector::borrow<u64>(&v1, v5);
            *0x1::vector::borrow_mut<u64>(&mut v1, v5) = *0x1::vector::borrow<u64>(&v1, v3);
        };
        v2 = 0;
        while (v2 < 10) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::vector::borrow<u64>(&v1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    fun generate_mine_positions(arg0: &vector<u8>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : vector<vector<u64>> {
        let v0 = 0x1::vector::empty<vector<u64>>();
        let v1 = get_all_possible_coordinates();
        let v2 = 0x1::vector::length<vector<u64>>(&v1);
        while (v2 > 1) {
            v2 = v2 - 1;
            let v3 = if (v2 < 0x1::vector::length<u8>(arg0)) {
                (*0x1::vector::borrow<u8>(arg0, v2) as u64)
            } else {
                0
            };
            let v4 = ((v2 as u64) + (*0x1::vector::borrow<u8>(0x2::tx_context::digest(arg2), 0) as u64) + v3) % (v2 + 1);
            *0x1::vector::borrow_mut<vector<u64>>(&mut v1, v2) = *0x1::vector::borrow<vector<u64>>(&v1, v4);
            *0x1::vector::borrow_mut<vector<u64>>(&mut v1, v4) = *0x1::vector::borrow<vector<u64>>(&v1, v2);
        };
        let v5 = 0;
        while (v5 < (arg1 as u64)) {
            0x1::vector::push_back<vector<u64>>(&mut v0, *0x1::vector::borrow<vector<u64>>(&v1, v5));
            v5 = v5 + 1;
        };
        v0
    }

    fun get_all_possible_coordinates() : vector<vector<u64>> {
        let v0 = 0x1::vector::empty<vector<u64>>();
        let v1 = 0;
        while (v1 < 5) {
            let v2 = 0;
            while (v2 < 5) {
                let v3 = 0x1::vector::empty<u64>();
                0x1::vector::push_back<u64>(&mut v3, v1);
                0x1::vector::push_back<u64>(&mut v3, v2);
                0x1::vector::push_back<vector<u64>>(&mut v0, v3);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun get_max_multiplier(arg0: u8) : u64 {
        if (arg0 == 1) {
            1000000
        } else if (arg0 == 2) {
            10000000
        } else if (arg0 == 3) {
            10000000
        } else {
            assert!(arg0 == 4, 9);
            10000000
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameTreasury{id: 0x2::object::new(arg0)};
        let v1 = GameAdmin{id: 0x2::object::new(arg0)};
        let v2 = GameConfig{
            id                      : 0x2::object::new(arg0),
            mines_bonus_chance      : 100,
            mines_bonus_multiplier  : 20000,
            keno_bonus_chance       : 100,
            keno_bonus_multiplier   : 20000,
            quants_bonus_chance     : 100,
            quants_bonus_multiplier : 20000,
        };
        0x2::transfer::share_object<GameTreasury>(v0);
        0x2::transfer::share_object<GameConfig>(v2);
        0x2::transfer::transfer<GameAdmin>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_mine(arg0: &vector<vector<u64>>, arg1: &vector<u64>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u64>>(arg0)) {
            if (is_same_tile(0x1::vector::borrow<vector<u64>>(arg0, v0), arg1)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_same_tile(arg0: &vector<u64>, arg1: &vector<u64>) : bool {
        if (0x1::vector::length<u64>(arg0) == 2) {
            if (0x1::vector::length<u64>(arg1) == 2) {
                if (*0x1::vector::borrow<u64>(arg0, 0) == *0x1::vector::borrow<u64>(arg1, 0)) {
                    *0x1::vector::borrow<u64>(arg0, 1) == *0x1::vector::borrow<u64>(arg1, 1)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun keno_calc_mult(arg0: u8, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 <= 10, 10);
        if (arg1 != 10) {
            abort 10
        };
        assert!(arg2 <= arg1, 11);
        if (arg0 == 1) {
            if (arg2 == 0) {
                0
            } else if (arg2 == 1) {
                0
            } else if (arg2 == 2) {
                0
            } else if (arg2 == 3) {
                14000
            } else if (arg2 == 4) {
                22500
            } else if (arg2 == 5) {
                45000
            } else if (arg2 == 6) {
                80000
            } else if (arg2 == 7) {
                170000
            } else if (arg2 == 8) {
                500000
            } else if (arg2 == 9) {
                800000
            } else {
                assert!(arg2 == 10, 11);
                1000000
            }
        } else if (arg0 == 2) {
            if (arg2 == 0) {
                0
            } else if (arg2 == 1) {
                0
            } else if (arg2 == 2) {
                11000
            } else if (arg2 == 3) {
                12000
            } else if (arg2 == 4) {
                13000
            } else if (arg2 == 5) {
                18000
            } else if (arg2 == 6) {
                35000
            } else if (arg2 == 7) {
                130000
            } else if (arg2 == 8) {
                500000
            } else if (arg2 == 9) {
                2500000
            } else {
                assert!(arg2 == 10, 11);
                10000000
            }
        } else if (arg0 == 3) {
            if (arg2 == 0) {
                0
            } else if (arg2 == 1) {
                0
            } else if (arg2 == 2) {
                0
            } else if (arg2 == 3) {
                16000
            } else if (arg2 == 4) {
                20000
            } else if (arg2 == 5) {
                40000
            } else if (arg2 == 6) {
                70000
            } else if (arg2 == 7) {
                260000
            } else if (arg2 == 8) {
                1000000
            } else if (arg2 == 9) {
                5000000
            } else {
                assert!(arg2 == 10, 11);
                10000000
            }
        } else {
            assert!(arg0 == 4, 9);
            if (arg2 == 0) {
                0
            } else if (arg2 == 1) {
                0
            } else if (arg2 == 2) {
                0
            } else if (arg2 == 3) {
                0
            } else if (arg2 == 4) {
                35000
            } else if (arg2 == 5) {
                80000
            } else if (arg2 == 6) {
                130000
            } else if (arg2 == 7) {
                630000
            } else if (arg2 == 8) {
                5000000
            } else if (arg2 == 9) {
                8000000
            } else {
                assert!(arg2 == 10, 11);
                10000000
            }
        }
    }

    public entry fun play_keno<T0>(arg0: &mut GameTreasury, arg1: &GameConfig, arg2: u8, arg3: vector<u64>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1 && arg2 <= 4, 9);
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 > 0 && v0 <= 10, 10);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v2 > 0 && v2 <= 40, 10);
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < v0) {
            let v3 = v1 + 1;
            while (v3 < v0) {
                assert!(*0x1::vector::borrow<u64>(&arg3, v1) != *0x1::vector::borrow<u64>(&arg3, v3), 10);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        let v4 = 0x2::coin::value<T0>(&arg4);
        assert!(v4 > 0, 7);
        let v5 = 0x2::tx_context::sender(arg6);
        assert!(balance<T0>(arg0) >= safe_multiply_and_divide(v4, get_max_multiplier(arg2), 10000) + safe_multiply_and_divide(v4, arg1.keno_bonus_multiplier, 10000), 8);
        deposit<T0>(arg0, arg4);
        let v6 = 0x2::random::new_generator(arg5, arg6);
        let v7 = 0x2::random::generate_bytes(&mut v6, 32);
        let v8 = generate_keno_numbers(&v7, arg6);
        let v9 = count_matches(&arg3, &v8);
        let v10 = keno_calc_mult(arg2, v0, v9);
        let v11 = if (v10 > 0) {
            safe_multiply_and_divide(v4, v10, 10000)
        } else {
            0
        };
        let v12 = check_bonus_activation(&v7, arg1.keno_bonus_chance);
        let v13 = if (v12) {
            generate_bonus_keno_number(&v7, &v8, arg6)
        } else {
            0
        };
        let v14 = v13;
        let v15 = if (v12 && 0x1::vector::contains<u64>(&arg3, &v14)) {
            safe_multiply_and_divide(v4, arg1.keno_bonus_multiplier, 10000)
        } else {
            0
        };
        let v16 = v11 + v15;
        if (v16 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(game_withdraw<T0>(arg0, v16, arg6), v5);
        };
        let v17 = KenoResult{
            player           : v5,
            mode             : arg2,
            bet_amount       : v4,
            selected_numbers : arg3,
            drawn_numbers    : v8,
            matches          : v9,
            payout_amount    : v11,
            multiplier       : v10,
            coin_type        : coin_type_name<T0>(),
            seed             : v7,
            bonus_activated  : v12,
            bonus_number     : v14,
            bonus_amount     : v15,
        };
        0x2::event::emit<KenoResult>(v17);
    }

    public entry fun play_mines<T0>(arg0: &mut GameTreasury, arg1: &GameConfig, arg2: u8, arg3: vector<vector<u64>>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 < 25, 0);
        assert!(0x1::vector::length<vector<u64>>(&arg3) <= 25 - (arg2 as u64), 1);
        validate_tile_selection(&arg3);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 7);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(balance<T0>(arg0) >= safe_multiply_and_divide(v0, calculate_multiplier(arg2, 0x1::vector::length<vector<u64>>(&arg3)), 10000) + safe_multiply_and_divide(v0, arg1.mines_bonus_multiplier, 10000), 8);
        deposit<T0>(arg0, arg4);
        let v2 = 0x2::random::new_generator(arg5, arg6);
        let v3 = 0x2::random::generate_bytes(&mut v2, 32);
        let v4 = generate_mine_positions(&v3, arg2, arg6);
        let v5 = check_hit_mine(&v4, &arg3);
        let (v6, v7) = if (v5) {
            (0, 0)
        } else {
            let v8 = calculate_multiplier(arg2, 0x1::vector::length<vector<u64>>(&arg3));
            (safe_multiply_and_divide(v0, v8, 10000), v8)
        };
        let v9 = check_bonus_activation(&v3, arg1.mines_bonus_chance);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = 0;
        if (!v5 && v9) {
            v10 = generate_bonus_cell(&v3, &v4, arg6);
            if (0x1::vector::contains<vector<u64>>(&arg3, &v10)) {
                v11 = safe_multiply_and_divide(v0, arg1.mines_bonus_multiplier, 10000);
            };
        };
        let v12 = v6 + v11;
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(game_withdraw<T0>(arg0, v12, arg6), v1);
        };
        let v13 = GameResult{
            player          : v1,
            mine_count      : arg2,
            bet_amount      : v0,
            selected_tiles  : arg3,
            mine_positions  : v4,
            hit_mine        : v5,
            payout_amount   : v6,
            multiplier      : v7,
            coin_type       : coin_type_name<T0>(),
            seed            : v3,
            bonus_activated : v9,
            bonus_cell      : v10,
            bonus_amount    : v11,
        };
        0x2::event::emit<GameResult>(v13);
    }

    public entry fun play_quantchests<T0>(arg0: &mut GameTreasury, arg1: &GameConfig, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1 && arg2 <= 9, 16);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 7);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(balance<T0>(arg0) >= safe_multiply_and_divide(v0, 24000, 10000) + safe_multiply_and_divide(v0, arg1.quants_bonus_multiplier, 10000), 8);
        deposit<T0>(arg0, arg3);
        let v2 = 0x2::random::new_generator(arg4, arg5);
        let v3 = 0x2::random::generate_bytes(&mut v2, 32);
        let (v4, v5) = generate_chest_order_and_multipliers(&v3, arg5);
        let v6 = v5;
        let v7 = v4;
        let v8 = safe_multiply_and_divide(v0, *0x1::vector::borrow<u64>(&v6, find_position_in_vector(&v7, arg2)), 10000);
        let v9 = check_bonus_activation(&v3, arg1.quants_bonus_chance);
        let v10 = 0;
        let v11 = 0;
        if (v9) {
            let v12 = generate_bonus_chest(&v3, arg2, arg5);
            v10 = v12;
            if (arg2 == v12) {
                v11 = safe_multiply_and_divide(v0, arg1.quants_bonus_multiplier, 10000);
            };
        };
        let v13 = v8 + v11;
        if (v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(game_withdraw<T0>(arg0, v13, arg5), v1);
        };
        let v14 = QuantChestsResult{
            player          : v1,
            bet_amount      : v0,
            selected_number : arg2,
            chest_order     : v7,
            multipliers     : v6,
            payout_amount   : v8,
            coin_type       : coin_type_name<T0>(),
            seed            : v3,
            bonus_activated : v9,
            bonus_chest     : v10,
            bonus_amount    : v11,
        };
        0x2::event::emit<QuantChestsResult>(v14);
    }

    fun safe_multiply_and_divide(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 12);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 12);
        (v0 as u64)
    }

    public entry fun update_game_config(arg0: &GameAdmin, arg1: &mut GameConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg2 <= 10000, 13);
        assert!(arg4 <= 10000, 13);
        assert!(arg6 <= 10000, 13);
        assert!(arg3 > 0, 14);
        assert!(arg5 > 0, 14);
        assert!(arg7 > 0, 14);
        arg1.mines_bonus_chance = arg2;
        arg1.mines_bonus_multiplier = arg3;
        arg1.keno_bonus_chance = arg4;
        arg1.keno_bonus_multiplier = arg5;
        arg1.quants_bonus_chance = arg6;
        arg1.quants_bonus_multiplier = arg7;
    }

    fun validate_coordinates(arg0: &vector<u64>) {
        assert!(0x1::vector::length<u64>(arg0) == 2, 3);
        assert!(*0x1::vector::borrow<u64>(arg0, 0) < 5, 3);
        assert!(*0x1::vector::borrow<u64>(arg0, 1) < 5, 3);
    }

    fun validate_tile_selection(arg0: &vector<vector<u64>>) {
        let v0 = 0;
        let v1 = 0x1::vector::length<vector<u64>>(arg0);
        while (v0 < v1) {
            validate_coordinates(0x1::vector::borrow<vector<u64>>(arg0, v0));
            let v2 = v0 + 1;
            while (v2 < v1) {
                assert!(!is_same_tile(0x1::vector::borrow<vector<u64>>(arg0, v0), 0x1::vector::borrow<vector<u64>>(arg0, v2)), 2);
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
    }

    public fun withdraw<T0>(arg0: &mut GameTreasury, arg1: &GameAdmin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 7);
        let v0 = coin_type_name<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 8);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 8);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

