module 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::player {
    struct GameInfo has key {
        id: 0x2::object::UID,
        task_id: 0x2::object::ID,
        checkerboard: vector<vector<0x1::ascii::Char>>,
        hash_code: vector<u8>,
    }

    struct PlayTooLate has copy, drop {
        loser: 0x1::ascii::String,
    }

    fun destroy_game_info(arg0: GameInfo) {
        let GameInfo {
            id           : v0,
            task_id      : _,
            checkerboard : _,
            hash_code    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun game_click(arg0: u64, arg1: u64, arg2: GameInfo, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 1 && arg0 <= 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::max_row() && arg1 >= 1 && arg1 <= 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::max_list(), 5);
        let v0 = arg0 - 1;
        let v1 = arg1 - 1;
        if (0x1::vector::length<u8>(&arg2.hash_code) == 0) {
            arg2.hash_code = 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::generate_hash(0x2::tx_context::epoch_timestamp_ms(arg3) % (v1 + v0 + 1), arg3);
        };
        let v2 = arg2.checkerboard;
        let v3 = arg2.hash_code;
        if (0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::confirm_safe(v0, v1, &v3)) {
            0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::dfs(v0, v1, &mut v2, &v3);
            if (0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::success_clear(&v2, &v3)) {
                0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::success_emit(0, &v2);
                destroy_game_info(arg2);
            } else {
                0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::emit(&v2);
                arg2.checkerboard = v2;
                0x2::transfer::transfer<GameInfo>(arg2, 0x2::tx_context::sender(arg3));
            };
        } else {
            let v4 = b"x";
            *0x1::vector::borrow_mut<0x1::ascii::Char>(0x1::vector::borrow_mut<vector<0x1::ascii::Char>>(&mut v2, v0), v1) = 0x1::ascii::char(*0x1::vector::borrow<u8>(&v4, 0));
            0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::failure_emit(&v2);
            destroy_game_info(arg2);
        };
    }

    entry fun game_click_task(arg0: &mut 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::admin::GameCap, arg1: u64, arg2: u64, arg3: GameInfo, arg4: &mut 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::task::TaskList, arg5: &mut 0x2::tx_context::TxContext) {
        if (!0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::task::contains(arg4, arg3.task_id)) {
            destroy_game_info(arg3);
            let v0 = PlayTooLate{loser: 0x1::ascii::string(b"The bounty mission has been completed!!!")};
            0x2::event::emit<PlayTooLate>(v0);
            return
        };
        let v1 = 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::task::borrow_task_mut(arg4, arg3.task_id);
        assert!(arg1 >= 1 && arg1 <= 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::max_row() && arg2 >= 1 && arg2 <= 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::max_list(), 5);
        let v2 = arg1 - 1;
        let v3 = arg2 - 1;
        if (0x1::vector::length<u8>(&arg3.hash_code) == 0) {
            arg3.hash_code = 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::generate_hash(0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::task::as_seed(v1), arg5);
        };
        let v4 = arg3.checkerboard;
        let v5 = arg3.hash_code;
        if (0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::confirm_safe(v2, v3, &v5)) {
            0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::dfs(v2, v3, &mut v4, &v5);
            if (0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::success_clear(&v4, &v5)) {
                0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::success_emit(0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::task::value(v1), &v4);
                0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::task::complete_task(arg0, arg3.task_id, arg4, arg5);
                destroy_game_info(arg3);
            } else {
                0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::emit(&v4);
                arg3.checkerboard = v4;
                0x2::transfer::transfer<GameInfo>(arg3, 0x2::tx_context::sender(arg5));
            };
        } else {
            let v6 = b"x";
            *0x1::vector::borrow_mut<0x1::ascii::Char>(0x1::vector::borrow_mut<vector<0x1::ascii::Char>>(&mut v4, v2), v3) = 0x1::ascii::char(*0x1::vector::borrow<u8>(&v6, 0));
            0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::task::failed_attempt(v1);
            0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::failure_emit(&v4);
            destroy_game_info(arg3);
        };
    }

    entry fun start_game(arg0: &mut 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::admin::GameCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 666, 2);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v0 = 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::admin::borrow_balance_mut(arg0);
        0x2::balance::join<0x2::sui::SUI>(v0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 666, arg2)));
        if (0x2::balance::value<0x2::sui::SUI>(v0) >= 10000000000) {
            0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::admin::withdraw_(arg0, arg2);
        };
        let v1 = 0x2::object::new(arg2);
        let v2 = GameInfo{
            id           : v1,
            task_id      : 0x2::object::uid_to_inner(&v1),
            checkerboard : 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::generate_empty_checkerboard(),
            hash_code    : b"",
        };
        0x2::transfer::transfer<GameInfo>(v2, 0x2::tx_context::sender(arg2));
    }

    entry fun start_task(arg0: 0x2::object::ID, arg1: &mut 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::task::TaskList, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::task::contains(arg1, arg0), 3);
        let v0 = 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::task::borrow_task_mut(arg1, arg0);
        0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::task::add_attempt(v0);
        0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::task::update(v0, arg2, arg3);
        let v1 = GameInfo{
            id           : 0x2::object::new(arg3),
            task_id      : arg0,
            checkerboard : 0x61fae5877c2d1a8005850bdcc4f7af8e9db748bd8934fd267cb962b0a2682cea::game::generate_empty_checkerboard(),
            hash_code    : b"",
        };
        0x2::transfer::transfer<GameInfo>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

