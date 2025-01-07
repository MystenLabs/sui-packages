module 0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_board_8192 {
    struct GameBoard8192 has copy, drop, store {
        packed_spaces: u64,
        score: u64,
        last_tile: vector<u64>,
        top_tile: u64,
        game_over: bool,
    }

    struct SpacePosition has copy, drop {
        row: u8,
        column: u8,
    }

    fun add_new_tile(arg0: &mut GameBoard8192, arg1: u64, arg2: vector<u8>) : u64 {
        let v0 = empty_space_positions(arg0, arg1);
        let v1 = 0x1::vector::length<SpacePosition>(&v0);
        assert!(v1 > 0, 2);
        let v2 = 1;
        let v3 = *top_tile(arg0);
        if (v3 >= 13 && *0x1::vector::borrow<u8>(&arg2, 0) % 6 == 0) {
            v2 = 5;
        } else if (v3 >= 12 && *0x1::vector::borrow<u8>(&arg2, 0) % 5 == 0) {
            v2 = 4;
        } else if (v3 >= 11 && *0x1::vector::borrow<u8>(&arg2, 0) % 4 == 0) {
            v2 = 3;
        } else if (*0x1::vector::borrow<u8>(&arg2, 0) % 4 == 0) {
            v2 = 2;
        };
        let v4 = 0x1::vector::borrow<SpacePosition>(&v0, (*0x1::vector::borrow<u8>(&arg2, 1) as u64) % v1);
        arg0.packed_spaces = fill_in_space_at(arg0.packed_spaces, v4.row, v4.column, v2);
        let v5 = 0x1::vector::empty<u64>();
        let v6 = &mut v5;
        0x1::vector::push_back<u64>(v6, (v4.row as u64));
        0x1::vector::push_back<u64>(v6, (v4.column as u64));
        0x1::vector::push_back<u64>(v6, (v2 as u64));
        arg0.last_tile = v5;
        v2
    }

    public(friend) fun board_space_at(arg0: &GameBoard8192, arg1: u8, arg2: u8) : u64 {
        space_at(arg0.packed_spaces, arg1, arg2)
    }

    public(friend) fun column_count() : u8 {
        4
    }

    public(friend) fun default(arg0: vector<u8>) : GameBoard8192 {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 3);
        0x1::vector::push_back<u64>(v1, 1);
        0x1::vector::push_back<u64>(v1, (1 as u64));
        GameBoard8192{
            packed_spaces : fill_in_space_at(fill_in_space_at(0, *0x1::vector::borrow<u8>(&arg0, 1) % 2, *0x1::vector::borrow<u8>(&arg0, 2) % 4, 1), *0x1::vector::borrow<u8>(&arg0, 3) % 2 + 2, *0x1::vector::borrow<u8>(&arg0, 4) % 4, 1),
            score         : 0,
            last_tile     : v0,
            top_tile      : 1,
            game_over     : false,
        }
    }

    public fun down() : u64 {
        3
    }

    public(friend) fun empty_space_count(arg0: &GameBoard8192) : u64 {
        let v0 = empty_space_positions(arg0, 4);
        0x1::vector::length<SpacePosition>(&v0)
    }

    public(friend) fun empty_space_positions(arg0: &GameBoard8192, arg1: u64) : vector<SpacePosition> {
        let v0 = 0x1::vector::empty<SpacePosition>();
        let v1 = 4;
        let v2 = 4;
        let v3 = 0;
        let v4 = 0;
        if (arg1 != 4) {
            if (arg1 == 0) {
                v3 = 0;
                v4 = 3;
            } else if (arg1 == 1) {
                v2 = 1;
            } else if (arg1 == 2) {
                v3 = 3;
                v4 = 0;
            } else if (arg1 == 3) {
                v1 = 1;
            };
        };
        let v5 = v3;
        while (v5 < v1) {
            let v6 = v4;
            while (v6 < v2) {
                if (board_space_at(arg0, v5, v6) == 0) {
                    let v7 = SpacePosition{
                        row    : v5,
                        column : v6,
                    };
                    0x1::vector::push_back<SpacePosition>(&mut v0, v7);
                };
                v6 = v6 + 1;
            };
            v5 = v5 + 1;
        };
        v0
    }

    fun fill_in_space_at(arg0: u64, arg1: u8, arg2: u8, arg3: u64) : u64 {
        arg0 | arg3 << 4 * (arg2 + arg1 * 4)
    }

    public(friend) fun game_over(arg0: &GameBoard8192) : &bool {
        &arg0.game_over
    }

    public(friend) fun last_tile(arg0: &GameBoard8192) : &vector<u64> {
        &arg0.last_tile
    }

    public fun left() : u64 {
        0
    }

    public(friend) fun move_direction(arg0: &mut GameBoard8192, arg1: u64, arg2: vector<u8>) {
        assert!(!arg0.game_over, 3);
        let (v0, v1, v2) = move_spaces(arg0.packed_spaces, arg1);
        let v3 = v1;
        arg0.packed_spaces = v0;
        if (arg0.packed_spaces == arg0.packed_spaces) {
            if (!move_possible(arg0)) {
                arg0.game_over = true;
            };
            return
        };
        arg0.score = arg0.score + v2;
        let v4 = add_new_tile(arg0, arg1, arg2);
        if (v4 > v1) {
            v3 = v4;
        };
        arg0.top_tile = v3;
        if (!move_possible(arg0)) {
            arg0.game_over = true;
        };
    }

    fun move_possible(arg0: &GameBoard8192) : bool {
        let v0 = 4;
        let v1 = 4;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0;
            while (v3 < v1) {
                let v4 = board_space_at(arg0, v2, v3);
                if (v4 == 0) {
                    return true
                };
                if (v3 < v1 - 1) {
                    let v5 = board_space_at(arg0, v2, v3 + 1);
                    if (v5 == 0 || v5 == v4) {
                        return true
                    };
                };
                if (v2 < v0 - 1) {
                    let v6 = board_space_at(arg0, v2 + 1, v3);
                    if (v6 == 0 || v6 == v4) {
                        return true
                    };
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        false
    }

    fun move_spaces(arg0: u64, arg1: u64) : (u64, u64, u64) {
        let v0 = 1;
        let v1 = 0;
        let v2 = 0;
        if (arg1 == 3) {
            v2 = 4 - 1;
        };
        let v3 = 0;
        if (arg1 == 1) {
            v3 = 4 - 1;
        };
        let v4 = 99;
        let (v5, v6, v7, v8) = spaces_at(arg0, v2, v3, arg1);
        let v9 = v8;
        let v10 = v7;
        let v11 = v6;
        let v12 = v5;
        let v13 = v5;
        let v14 = v6;
        let v15 = v7;
        let v16 = v8;
        let v17 = 1;
        let v18 = 2;
        loop {
            if (v18 > 4) {
                arg0 = save_spaces(arg0, v2, v3, v12, v11, v10, v9, v13 != v12, v14 != v11, v15 != v10, v16 != v9, arg1);
                let v19 = next_row(v2, arg1);
                v2 = v19;
                let v20 = next_column(v3, arg1);
                v3 = v20;
                if (!valid_row(v19) || !valid_column(v20)) {
                    break
                };
                let (v21, v22, v23, v24) = spaces_at(arg0, v19, v20, arg1);
                v9 = v24;
                v10 = v23;
                v11 = v22;
                v12 = v21;
                v4 = 99;
                v13 = v21;
                v14 = v22;
                v15 = v23;
                v16 = v24;
                v17 = 1;
                v18 = 2;
            };
            let v25 = if (v17 == 1) {
                v12
            } else if (v17 == 2) {
                v11
            } else if (v17 == 3) {
                v10
            } else {
                v9
            };
            let v26 = if (v18 == 1) {
                v12
            } else if (v18 == 2) {
                v11
            } else if (v18 == 3) {
                v10
            } else {
                v9
            };
            if (v25 == 0) {
                v4 = v17;
            } else if (v25 > v0) {
                v0 = v25;
            };
            if (v26 == 0) {
                if (v4 == 99) {
                    v4 = v18;
                };
            } else if (v26 == v25) {
                let v27 = 2;
                let v28 = v25;
                while (v28 > 0) {
                    v27 = v27 * 2;
                    v28 = v28 - 1;
                };
                v1 = v1 + v27;
                if (v25 + 1 > v0) {
                    v0 = v25 + 1;
                };
                if (v17 == 1) {
                    v12 = v25 + 1;
                } else if (v17 == 2) {
                    v11 = v25 + 1;
                } else if (v17 == 3) {
                    v10 = v25 + 1;
                } else {
                    v9 = v25 + 1;
                };
                if (v18 == 1) {
                    v12 = 0;
                } else if (v18 == 2) {
                    v11 = 0;
                } else if (v18 == 3) {
                    v10 = 0;
                } else {
                    v9 = 0;
                };
                if (v4 != 99) {
                    v17 = v4;
                } else {
                    v17 = v18;
                };
                v18 = v17;
            } else if (v26 != v25) {
                if (v4 != 99) {
                    if (v4 == 1) {
                        v12 = v26;
                    } else if (v4 == 2) {
                        v11 = v26;
                    } else if (v4 == 3) {
                        v10 = v26;
                    } else {
                        v9 = v26;
                    };
                    if (v18 == 1) {
                        v12 = 0;
                    } else if (v18 == 2) {
                        v11 = 0;
                    } else if (v18 == 3) {
                        v10 = 0;
                    } else {
                        v9 = 0;
                    };
                    v17 = v4;
                    v18 = v4;
                    v4 = 99;
                } else {
                    v17 = v18;
                };
            };
            v18 = v18 + 1;
        };
        (arg0, v0, v1)
    }

    fun next_column(arg0: u8, arg1: u64) : u8 {
        if (arg1 == 3 || arg1 == 2) {
            return arg0 + 1
        };
        arg0
    }

    fun next_row(arg0: u8, arg1: u64) : u8 {
        if (arg1 == 1 || arg1 == 0) {
            return arg0 + 1
        };
        arg0
    }

    public(friend) fun packed_spaces(arg0: &GameBoard8192) : &u64 {
        &arg0.packed_spaces
    }

    fun replace_value_at(arg0: u64, arg1: u8, arg2: u8, arg3: u64) : u64 {
        let v0 = 4 * (arg2 + arg1 * 4);
        arg0 & (15 << v0 ^ 18446744073709551615) | arg3 << v0
    }

    public fun right() : u64 {
        1
    }

    public(friend) fun row_count() : u8 {
        4
    }

    fun save_spaces(arg0: u64, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: bool, arg10: bool, arg11: u64) : u64 {
        if (arg11 == 0) {
            if (arg7) {
                arg0 = replace_value_at(arg0, arg1, 0, arg3);
            };
            if (arg8) {
                arg0 = replace_value_at(arg0, arg1, 1, arg4);
            };
            if (arg9) {
                arg0 = replace_value_at(arg0, arg1, 2, arg5);
            };
            if (arg10) {
                arg0 = replace_value_at(arg0, arg1, 3, arg6);
            };
        } else if (arg11 == 1) {
            if (arg7) {
                arg0 = replace_value_at(arg0, arg1, 3, arg3);
            };
            if (arg8) {
                arg0 = replace_value_at(arg0, arg1, 2, arg4);
            };
            if (arg9) {
                arg0 = replace_value_at(arg0, arg1, 1, arg5);
            };
            if (arg10) {
                arg0 = replace_value_at(arg0, arg1, 0, arg6);
            };
        } else if (arg11 == 2) {
            if (arg7) {
                arg0 = replace_value_at(arg0, 0, arg2, arg3);
            };
            if (arg8) {
                arg0 = replace_value_at(arg0, 1, arg2, arg4);
            };
            if (arg9) {
                arg0 = replace_value_at(arg0, 2, arg2, arg5);
            };
            if (arg10) {
                arg0 = replace_value_at(arg0, 3, arg2, arg6);
            };
        } else if (arg11 == 3) {
            if (arg7) {
                arg0 = replace_value_at(arg0, 3, arg2, arg3);
            };
            if (arg8) {
                arg0 = replace_value_at(arg0, 2, arg2, arg4);
            };
            if (arg9) {
                arg0 = replace_value_at(arg0, 1, arg2, arg5);
            };
            if (arg10) {
                arg0 = replace_value_at(arg0, 0, arg2, arg6);
            };
        };
        arg0
    }

    public(friend) fun score(arg0: &GameBoard8192) : &u64 {
        &arg0.score
    }

    public(friend) fun space_at(arg0: u64, arg1: u8, arg2: u8) : u64 {
        arg0 >> (arg1 * 4 + arg2) * 4 & 15
    }

    fun spaces_at(arg0: u64, arg1: u8, arg2: u8, arg3: u64) : (u64, u64, u64, u64) {
        if (arg3 == 0) {
            (space_at(arg0, arg1, 0), space_at(arg0, arg1, 1), space_at(arg0, arg1, 2), space_at(arg0, arg1, 3))
        } else if (arg3 == 1) {
            (space_at(arg0, arg1, 3), space_at(arg0, arg1, 2), space_at(arg0, arg1, 1), space_at(arg0, arg1, 0))
        } else if (arg3 == 2) {
            (space_at(arg0, 0, arg2), space_at(arg0, 1, arg2), space_at(arg0, 2, arg2), space_at(arg0, 3, arg2))
        } else {
            (space_at(arg0, 3, arg2), space_at(arg0, 2, arg2), space_at(arg0, 1, arg2), space_at(arg0, 0, arg2))
        }
    }

    public(friend) fun top_tile(arg0: &GameBoard8192) : &u64 {
        &arg0.top_tile
    }

    public fun up() : u64 {
        2
    }

    fun valid_column(arg0: u8) : bool {
        arg0 >= 0 && arg0 < 4
    }

    fun valid_row(arg0: u8) : bool {
        arg0 >= 0 && arg0 < 4
    }

    // decompiled from Move bytecode v6
}

