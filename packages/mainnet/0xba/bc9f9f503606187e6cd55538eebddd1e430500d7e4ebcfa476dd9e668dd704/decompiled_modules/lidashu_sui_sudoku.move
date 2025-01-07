module 0xbabc9f9f503606187e6cd55538eebddd1e430500d7e4ebcfa476dd9e668dd704::lidashu_sui_sudoku {
    struct SudokuLevel<phantom T0> has store, key {
        id: 0x2::object::UID,
        width: u64,
        level_data: vector<u8>,
        amount: u64,
        win_balance: 0x2::balance::Balance<T0>,
    }

    struct LidashuSudokuLevelSolved has copy, drop {
        level_id: 0x2::object::ID,
        solved_by: address,
    }

    struct LidashuSudokuLevelNotSolved has copy, drop {
        level_id: 0x2::object::ID,
        mismatch: 0x1::string::String,
        submitted_by: address,
    }

    public fun check_resolve(arg0: &vector<u8>, arg1: &vector<u8>) : (bool, 0x1::string::String) {
        let v0 = 0x1::vector::empty<0x2::vec_set::VecSet<u8>>();
        let v1 = 0x1::vector::empty<0x2::vec_set::VecSet<u8>>();
        let v2 = 0x1::vector::empty<0x2::vec_set::VecSet<u8>>();
        let v3 = 0;
        while (v3 < 9) {
            0x1::vector::push_back<0x2::vec_set::VecSet<u8>>(&mut v0, 0x2::vec_set::empty<u8>());
            0x1::vector::push_back<0x2::vec_set::VecSet<u8>>(&mut v1, 0x2::vec_set::empty<u8>());
            0x1::vector::push_back<0x2::vec_set::VecSet<u8>>(&mut v2, 0x2::vec_set::empty<u8>());
            v3 = v3 + 1;
        };
        let v4 = 0;
        while (v4 < 81) {
            let v5 = *0x1::vector::borrow<u8>(arg1, v4);
            let v6 = *0x1::vector::borrow<u8>(arg0, v4);
            if (v5 < 1 || v5 > 9) {
                return (false, 0x1::string::utf8(b"set_numer < 1 || set_numer > 9"))
            };
            if (v6 > 0 && v6 != v5) {
                return (false, 0x1::string::utf8(b"level_numer > 0 && level_numer != set_numer"))
            };
            let v7 = v4 / 9;
            let v8 = v4 % 9;
            let v9 = v7 / 3 * 3 + v8 / 3;
            let v10 = *0x1::vector::borrow<0x2::vec_set::VecSet<u8>>(&v0, v7);
            let v11 = *0x1::vector::borrow<0x2::vec_set::VecSet<u8>>(&v1, v8);
            let v12 = *0x1::vector::borrow<0x2::vec_set::VecSet<u8>>(&v2, v9);
            0x2::vec_set::insert<u8>(&mut v10, v5);
            0x2::vec_set::insert<u8>(&mut v11, v5);
            0x2::vec_set::insert<u8>(&mut v12, v5);
            *0x1::vector::borrow_mut<0x2::vec_set::VecSet<u8>>(&mut v0, v7) = v10;
            *0x1::vector::borrow_mut<0x2::vec_set::VecSet<u8>>(&mut v1, v8) = v11;
            *0x1::vector::borrow_mut<0x2::vec_set::VecSet<u8>>(&mut v2, v9) = v12;
            v4 = v4 + 1;
        };
        let v13 = 0;
        while (v13 < 9) {
            let v14 = *0x1::vector::borrow<0x2::vec_set::VecSet<u8>>(&v0, v13);
            let v15 = *0x1::vector::borrow<0x2::vec_set::VecSet<u8>>(&v1, v13);
            let v16 = *0x1::vector::borrow<0x2::vec_set::VecSet<u8>>(&v2, v13);
            if (0x2::vec_set::size<u8>(&v14) < 9) {
                return (false, 0x1::string::utf8(b"row_data mismatch"))
            };
            if (0x2::vec_set::size<u8>(&v15) < 9) {
                return (false, 0x1::string::utf8(b"col_data mismatch"))
            };
            if (0x2::vec_set::size<u8>(&v16) < 9) {
                return (false, 0x1::string::utf8(b"group_data mismatch"))
            };
            v13 = v13 + 1;
        };
        (true, 0x1::string::utf8(b"success"))
    }

    public fun mint_level<T0>(arg0: u64, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::balance_mut<T0>(arg3);
        let v1 = SudokuLevel<T0>{
            id          : 0x2::object::new(arg4),
            width       : arg0,
            level_data  : arg1,
            amount      : arg2,
            win_balance : 0x2::balance::split<T0>(v0, 0x2::balance::value<T0>(v0)),
        };
        0x2::transfer::public_transfer<SudokuLevel<T0>>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun solve_level<T0>(arg0: &mut SudokuLevel<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = check_resolve(&arg0.level_data, &arg1);
        if (v0 == true) {
            let v2 = LidashuSudokuLevelSolved{
                level_id  : 0x2::object::id<SudokuLevel<T0>>(arg0),
                solved_by : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<LidashuSudokuLevelSolved>(v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.win_balance, 0x2::clock::timestamp_ms(arg2) % arg0.amount, arg3), 0x2::tx_context::sender(arg3));
        } else {
            let v3 = LidashuSudokuLevelNotSolved{
                level_id     : 0x2::object::id<SudokuLevel<T0>>(arg0),
                mismatch     : v1,
                submitted_by : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<LidashuSudokuLevelNotSolved>(v3);
        };
    }

    // decompiled from Move bytecode v6
}

